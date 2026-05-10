import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/achievement_badge.dart';
import '../models/difficulty.dart';
import '../providers/content_provider.dart';
import '../providers/session_provider.dart';
import '../providers/timer_provider.dart';
import '../theme.dart';
import '../widgets/achievement_badge.dart';
import '../widgets/practice_timer_display.dart';

class PracticeSummaryScreen extends ConsumerWidget {
  const PracticeSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final elapsed = ref.watch(timerProvider);

    final difficulty = session.difficulty ?? Difficulty.easy;
    final categoryId = session.categoryId ?? '';

    final repo = ref.read(contentRepositoryProvider);
    final cardCountFuture = repo.getFlashcardCount(categoryId, difficulty);
    final next = nextDifficulty(difficulty);

    void onTryNextLevel() => context.go('/categories?difficulty=${next.name}');

    void onTryAgain() {
      ref.read(sessionProvider.notifier).resetSession();
      ref.read(timerProvider.notifier).reset();
      context.go(
        '/flashcard?categoryId=$categoryId&difficulty=${difficulty.name}',
      );
    }

    void onHome() {
      ref.read(sessionProvider.notifier).exitSession();
      ref.read(timerProvider.notifier).reset();
      context.go('/');
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing24,
            vertical: AppTheme.spacing24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  const Icon(
                    Icons.bar_chart_rounded,
                    color: AppTheme.colorPrimary,
                    size: 24,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Session Summary',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing24),
              // Badge
              FutureBuilder<int>(
                future: cardCountFuture,
                builder: (context, snapshot) {
                  final cardCount = snapshot.data ?? 0;
                  final badge = AchievementBadge.tierFor(cardCount, elapsed);
                  return Center(
                    child: AchievementBadgeWidget(
                      badge: badge,
                      sessionTime: elapsed,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppTheme.spacing24),
              // Stats card
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                decoration: BoxDecoration(
                  color: AppTheme.colorSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.colorBorder, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      icon: Icons.timer_rounded,
                      iconColor: AppTheme.colorBlue,
                      label: 'Time',
                      value: PracticeTimerDisplay.format(elapsed),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppTheme.colorBorder,
                    ),
                    FutureBuilder<int>(
                      future: cardCountFuture,
                      builder: (context, snapshot) {
                        final cardCount = snapshot.data ?? 0;
                        return _StatItem(
                          icon: Icons.style_rounded,
                          iconColor: AppTheme.colorPrimary,
                          label: 'Cards',
                          value: '$cardCount',
                        );
                      },
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppTheme.colorBorder,
                    ),
                    _StatItem(
                      icon: Icons.bolt_rounded,
                      iconColor: _difficultyColor(difficulty),
                      label: 'Level',
                      value:
                          difficulty.name[0].toUpperCase() +
                          difficulty.name.substring(1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacing32),
              // Action buttons
              ElevatedButton.icon(
                onPressed: onTryNextLevel,
                icon: const Icon(Icons.arrow_upward_rounded),
                label: const Text('Try next level'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.colorPrimary,
                  foregroundColor: AppTheme.colorTextOnColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacing16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              OutlinedButton.icon(
                onPressed: onTryAgain,
                icon: const Icon(Icons.replay_rounded),
                label: const Text('Try again'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.colorTextPrimary,
                  side: const BorderSide(color: AppTheme.colorBorder, width: 2),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacing16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              TextButton.icon(
                onPressed: onHome,
                icon: const Icon(Icons.home_rounded),
                label: const Text('Home'),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.colorTextSecondary,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacing16,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
            ],
          ),
        ),
      ),
    );
  }

  Color _difficultyColor(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return AppTheme.colorPrimary;
      case Difficulty.medium:
        return AppTheme.colorBlue;
      case Difficulty.hard:
        return AppTheme.colorCoral;
    }
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
