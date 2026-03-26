import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/difficulty.dart';
import '../models/flashcard.dart';
import '../models/flashcard_set.dart';
import '../models/session_state.dart';

class SessionNotifier extends StateNotifier<SessionState> {
  /// The original ordered deck.
  List<Flashcard> _originalCards = [];
  /// The current active deck (either original or retry round).
  List<Flashcard> _activeDeck = [];

  SessionNotifier() : super(const SessionState());

  List<Flashcard> get activeDeck => _activeDeck;

  void startSession(Difficulty difficulty, String categoryId, FlashcardSet flashcardSet) {
    _originalCards = List.of(flashcardSet.cards);
    _activeDeck = List.of(_originalCards);
    state = SessionState(
      difficulty: difficulty,
      categoryId: categoryId,
      currentIndex: 0,
      elapsed: Duration.zero,
      isComplete: false,
      badCardIds: const {},
      isRetryRound: false,
    );
  }

  /// Swipe right — mark current card as good and advance.
  void markGood() {
    final idx = state.currentIndex;
    final newBadIds = Set<String>.from(state.badCardIds)
      ..remove(_activeDeck[idx].id);
    _advance(newBadIds);
  }

  /// Swipe left — mark current card as bad and advance.
  void markBad() {
    final idx = state.currentIndex;
    final newBadIds = Set<String>.from(state.badCardIds)
      ..add(_activeDeck[idx].id);
    _advance(newBadIds);
  }

  void _advance(Set<String> updatedBadIds) {
    final isLastCard = state.currentIndex >= _activeDeck.length - 1;

    if (!isLastCard) {
      // Still cards left in this round — just move forward.
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        badCardIds: updatedBadIds,
      );
      return;
    }

    // Reached the end of the current deck.
    if (updatedBadIds.isEmpty) {
      // All cards mastered — session complete.
      state = state.copyWith(
        badCardIds: updatedBadIds,
        isComplete: true,
      );
      return;
    }

    // There are still bad cards — start a retry round with only those.
    _activeDeck = _originalCards
        .where((c) => updatedBadIds.contains(c.id))
        .toList();

    state = state.copyWith(
      currentIndex: 0,
      badCardIds: updatedBadIds,
      isRetryRound: true,
      isComplete: false,
    );
  }

  // ── Legacy nav (arrow buttons still work) ──────────────────────────────

  void nextCard() {
    if (state.currentIndex >= _activeDeck.length - 1) {
      completeSession();
    } else {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void prevCard() {
    if (state.currentIndex == 0) return;
    state = state.copyWith(currentIndex: state.currentIndex - 1);
  }

  void completeSession() {
    state = state.copyWith(isComplete: true);
  }

  void resetSession() {
    _activeDeck = List.of(_originalCards);
    state = state.copyWith(
      currentIndex: 0,
      isComplete: false,
      badCardIds: const {},
      isRetryRound: false,
    );
  }

  void exitSession() {
    _originalCards = [];
    _activeDeck = [];
    state = const SessionState();
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier();
});
