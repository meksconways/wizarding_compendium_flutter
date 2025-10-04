import '../../domain/model/book.dart';

class BooksState {
  final bool isLoading;
  final List<Book> books;
  final String? error;

  const BooksState({required this.isLoading, required this.books, this.error});

  factory BooksState.initial() =>
      const BooksState(isLoading: true, books: [], error: null);

  BooksState copyWith({bool? isLoading, List<Book>? books, String? error}) {
    return BooksState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      error: error,
    );
  }
}
