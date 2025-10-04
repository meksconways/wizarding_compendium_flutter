import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/features/books/domain/usecase/fetch_book_usecase.dart';
import 'package:harry_potter/features/books/presentation/state/book_detail_state.dart';
import 'package:harry_potter/features/books/presentation/state/books_state.dart';
import 'package:harry_potter/features/books/presentation/viewmodel/book_detail_viewmodel.dart';
import 'package:harry_potter/features/books/presentation/viewmodel/books_viewmodel.dart';

import '../../../core/network/hp_api.dart';
import '../data/datasource/book_remote_ds.dart';
import '../data/repository/books_repository_impl.dart';
import '../domain/repository/books_repository.dart';
import '../domain/usecase/fetch_books_usecase.dart';

final hpApiProvider = Provider((ref) => HpApi());

// Data layer
final booksRemoteDataSourceProvider = Provider(
  (ref) => BooksRemoteDataSource(ref.watch(hpApiProvider)),
);

final booksRepositoryProvider = Provider<BooksRepository>(
  (ref) => BooksRepositoryImpl(ref.watch(booksRemoteDataSourceProvider)),
);

// Domain layer
final fetchBooksUseCaseProvider = Provider(
  (ref) => FetchBooksUseCase(ref.watch(booksRepositoryProvider)),
);

final fetchBookUseCaseProvider = Provider(
  (ref) => FetchBookUseCase(ref.watch(booksRepositoryProvider)),
);

// Presentation layer
final booksViewModelProvider =
    NotifierProvider.autoDispose<BooksViewModel, BooksState>(
      BooksViewModel.new,
    );

final bookDetailViewModelProvider =
    NotifierProvider.autoDispose<BookDetailViewModel, BookDetailState>(
      BookDetailViewModel.new,
    );
