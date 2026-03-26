import 'difficulty.dart';

class SessionState {
  final Difficulty? difficulty;
  final String? categoryId;
  final int currentIndex;
  final Duration elapsed;
  final bool isComplete;
  /// IDs of cards the user marked as "not good" (swiped left).
  /// After the main deck finishes, these are replayed until the set is empty.
  final Set<String> badCardIds;
  /// Whether we are currently in the "retry bad cards" round.
  final bool isRetryRound;

  const SessionState({
    this.difficulty,
    this.categoryId,
    this.currentIndex = 0,
    this.elapsed = Duration.zero,
    this.isComplete = false,
    this.badCardIds = const {},
    this.isRetryRound = false,
  });

  SessionState copyWith({
    Difficulty? difficulty,
    String? categoryId,
    int? currentIndex,
    Duration? elapsed,
    bool? isComplete,
    Set<String>? badCardIds,
    bool? isRetryRound,
  }) {
    return SessionState(
      difficulty: difficulty ?? this.difficulty,
      categoryId: categoryId ?? this.categoryId,
      currentIndex: currentIndex ?? this.currentIndex,
      elapsed: elapsed ?? this.elapsed,
      isComplete: isComplete ?? this.isComplete,
      badCardIds: badCardIds ?? this.badCardIds,
      isRetryRound: isRetryRound ?? this.isRetryRound,
    );
  }
}
