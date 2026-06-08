import 'dart:math';

import '../models/flashcard.dart';

/// Shuffles the given [cards] and returns the first [count] cards.
/// If [count] >= cards.length, returns all cards shuffled.
/// Uses [random] for testability (dependency injection).
List<Flashcard> prepareDeck(List<Flashcard> cards, int count, {Random? random}) {
  if (cards.isEmpty) return [];

  final shuffled = List<Flashcard>.of(cards)..shuffle(random ?? Random());
  final trimCount = count >= cards.length ? cards.length : count;
  return shuffled.sublist(0, trimCount);
}

/// Returns `true` when the preset option should be enabled.
///
/// If [presetCount] is null (the "All" option), returns `true` when
/// [availableCount] > 0.
/// Otherwise, returns `true` when [availableCount] >= [presetCount].
bool isPresetEnabled(int availableCount, int? presetCount) {
  if (presetCount == null) return availableCount > 0;
  return availableCount >= presetCount;
}
