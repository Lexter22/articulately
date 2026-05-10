import '../models/category.dart';
import '../models/difficulty.dart';
import '../models/flashcard_set.dart';
import 'supabase_content_data_source.dart';

class ContentRepository {
  final SupabaseContentDataSource _dataSource;

  ContentRepository({SupabaseContentDataSource? dataSource})
      : _dataSource = dataSource ?? SupabaseContentDataSource();

  Future<List<Category>> getCategories() => _dataSource.getCategories();

  Future<FlashcardSet?> getFlashcardSet(
    String categoryId,
    Difficulty difficulty,
  ) async {
    final cards = await _dataSource.getFlashcards(
      categoryId: categoryId,
      difficulty: difficulty,
    );

    if (cards.isEmpty) return null;

    return FlashcardSet(
      categoryId: categoryId,
      difficulty: difficulty,
      cards: cards,
    );
  }

  Future<int> getFlashcardCount(
    String categoryId,
    Difficulty difficulty,
  ) async {
    final cards = await _dataSource.getFlashcards(
      categoryId: categoryId,
      difficulty: difficulty,
    );
    return cards.length;
  }
}
