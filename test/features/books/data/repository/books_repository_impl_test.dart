import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:harry_potter/features/books/data/datasource/book_remote_ds.dart';
import 'package:harry_potter/features/books/data/dto/book_dto.dart';
import 'package:harry_potter/features/books/data/repository/books_repository_impl.dart';
import 'package:harry_potter/features/books/domain/repository/books_repository.dart';
import 'package:harry_potter/features/books/domain/model/book.dart';
import 'package:harry_potter/features/books/domain/exceptions/book_exception.dart';

class _MockBooksRemoteDataSource extends Mock implements BooksRemoteDataSource {}

void main() {
  late _MockBooksRemoteDataSource dataSource;
  late BooksRepository repository;

  setUp(() {
    dataSource = _MockBooksRemoteDataSource();
    repository = BooksRepositoryImpl(dataSource);
  });

  group('BooksRepositoryImpl.list', () {
    test('returns mapped domain list when dataSource succeeds', () async {
      // arrange
      when(() => dataSource.getBooks(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      )).thenAnswer((_) async => [
        BookDto(
          id: "1",
          title: "Philosopher's Stone",
          originalTitle: "Harry Potter and the Philosopher's Stone",
          releaseDate: "1997-06-26",
          description: "The first book in the Harry Potter series.",
          pages: 223,
          cover: "https://example.com/cover.jpg",
          index: 1,
        ),
        BookDto(
          id: "2",
          title: "Chamber of Secrets",
          originalTitle: "Harry Potter and the Chamber of Secrets",
          releaseDate: "1998-07-02",
          description: "The second book in the Harry Potter series.",
          pages: 251,
          cover: "https://example.com/cover2.jpg",
          index: 2,
        ),
      ]);

      // act
      final books = await repository.list(page: 1, pageSize: 20);

      // assert
      expect(books, isA<List<Book>>());
      expect(books.length, 2);
      expect(books.first.title, "Philosopher's Stone");

      verify(() => dataSource.getBooks(
        page: 1,
        pageSize: 20,
        search: null, // repository null gönderir
      )).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('wraps DioException into BookFetchException', () async {
      when(() => dataSource.getBooks(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/books'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
            () => repository.list(page: 1, pageSize: 20),
        throwsA(isA<BookFetchException>()),
      );

      verify(() => dataSource.getBooks(page: 1, pageSize: 20, search: null))
          .called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('wraps FormatException into BookInvalidDataException', () async {
      when(() => dataSource.getBooks(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      )).thenThrow(const FormatException('bad json'));

      expect(
            () => repository.list(page: 1, pageSize: 20),
        throwsA(isA<BookInvalidDataException>()),
      );

      verify(() => dataSource.getBooks(page: 1, pageSize: 20, search: null))
          .called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('wraps unknown errors into BookFetchException', () async {
      when(() => dataSource.getBooks(
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
        search: any(named: 'search'),
      )).thenThrow(StateError('weird'));

      expect(
            () => repository.list(page: 1, pageSize: 20),
        throwsA(isA<BookFetchException>()),
      );

      verify(() => dataSource.getBooks(page: 1, pageSize: 20, search: null))
          .called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('BooksRepositoryImpl.getSingleBook', () {
    test('returns mapped domain entity when dataSource succeeds', () async {
      when(() => dataSource.getSingleBook(index: any(named: 'index')))
          .thenAnswer((_) async => BookDto(
        id: "3",
        title: "Prisoner of Azkaban",
        originalTitle: "Harry Potter and the Prisoner of Azkaban",
        releaseDate: "1999-07-08",
        description: "Third book.",
        pages: 317,
        cover: "https://example.com/3.jpg",
        index: 3,
      ));

      final book = await repository.getSingleBook(3);

      expect(book, isA<Book>());
      expect(book.title, "Prisoner of Azkaban");

      verify(() => dataSource.getSingleBook(index: 3)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('wraps DioException into BookFetchException', () async {
      when(() => dataSource.getSingleBook(index: any(named: 'index')))
          .thenThrow(
        DioException(requestOptions: RequestOptions(path: '/books')),
      );

      expect(() => repository.getSingleBook(5),
          throwsA(isA<BookFetchException>()));

      verify(() => dataSource.getSingleBook(index: 5)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('wraps FormatException into BookInvalidDataException', () async {
      when(() => dataSource.getSingleBook(index: any(named: 'index')))
          .thenThrow(const FormatException('bad json'));

      expect(() => repository.getSingleBook(1),
          throwsA(isA<BookInvalidDataException>()));

      verify(() => dataSource.getSingleBook(index: 1)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}