import 'package:dio/dio.dart';
import 'package:harry_potter/features/books/data/datasource/book_remote_ds.dart';
import 'package:harry_potter/features/books/domain/model/book.dart';
import 'package:harry_potter/features/books/domain/repository/books_repository.dart';

import '../../domain/exceptions/book_exception.dart';

class BooksRepositoryImpl implements BooksRepository {
  final BooksRemoteDataSource remoteDataSource;

  BooksRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Book>> list({
    int page = 1,
    int pageSize = 20,
    String? search,
  }) async {
    try {
      final books = await remoteDataSource.getBooks(
        page: page,
        pageSize: pageSize,
        search: search,
      );
      return books.map((book) => book.toDomain()).toList();
    } on DioException catch (e, s) {
      throw BookFetchException('Network error while fetching books', e, s);
    } on FormatException catch (e) {
      throw BookInvalidDataException('Invalid data format: ${e.message}');
    } catch (e, s) {
      throw BookFetchException('Unexpected error', e, s);
    }
  }

  @override
  Future<Book> getSingleBook(int index) async {
    try {
      final book = await remoteDataSource.getSingleBook(index: index);
      return book.toDomain();
    } on DioException catch (e, s) {
      throw BookFetchException('Network error while fetching books', e, s);
    } on FormatException catch (e) {
      throw BookInvalidDataException('Invalid data format: ${e.message}');
    } catch (e, s) {
      throw BookFetchException('Unexpected error', e, s);
    }
  }
}
