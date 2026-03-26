import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/content_repository.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ContentRepository();
});
