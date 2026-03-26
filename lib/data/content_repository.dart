import '../models/category.dart';
import '../models/difficulty.dart';
import '../models/flashcard_set.dart';
import 'local_data_source.dart';

class ContentRepository {
  final LocalDataSource _dataSource;

  ContentRepository({LocalDataSource? dataSource})
      : _dataSource = dataSource ?? LocalDataSource();

  List<Category> getCategories() => _dataSource.getCategories();

  FlashcardSet? getFlashcardSet(String categoryId, Difficulty difficulty) {
    final cards = _dataSource
        .getFlashcards()
        .where((f) => f.categoryId == categoryId && f.difficulty == difficulty)
        .toList();

    if (cards.isEmpty) return null;

    return FlashcardSet(
      categoryId: categoryId,
      difficulty: difficulty,
      cards: cards,
    );
  }
}
