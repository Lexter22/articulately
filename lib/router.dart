import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/admin_login_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/category_list_screen.dart';
import 'screens/flashcard_screen.dart';
import 'screens/home_screen.dart';
import 'screens/practice_summary_screen.dart';
import 'screens/session_complete_screen.dart';

final _authNotifier = _SupabaseAuthNotifier();

class _SupabaseAuthNotifier extends ChangeNotifier {
  _SupabaseAuthNotifier() {
    Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      notifyListeners();
    });
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: _authNotifier,
  redirect: (context, state) {
    final loggedIn = Supabase.instance.client.auth.currentUser != null;
    final goingToAdmin = state.matchedLocation.startsWith('/admin');
    final goingToAdminLogin = state.matchedLocation == '/admin/login';

    if (goingToAdmin && !goingToAdminLogin && !loggedIn) return '/admin/login';
    if (goingToAdminLogin && loggedIn) return '/admin';
    return null;
  },
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
      pageBuilder: (context, state) =>
          _page(state, const SessionCompleteScreen()),
    ),
    GoRoute(
      path: '/summary',
      pageBuilder: (context, state) =>
          _page(state, const PracticeSummaryScreen()),
    ),
    GoRoute(
      path: '/admin/login',
      pageBuilder: (context, state) =>
          _page(state, const AdminLoginScreen()),
    ),
    GoRoute(
      path: '/admin',
      pageBuilder: (context, state) => _page(state, const AdminScreen()),
    ),
  ],
);

MaterialPage<void> _page(GoRouterState state, Widget child) {
  return MaterialPage<void>(key: state.pageKey, child: child);
}
