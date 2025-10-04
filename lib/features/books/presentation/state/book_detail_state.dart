import '../../domain/model/book.dart';

class BookDetailState {
  final bool isLoading;
  final Book? book;
  final String? error;

  const BookDetailState({
    required this.isLoading,
    required this.book,
    this.error,
  });

  factory BookDetailState.initial() =>
      const BookDetailState(isLoading: true, book: null, error: null);

  BookDetailState copyWith({bool? isLoading, Book? book, String? error}) {
    return BookDetailState(
      isLoading: isLoading ?? this.isLoading,
      book: book ?? this.book,
      error: error,
    );
  }
}
