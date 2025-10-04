import 'package:harry_potter/features/books/domain/repository/books_repository.dart';

import '../model/book.dart';

class FetchBookUseCase {
  final BooksRepository _booksRepository;

  FetchBookUseCase(this._booksRepository);

  Future<Book> call({required int index}) async =>
      await _booksRepository.getSingleBook(index);
}
