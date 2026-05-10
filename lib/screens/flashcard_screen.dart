import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/difficulty.dart';
import '../models/flashcard.dart';
import '../models/flashcard_set.dart';
import '../providers/content_provider.dart';
import '../providers/session_provider.dart';
import '../providers/timer_provider.dart';
import '../theme.dart';
import '../widgets/flashcard_card.dart';
import '../widgets/nav_arrow_button.dart';
import '../widgets/practice_timer_display.dart';
import '../widgets/progress_indicator.dart';

class FlashcardScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String difficulty;

  const FlashcardScreen({
    super.key,
    required this.categoryId,
    required this.difficulty,
  });

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  bool _initialized = false;
  int _slideDirection = 1;

  // Swipe drag state
  double _dragOffset = 0;
  bool _isDragging = false;

  // Snap-back animation after a cancelled drag
  late final AnimationController _snapController;
  late Animation<double> _snapAnimation;

  static const double _swipeThreshold = 100.0;

  Difficulty _parseDifficulty(String value) {
    return Difficulty.values.firstWhere(
      (d) => d.name == value,
      orElse: () => Difficulty.easy,
    );
  }

  @override
  void initState() {
    super.initState();
    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _snapAnimation = Tween<double>(begin: 0, end: 0).animate(_snapController);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    if (!mounted) return;

    final difficulty = _parseDifficulty(widget.difficulty);
    final repo = ref.read(contentRepositoryProvider);

    FlashcardSet? flashcardSet;
    try {
      flashcardSet = await repo.getFlashcardSet(widget.categoryId, difficulty);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to load cards. Check your connection.'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: _initialize,
          ),
        ),
      );
      return;
    }

    if (!mounted) return;

    if (flashcardSet == null || flashcardSet.cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No exercises available for this combination'),
        ),
      );
      context.pop();
      return;
    }

    ref
        .read(sessionProvider.notifier)
        .startSession(difficulty, widget.categoryId, flashcardSet);

    final timerNotifier = ref.read(timerProvider.notifier);
    if (!timerNotifier.isActive) timerNotifier.start();

    setState(() {
      _initialized = true;
    });
  }

  // ── Swipe handlers ──────────────────────────────────────────────────────

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      _dragOffset += details.delta.dx;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragOffset > _swipeThreshold) {
      _commitSwipe(good: true);
    } else if (_dragOffset < -_swipeThreshold) {
      _commitSwipe(good: false);
    } else {
      _snapBack();
    }
  }

  void _commitSwipe({required bool good}) {
    setState(() {
      _isDragging = false;
      _dragOffset = 0;
    });

    final notifier = ref.read(sessionProvider.notifier);
    if (good) {
      notifier.markGood();
    } else {
      notifier.markBad();
    }

    final session = ref.read(sessionProvider);
    if (session.isComplete) {
      ref.read(timerProvider.notifier).stop();
      context.go('/complete');
    }
  }

  void _snapBack() {
    _snapAnimation = Tween<double>(begin: _dragOffset, end: 0).animate(
      CurvedAnimation(parent: _snapController, curve: Curves.elasticOut),
    );
    _snapController.forward(from: 0).then((_) {
      if (mounted) setState(() => _dragOffset = 0);
    });
    setState(() => _isDragging = false);
  }

  // ── Legacy arrow nav ────────────────────────────────────────────────────

  void _onNext() {
    final session = ref.read(sessionProvider);
    final deck = ref.read(sessionProvider.notifier).activeDeck;
    final isLast = session.currentIndex >= deck.length - 1;

    setState(() => _slideDirection = 1);
    ref.read(sessionProvider.notifier).nextCard();

    if (isLast) {
      ref.read(timerProvider.notifier).stop();
      context.go('/complete');
    }
  }

  void _onPrev() {
    setState(() => _slideDirection = -1);
    ref.read(sessionProvider.notifier).prevCard();
  }

  void _onExit() {
    ref.read(timerProvider.notifier).stop();
    ref.read(sessionProvider.notifier).exitSession();
    context.go('/categories?difficulty=${widget.difficulty}');
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final elapsed = ref.watch(timerProvider);
    final notifier = ref.read(sessionProvider.notifier);
    final deck = notifier.activeDeck;

    if (!_initialized || deck.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentCard = deck[session.currentIndex];
    final isFirst = session.currentIndex == 0;

    // Effective drag offset: either live drag or snap-back animation
    final effectiveDrag = _isDragging
        ? _dragOffset
        : (_snapController.isAnimating ? _snapAnimation.value : 0.0);

    final swipeProgress = (effectiveDrag / _swipeThreshold).clamp(-1.0, 1.0);
    final tiltAngle = swipeProgress * 0.12; // radians, max ~7°

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          color: AppTheme.colorCoral,
          onPressed: _onExit,
          tooltip: 'Exit session',
        ),
        title: SessionProgressIndicator(
          currentIndex: session.currentIndex,
          total: deck.length,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacing12),
            child: PracticeTimerDisplay(elapsed: elapsed),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing16,
          ),
          child: Column(
            children: [
              // Retry round banner
              if (session.isRetryRound) ...[
                _RetryBanner(badCount: session.badCardIds.length),
                const SizedBox(height: AppTheme.spacing12),
              ],
              // Swipe hint labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SwipeHint(
                    label: 'Not yet',
                    icon: Icons.close_rounded,
                    color: AppTheme.colorCoral,
                    opacity: swipeProgress < 0
                        ? (-swipeProgress).clamp(0.0, 1.0)
                        : 0.0,
                  ),
                  _SwipeHint(
                    label: 'Got it!',
                    icon: Icons.check_rounded,
                    color: AppTheme.colorPrimary,
                    opacity: swipeProgress > 0
                        ? swipeProgress.clamp(0.0, 1.0)
                        : 0.0,
                    rightAligned: true,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing8),
              // Swipeable flashcard
              Expanded(
                child: GestureDetector(
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                  child: AnimatedBuilder(
                    animation: _snapController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..translate(effectiveDrag, 0.0)
                          ..rotateZ(tiltAngle),
                        child: child,
                      );
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        final offset =
                            Tween<Offset>(
                              begin: Offset(_slideDirection.toDouble(), 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            );
                        return SlideTransition(position: offset, child: child);
                      },
                      child: _SwipeableCard(
                        key: ValueKey(
                          '${session.currentIndex}-${currentCard.id}',
                        ),
                        card: currentCard,
                        swipeProgress: swipeProgress,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              // Swipe instruction hint
              Text(
                '← Not yet  ·  Got it! →',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.colorTextSecondary.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              // Arrow nav row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavArrowButton(
                    direction: NavDirection.prev,
                    onTap: isFirst ? null : _onPrev,
                  ),
                  NavArrowButton(direction: NavDirection.next, onTap: _onNext),
                ],
              ),
              const SizedBox(height: AppTheme.spacing8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Swipeable card with colored overlay ─────────────────────────────────────

class _SwipeableCard extends StatelessWidget {
  final Flashcard card;
  final double swipeProgress; // -1.0 (full left) to 1.0 (full right)

  const _SwipeableCard({
    super.key,
    required this.card,
    required this.swipeProgress,
  });

  @override
  Widget build(BuildContext context) {
    final goodOpacity = swipeProgress > 0 ? swipeProgress.clamp(0.0, 0.5) : 0.0;
    final badOpacity = swipeProgress < 0
        ? (-swipeProgress).clamp(0.0, 0.5)
        : 0.0;

    return Stack(
      children: [
        FlashcardCard(flashcard: card),
        // Green overlay — "got it"
        if (goodOpacity > 0)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.colorPrimary.withValues(alpha: goodOpacity),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        // Red overlay — "not yet"
        if (badOpacity > 0)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.colorCoral.withValues(alpha: badOpacity),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Swipe hint label (fades in as you drag) ──────────────────────────────────

class _SwipeHint extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final double opacity;
  final bool rightAligned;

  const _SwipeHint({
    required this.label,
    required this.icon,
    required this.color,
    required this.opacity,
    this.rightAligned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: rightAligned
              ? [
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(icon, color: color, size: 16),
                ]
              : [
                  Icon(icon, color: color, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}

// ── Retry round banner ───────────────────────────────────────────────────────

class _RetryBanner extends StatelessWidget {
  final int badCount;
  const _RetryBanner({required this.badCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing16,
        vertical: AppTheme.spacing8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.colorYellow.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.colorYellow.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.replay_rounded,
            color: AppTheme.colorYellowDark,
            size: 18,
          ),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              'Almost there! $badCount card${badCount == 1 ? '' : 's'} to review',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.colorYellowDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
