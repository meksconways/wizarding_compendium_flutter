import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/core/widgets/loading_widget.dart';
import 'package:harry_potter/features/books/presentation/widgets/book_item.dart';

import '../../../../core/widgets/error_widget.dart';
import '../providers.dart';

class BooksPage extends ConsumerStatefulWidget {
  const BooksPage({super.key});

  @override
  ConsumerState<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.read(booksViewModelProvider);
      if (state.books.isEmpty) {
        ref.read(booksViewModelProvider.notifier).fetchBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(booksViewModelProvider);
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final pageTitle = "The Books";
    final desc = "Explore the seven core books of the Harry Potter series.";

    return Scaffold(
      body: Builder(
        builder: (context) {
          if (state.isLoading) {
            return const LoadingView();
          }
          if (state.error != null) {
            return ErrorView(message: state.error ?? "Something went wrong");
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pageTitle,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          desc,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.45,
                        ),
                    itemCount: state.books.length,
                    itemBuilder: (context, i) {
                      final item = state.books[i];
                      return BookItem(
                        item: item,
                        onTap: () => context.push('/bookDetail/${item.index}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
