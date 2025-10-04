import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/features/books/domain/exceptions/book_exception.dart';
import 'package:harry_potter/features/books/presentation/state/books_state.dart';

import '../../domain/usecase/fetch_books_usecase.dart';
import '../providers.dart';

class BooksViewModel extends Notifier<BooksState> {
  late final FetchBooksUseCase _fetchBooksUseCase = ref.watch(
    fetchBooksUseCaseProvider,
  );

  @override
  BooksState build() => BooksState.initial();

  Future<void> fetchBooks() async {
    state = state.copyWith(isLoading: true);
    try {
      final books = await _fetchBooksUseCase();
      state = state.copyWith(isLoading: false, books: books, error: null);
    } on BookException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(BookException exception) {
    switch (exception) {
      case BookFetchException():
        state = state.copyWith(
          isLoading: false,
          error: 'Connection Error. Pls try again.',
        );
      case BookNotFoundException():
        state = state.copyWith(isLoading: false, error: 'Books are not found.');
      case BookInvalidDataException():
        state = state.copyWith(
          isLoading: false,
          error: 'Data format is invalid.',
        );
    }
  }
}
