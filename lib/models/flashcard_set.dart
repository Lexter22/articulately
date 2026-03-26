import 'difficulty.dart';
import 'flashcard.dart';

class FlashcardSet {
  final String categoryId;
  final Difficulty difficulty;
  final List<Flashcard> cards;

  const FlashcardSet({
    required this.categoryId,
    required this.difficulty,
    required this.cards,
  });
}
