import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:harry_potter/features/books/domain/model/book.dart';
import 'package:harry_potter/features/books/domain/usecase/fetch_books_usecase.dart';
import 'package:harry_potter/features/books/presentation/providers.dart';
import 'package:harry_potter/features/books/domain/exceptions/book_exception.dart';

class _MockFetchBooksUseCase extends Mock implements FetchBooksUseCase {}

void main() {
  late _MockFetchBooksUseCase mockUseCase;
  late ProviderContainer container;

  setUp(() {
    mockUseCase = _MockFetchBooksUseCase();
    container = ProviderContainer(
      overrides: [
        fetchBooksUseCaseProvider.overrideWithValue(mockUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is BooksState.initial()', () {
    final state = container.read(booksViewModelProvider);
    expect(state.isLoading, true);
    expect(state.books, isEmpty);
    expect(state.error, isNull);
  });

  test('fetchBooks -> success updates state with data and stops loading', () async {
    // arrange
    when(() => mockUseCase(
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
      search: any(named: 'search'),
    )).thenAnswer((_) async => [
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
    ]);

    // act
    await container.read(booksViewModelProvider.notifier).fetchBooks();

    // assert
    final state = container.read(booksViewModelProvider);
    expect(state.isLoading, false);
    expect(state.error, isNull);
    expect(state.books.length, 2);
    expect(state.books.first.title, "Philosopher's Stone");

    verify(() => mockUseCase(page: 1, pageSize: 20, search: null)).called(1);
    verifyNoMoreInteractions(mockUseCase);
  });

  test('fetchBooks -> BookFetchException maps to connection error message', () async {
    when(() => mockUseCase(
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
      search: any(named: 'search'),
    )).thenThrow(BookFetchException('net', Exception('e'), StackTrace.current));

    await container.read(booksViewModelProvider.notifier).fetchBooks();

    final state = container.read(booksViewModelProvider);
    expect(state.isLoading, false);
    expect(state.error, 'Connection Error. Pls try again.');
    expect(state.books, isEmpty);

    verify(() => mockUseCase(page: 1, pageSize: 20, search: null)).called(1);
    verifyNoMoreInteractions(mockUseCase);
  });

  test('fetchBooks -> BookNotFoundException maps to not found message', () async {
    when(() => mockUseCase(
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
      search: any(named: 'search'),
    )).thenThrow(BookNotFoundException('nope'));

    await container.read(booksViewModelProvider.notifier).fetchBooks();

    final state = container.read(booksViewModelProvider);
    expect(state.isLoading, false);
    expect(state.error, 'Books are not found.');
    expect(state.books, isEmpty);

    verify(() => mockUseCase(page: 1, pageSize: 20, search: null)).called(1);
    verifyNoMoreInteractions(mockUseCase);
  });

  test('fetchBooks -> BookInvalidDataException maps to invalid data message', () async {
    when(() => mockUseCase(
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
      search: any(named: 'search'),
    )).thenThrow(BookInvalidDataException('bad'));

    await container.read(booksViewModelProvider.notifier).fetchBooks();

    final state = container.read(booksViewModelProvider);
    expect(state.isLoading, false);
    expect(state.error, 'Data format is invalid.');
    expect(state.books, isEmpty);

    verify(() => mockUseCase(page: 1, pageSize: 20, search: null)).called(1);
    verifyNoMoreInteractions(mockUseCase);
  });
}