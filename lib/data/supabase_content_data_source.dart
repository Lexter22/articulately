import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/category.dart';
import '../models/difficulty.dart';
import '../models/flashcard.dart';

class SupabaseContentDataSource {
  final SupabaseClient _client;

  SupabaseContentDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  Future<List<Category>> getCategories() async {
    final data = await _client
        .from('categories')
        .select('id, name, subtitle')
        .order('name');

    return (data as List).map((row) => Category(
          id: row['id'] as String,
          name: (row['name'] as String?) ?? 'Untitled',
          subtitle: (row['subtitle'] as String?) ?? '',
        )).toList();
  }

  Future<List<Flashcard>> getFlashcards({
    required String categoryId,
    required Difficulty difficulty,
  }) async {
    final data = await _client
        .from('flashcards')
        .select('id, text, category_id, difficulty')
        .eq('category_id', categoryId)
        .eq('difficulty', difficulty.name);

    return (data as List).map((row) => Flashcard(
          id: row['id'] as String,
          text: (row['text'] as String?) ?? '',
          categoryId: categoryId,
          difficulty: Difficulty.values.firstWhere(
            (d) => d.name == row['difficulty'],
            orElse: () => Difficulty.easy,
          ),
        )).toList();
  }
}
