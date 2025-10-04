import 'package:flutter_test/flutter_test.dart';
import 'package:harry_potter/features/books/domain/exceptions/book_exception.dart';
import 'package:mocktail/mocktail.dart';

import 'package:harry_potter/features/books/domain/model/book.dart';
import 'package:harry_potter/features/books/domain/repository/books_repository.dart';
import 'package:harry_potter/features/books/domain/usecase/fetch_books_usecase.dart';

class _MockBooksRepository extends Mock implements BooksRepository {}

void main() {
  late _MockBooksRepository repository;
  late FetchBooksUseCase useCase;

  setUp(() {
    repository = _MockBooksRepository();
    useCase = FetchBooksUseCase(repository);
  });

  test('forwards repository result with given params', () async {
    // arrange
    when(
      () => repository.list(
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
          description: 'The first book in the Harry Potter series.',
          pages: 223,
          cover: 'https://example.com/cover.jpg',
          index: 1,
        ),
        Book(
          id: '2',
          title: "Philosopher's Stone 2",
          originalTitle: "Harry Potter and the Philosopher's Stone 2",
          releaseDate: '1997-06-26',
          description: 'The first book in the Harry Potter series.',
          pages: 223,
          cover: 'https://example.com/cover.jpg',
          index: 2,
        ),
      ],
    );

    // act
    final books = await useCase(page: 1, pageSize: 20);

    // assert
    expect(books, isA<List<Book>>());
    expect(books.first.title, "Philosopher's Stone");
    verify(
      () => repository.list(page: 1, pageSize: 20, search: null),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('passes through non-null search parameter', () async {
    when(
      () => repository.list(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      ),
    ).thenAnswer((_) async => <Book>[]);

    await useCase(page: 2, pageSize: 50, search: 'harry');

    verify(
      () => repository.list(page: 2, pageSize: 50, search: 'harry'),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('rethrows repository errors (no swallowing)', () async {
    when(
      () => repository.list(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      ),
    ).thenThrow(BookFetchException("Something went wrong"));

    expect(
      () => useCase(page: 1, pageSize: 20),
      throwsA(isA<BookFetchException>()),
    );
    verify(
      () => repository.list(page: 1, pageSize: 20, search: null),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
