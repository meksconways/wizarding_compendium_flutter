import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/app_shell.dart';
import '../features/app_shell/widgets/temp_pages.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _booksKey = GlobalKey<NavigatorState>(debugLabel: 'books');
final _housesKey = GlobalKey<NavigatorState>(debugLabel: 'houses');
final _charsKey = GlobalKey<NavigatorState>(debugLabel: 'chars');
final _spellsKey = GlobalKey<NavigatorState>(debugLabel: 'spells');
final _quizKey = GlobalKey<NavigatorState>(debugLabel: 'quiz');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/books',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) =>
            AppShell(navigationShell: navShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _booksKey,
            routes: [
              GoRoute(
                path: '/books',
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: BooksPage()),
              ),
              GoRoute(
                path: '/bookDetail',
                builder: (_,_) => const BookDetailPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _housesKey,
            routes: [
              GoRoute(
                path: '/houses',
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: HousesPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _charsKey,
            routes: [
              GoRoute(
                path: '/characters',
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: CharactersPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _spellsKey,
            routes: [
              GoRoute(
                path: '/spells',
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: SpellsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _quizKey,
            routes: [
              GoRoute(
                path: '/quiz',
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: SpellsQuizPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
