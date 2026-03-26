import 'difficulty.dart';

class Flashcard {
  final String id;
  final String text;
  final String categoryId;
  final Difficulty difficulty;

  const Flashcard({
    required this.id,
    required this.text,
    required this.categoryId,
    required this.difficulty,
  });
}
