import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:harry_potter/features/books/presentation/pages/books_page.dart';
import 'package:harry_potter/features/books/presentation/providers.dart';
import 'package:harry_potter/features/books/domain/usecase/fetch_books_usecase.dart';
import 'package:harry_potter/features/books/domain/model/book.dart';
import 'package:harry_potter/features/books/domain/exceptions/book_exception.dart';

class _MockFetchBooksUseCase extends Mock implements FetchBooksUseCase {}

void main() {
  late _MockFetchBooksUseCase mockUseCase;

  setUp(() {
    mockUseCase = _MockFetchBooksUseCase();
  });

  GoRouter buildRouter(Widget child) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => child,
          routes: [
            GoRoute(
              path: 'bookDetail/:index',
              builder: (context, state) {
                final index = int.parse(state.pathParameters['index']!);
                return Scaffold(
                  appBar: AppBar(title: const Text('Detail')),
                  body: Center(child: Text('Detail index: $index')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget wrapWithApp(Widget page, {overrides = const []}) {
    final router = buildRouter(page);
    return ProviderScope(
      overrides: overrides.toList(),
      child: MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('renders grid with books on success', (tester) async {
    // arrange
    when(
      () => mockUseCase(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      ),
    ).thenAnswer(
      (_) async => [
        Book(
          id: '1',
          title: "Philosopher's Stone",
          originalTitle: "Harry Potter and the Philosopher's Stone",
          releaseDate: '1997-06-26',
          description: 'First book',
          pages: 223,
          cover: 'https://example.com/1.jpg',
          index: 1,
        ),
        Book(
          id: '2',
          title: 'Chamber of Secrets',
          originalTitle: 'Harry Potter and the Chamber of Secrets',
          releaseDate: '1998-07-02',
          description: 'Second book',
          pages: 251,
          cover: 'https://example.com/2.jpg',
          index: 2,
        ),
      ],
    );

    final widget = wrapWithApp(
      const BooksPage(),
      overrides: [fetchBooksUseCaseProvider.overrideWithValue(mockUseCase)],
    );

    // act
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pumpAndSettle();

    // assert
    expect(find.text('The Books'), findsOneWidget);
    expect(find.text("Philosopher's Stone"), findsOneWidget);
    expect(find.text('Chamber of Secrets'), findsOneWidget);

    verify(() => mockUseCase(page: 1, pageSize: 20, search: null)).called(1);
    verifyNoMoreInteractions(mockUseCase);
  });

  testWidgets('shows error view when use case throws BookFetchException', (
    tester,
  ) async {
    when(
      () => mockUseCase(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      ),
    ).thenThrow(BookFetchException('net', Exception('e'), StackTrace.current));

    final widget = wrapWithApp(
      const BooksPage(),
      overrides: [fetchBooksUseCaseProvider.overrideWithValue(mockUseCase)],
    );

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pumpAndSettle();

    expect(find.text('Connection Error. Pls try again.'), findsOneWidget);

    verify(() => mockUseCase(page: 1, pageSize: 20, search: null)).called(1);
    verifyNoMoreInteractions(mockUseCase);
  });

  testWidgets('navigates to detail when a book tile is tapped', (tester) async {
    when(
      () => mockUseCase(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      ),
    ).thenAnswer(
      (_) async => [
        Book(
          id: '10',
          title: 'Some Book',
          originalTitle: 'Some Book Original',
          releaseDate: '2000-01-01',
          description: 'desc',
          pages: 100,
          cover: 'https://example.com/x.jpg',
          index: 42,
        ),
      ],
    );

    final widget = wrapWithApp(
      const BooksPage(),
      overrides: [fetchBooksUseCaseProvider.overrideWithValue(mockUseCase)],
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final titleFinder = find.text('Some Book');
    await tester.ensureVisible(titleFinder);

    final tappable = find.ancestor(
      of: titleFinder,
      matching: find.byType(InkWell),
    );
    await tester.tap(tappable);
    await tester.pumpAndSettle();

    expect(find.text('Detail index: 42'), findsOneWidget);

    verify(() => mockUseCase(page: 1, pageSize: 20, search: null)).called(1);
    verifyNoMoreInteractions(mockUseCase);
  });
}
