import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/difficulty.dart';
import '../providers/content_provider.dart';
import '../theme.dart';
import '../widgets/category_tile.dart';

class CategoryListScreen extends ConsumerWidget {
  final String difficulty;

  const CategoryListScreen({super.key, required this.difficulty});

  Difficulty _parseDifficulty(String value) {
    return Difficulty.values.firstWhere(
      (d) => d.name == value,
      orElse: () => Difficulty.easy,
    );
  }

  void _onCategoryTapped(BuildContext context, WidgetRef ref, String categoryId) {
    final repo = ref.read(contentRepositoryProvider);
    final diff = _parseDifficulty(difficulty);
    final flashcardSet = repo.getFlashcardSet(categoryId, diff);

    if (flashcardSet == null || flashcardSet.cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No exercises available for this combination'),
        ),
      );
      context.pop();
      return;
    }

    context.push('/flashcard?categoryId=$categoryId&difficulty=$difficulty');
  }

  _DifficultyBadgeStyle _badgeStyle(Difficulty diff) {
    switch (diff) {
      case Difficulty.easy:
        return _DifficultyBadgeStyle(
          label: 'Easy',
          icon: Icons.sentiment_satisfied_alt_rounded,
          color: AppTheme.colorPrimary,
        );
      case Difficulty.medium:
        return _DifficultyBadgeStyle(
          label: 'Medium',
          icon: Icons.local_fire_department_rounded,
          color: AppTheme.colorBlue,
        );
      case Difficulty.hard:
        return _DifficultyBadgeStyle(
          label: 'Hard',
          icon: Icons.bolt_rounded,
          color: AppTheme.colorCoral,
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(contentRepositoryProvider).getCategories();
    final diff = _parseDifficulty(difficulty);
    final badge = _badgeStyle(diff);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
        automaticallyImplyLeading: false,
        title: const Text('Choose a Category'),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Difficulty badge header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing16,
                  vertical: AppTheme.spacing12,
                ),
                decoration: BoxDecoration(
                  color: badge.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: badge.color.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(badge.icon, color: badge.color, size: 20),
                    const SizedBox(width: AppTheme.spacing8),
                    Text(
                      '${badge.label} difficulty selected',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: badge.color,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              // Category list
              ...List.generate(categories.length, (index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                  child: CategoryTile(
                    category: category,
                    onTap: () => _onCategoryTapped(context, ref, category.id),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _DifficultyBadgeStyle {
  final String label;
  final IconData icon;
  final Color color;
  const _DifficultyBadgeStyle({
    required this.label,
    required this.icon,
    required this.color,
  });
}
