import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/app_shell.dart';
import '../features/app_shell/widgets/temp_pages.dart';
import '../features/books/presentation/pages/book_detail_page.dart';
import '../features/books/presentation/pages/books_page.dart';
import '../features/characters/presentation/pages/character_detail_page.dart';
import '../features/characters/presentation/pages/characters_page.dart';
import '../features/houses/presentation/pages/house_detail_page.dart';
import '../features/houses/presentation/pages/houses_page.dart';
import '../features/spells/presentation/pages/spells_page.dart';

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
                pageBuilder: (_, _) =>
                    const NoTransitionPage(child: BooksPage()),
              ),
              GoRoute(
                path: '/bookDetail/:index',
                builder: (context, state) {
                  final index = state.pathParameters['index']!;
                  return BookDetailPage(index: int.parse(index));
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _housesKey,
            routes: [
              GoRoute(
                path: '/houses',
                pageBuilder: (_, _) =>
                    const NoTransitionPage(child: HousesPage()),
              ),
              GoRoute(
                path: '/houseDetail/:index',
                builder: (context, state) {
                  final index = state.pathParameters['index']!;
                  return HouseDetailPage(houseIndex: int.parse(index));
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _charsKey,
            routes: [
              GoRoute(
                path: '/characters',
                pageBuilder: (_, _) =>
                    const NoTransitionPage(child: CharactersPage()),
              ),
              GoRoute(
                path: '/characterDetail/:index',
                builder: (context, state) {
                  final index = state.pathParameters['index']!;
                  return CharacterDetailPage(index: int.parse(index));
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _spellsKey,
            routes: [
              GoRoute(
                path: '/spells',
                pageBuilder: (_, _) =>
                    const NoTransitionPage(child: SpellsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _quizKey,
            routes: [
              GoRoute(
                path: '/quiz',
                pageBuilder: (_, _) =>
                    const NoTransitionPage(child: SpellsQuizPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
