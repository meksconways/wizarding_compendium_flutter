import 'package:flutter_test/flutter_test.dart';
import 'package:harry_potter/features/books/data/dto/book_dto.dart';
import 'package:harry_potter/features/books/domain/model/book.dart';

void main() {
  group('BookDto', () {
    test('should correctly parse from JSON', () {
      // arrange
      final json = {
        'id': '1',
        'title': 'Philosopher\'s Stone',
        'originalTitle': 'Harry Potter and the Philosopher\'s Stone',
        'releaseDate': '1997-06-26',
        'description': 'The first book in the Harry Potter series.',
        'pages': 223,
        'cover': 'https://example.com/cover.jpg',
        'index': 1,
      };

      // act
      final dto = BookDto.fromJson(json);

      // assert
      expect(dto.id, '1');
      expect(dto.title, 'Philosopher\'s Stone');
      expect(dto.originalTitle, 'Harry Potter and the Philosopher\'s Stone');
      expect(dto.releaseDate, '1997-06-26');
      expect(dto.description, contains('Harry Potter'));
      expect(dto.pages, 223);
      expect(dto.cover, startsWith('https://'));
      expect(dto.index, 1);
    });

    test('should correctly convert to domain model', () {
      // arrange
      final dto = BookDto(
        id: '2',
        title: 'Chamber of Secrets',
        originalTitle: 'Harry Potter and the Chamber of Secrets',
        releaseDate: '1998-07-02',
        description: 'The second book of the series.',
        pages: 251,
        cover: 'https://example.com/2.jpg',
        index: 2,
      );

      // act
      final book = dto.toDomain();

      // assert
      expect(book, isA<Book>());
      expect(book.title, 'Chamber of Secrets');
      expect(book.id, '2');
      expect(book.pages, 251);
      expect(book.cover, endsWith('.jpg'));
      expect(book.index, 2);
    });

    test('should handle null or missing fields gracefully', () {
      // arrange
      final json = {
        'id': null,
        'title': null,
        'originalTitle': null,
        'releaseDate': null,
        'description': null,
        'pages': null,
        'cover': null,
        'index': null,
      };

      // act
      final dto = BookDto.fromJson(json);
      final book = dto.toDomain();

      // assert
      expect(book.id, '');
      expect(book.title, '');
      expect(book.originalTitle, '');
      expect(book.releaseDate, '');
      expect(book.description, '');
      expect(book.pages, 0);
      expect(book.cover, '');
      expect(book.index, 0);
    });
  });
}