import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:harry_potter/features/books/data/datasource/book_remote_ds.dart';
import 'package:harry_potter/core/network/hp_api.dart';
import 'package:harry_potter/features/books/data/dto/book_dto.dart';

class _MockHpApi extends Mock implements HpApi {}

void main() {
  late _MockHpApi api;
  late BooksRemoteDataSource dataSource;

  setUp(() {
    api = _MockHpApi();
    dataSource = BooksRemoteDataSource(api);
  });

  group('BooksRemoteDataSource.getBooks', () {
    test(
      'parses the response correctly when no query parameters are provided',
      () async {
        // arrange
        when(() => api.getList('/books', qp: any(named: 'qp'))).thenAnswer(
          (_) async => [
            {
              'id': '1',
              'title': "Philosopher's Stone",
              'author': 'J.K. Rowling',
              'releaseDate': '1997-06-26',
              'cover': 'https://example.com/1.jpg',
            },
            {
              'id': '2',
              'title': 'Chamber of Secrets',
              'author': 'J.K. Rowling',
              'releaseDate': '1998-07-02',
              'cover': 'https://example.com/2.jpg',
            },
          ],
        );

        // act
        final list = await dataSource.getBooks();

        // assert
        expect(list, isA<List<BookDto>>());
        expect(list.length, 2);
        expect(list.first.title, "Philosopher's Stone");
        expect(list.first.cover, isA<String>());

        verify(() => api.getList('/books', qp: <String, dynamic>{})).called(1);
        verifyNoMoreInteractions(api);
      },
    );

    test(
      'sends correct query parameters when page, pageSize and search are provided',
      () async {
        when(
          () => api.getList('/books', qp: any(named: 'qp')),
        ).thenAnswer((_) async => []);

        await dataSource.getBooks(page: 3, pageSize: 20, search: 'harry');

        verify(
          () => api.getList(
            '/books',
            qp: {
              'pages': 3,
              'limit': 20,
              'search': 'harry',
            },
          ),
        ).called(1);
        verifyNoMoreInteractions(api);
      },
    );

    test('omits empty search parameter', () async {
      when(
        () => api.getList('/books', qp: any(named: 'qp')),
      ).thenAnswer((_) async => []);

      await dataSource.getBooks(page: 1, pageSize: 10, search: '');

      verify(
        () => api.getList(
          '/books',
          qp: {
            'pages': 1,
            'limit': 10,
          },
        ),
      ).called(1);
      verifyNoMoreInteractions(api);
    });

    test('forwards exception when API call fails', () async {
      when(
        () => api.getList('/books', qp: any(named: 'qp')),
      ).thenThrow(Exception('network'));

      expect(() => dataSource.getBooks(), throwsA(isA<Exception>()));
      verify(() => api.getList('/books', qp: <String, dynamic>{})).called(1);
      verifyNoMoreInteractions(api);
    });
  });

  group('BooksRemoteDataSource.getSingleBook', () {
    test('sends index as query parameter and parses dto correctly', () async {
      when(() => api.getSingleItem('/books', qp: any(named: 'qp'))).thenAnswer(
        (_) async => {
          'id': '3',
          'title': 'Prisoner of Azkaban',
          'author': 'J.K. Rowling',
          'releaseDate': '1999-07-08',
          'cover': 'https://example.com/3.jpg',
        },
      );

      final dto = await dataSource.getSingleBook(index: 5);

      expect(dto, isA<BookDto>());
      expect(dto.title, 'Prisoner of Azkaban');
      verify(() => api.getSingleItem('/books', qp: {'index': 5})).called(1);
      verifyNoMoreInteractions(api);
    });

    test('forwards exception when API call fails', () async {
      when(
        () => api.getSingleItem('/books', qp: any(named: 'qp')),
      ).thenThrow(FormatException('bad json'));

      expect(
        () => dataSource.getSingleBook(index: 1),
        throwsA(isA<FormatException>()),
      );
      verify(() => api.getSingleItem('/books', qp: {'index': 1})).called(1);
      verifyNoMoreInteractions(api);
    });
  });
}
