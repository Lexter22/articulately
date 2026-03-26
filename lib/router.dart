import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/category_list_screen.dart';
import 'screens/flashcard_screen.dart';
import 'screens/home_screen.dart';
import 'screens/practice_summary_screen.dart';
import 'screens/session_complete_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _page(state, const HomeScreen()),
    ),
    GoRoute(
      path: '/categories',
      pageBuilder: (context, state) => _page(
        state,
        CategoryListScreen(
          difficulty: state.uri.queryParameters['difficulty'] ?? 'easy',
        ),
      ),
    ),
    GoRoute(
      path: '/flashcard',
      pageBuilder: (context, state) => _page(
        state,
        FlashcardScreen(
          categoryId: state.uri.queryParameters['categoryId'] ?? '',
          difficulty: state.uri.queryParameters['difficulty'] ?? 'easy',
        ),
      ),
    ),
    GoRoute(
      path: '/complete',
      pageBuilder: (context, state) => _page(state, const SessionCompleteScreen()),
    ),
    GoRoute(
      path: '/summary',
      pageBuilder: (context, state) => _page(state, const PracticeSummaryScreen()),
    ),
  ],
);

MaterialPage<void> _page(GoRouterState state, Widget child) {
  return MaterialPage<void>(
    key: state.pageKey,
    child: child,
  );
}
