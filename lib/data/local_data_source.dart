import '../models/category.dart';
import '../models/difficulty.dart';
import '../models/flashcard.dart';
import 'content_data.dart';

class LocalDataSource {
  List<Category> getCategories() {
    return kCategories
        .map((map) => Category(
              id: map['id'] as String,
              name: map['name'] as String,
              subtitle: map['subtitle'] as String,
            ))
        .toList();
  }

  List<Flashcard> getFlashcards() {
    return kFlashcards
        .map((map) => Flashcard(
              id: map['id'] as String,
              text: map['text'] as String,
              categoryId: map['categoryId'] as String,
              difficulty: _parseDifficulty(map['difficulty'] as String),
            ))
        .toList();
  }

  Difficulty _parseDifficulty(String value) {
    switch (value) {
      case 'easy':
        return Difficulty.easy;
      case 'medium':
        return Difficulty.medium;
      case 'hard':
        return Difficulty.hard;
      default:
        throw ArgumentError('Unknown difficulty: $value');
    }
  }
}
