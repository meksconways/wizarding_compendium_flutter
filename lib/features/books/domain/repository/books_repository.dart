import '../model/book.dart';

abstract class BooksRepository {
  Future<List<Book>> list({
    int page = 1,
    int pageSize = 20,
    String? search,
  });

  Future<Book> getSingleBook(int index);
}
