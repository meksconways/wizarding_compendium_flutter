import 'package:harry_potter/features/books/domain/model/book.dart';
import 'package:harry_potter/features/books/domain/repository/books_repository.dart';

class FetchBooksUseCase {
  final BooksRepository booksRepository;
  FetchBooksUseCase(this.booksRepository);

  Future<List<Book>> call({
    int page = 1,
    int pageSize = 20,
    String? search,
  }) async {
    return await booksRepository.list(
      page: page,
      pageSize: pageSize,
      search: search,
    );
  }
}