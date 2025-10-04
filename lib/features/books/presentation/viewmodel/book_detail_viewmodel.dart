import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/features/books/presentation/state/book_detail_state.dart';
import '../../domain/exceptions/book_exception.dart';
import '../../domain/usecase/fetch_book_usecase.dart';
import '../providers.dart';

class BookDetailViewModel extends Notifier<BookDetailState> {
  late final FetchBookUseCase _fetchBookUseCase = ref.watch(
    fetchBookUseCaseProvider,
  );

  @override
  BookDetailState build() => BookDetailState.initial();

  Future<void> fetchBook({required int index}) async {
    state = state.copyWith(isLoading: true);
    try {
      final book = await _fetchBookUseCase(index: index);
      state = state.copyWith(isLoading: false, book: book, error: null);
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
        state = state.copyWith(error: 'Book is not found.');
      case BookInvalidDataException():
        state = state.copyWith(error: 'Data format is invalid.');
    }
  }

}
