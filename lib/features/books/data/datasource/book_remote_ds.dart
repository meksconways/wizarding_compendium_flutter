import 'package:harry_potter/core/network/hp_api.dart';
import 'package:harry_potter/features/books/data/dto/book_dto.dart';

class BooksRemoteDataSource {
  final HpApi _api;

  BooksRemoteDataSource(this._api);

  Future<List<BookDto>> getBooks({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    final qp = <String, dynamic>{};
    if (page != null) qp['pages'] = page;
    if (pageSize != null) qp['limit'] = pageSize;
    if (search?.isNotEmpty ?? false) qp['search'] = search;
    final books = await _api.getList('/books', qp: qp);
    return books.map((book) => BookDto.fromJson(book)).toList();
  }

  Future<BookDto> getSingleBook({required int index}) async {
    final qp = <String, dynamic>{};
    qp["index"] = index;
    final book = await _api.getSingleItem('/books', qp: qp);
    return BookDto.fromJson(book);
  }
}
