import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/core/widgets/loading_widget.dart';

import '../../../../core/widgets/error_widget.dart';
import '../providers.dart';

class BookDetailPage extends ConsumerStatefulWidget {
  final int index;

  const BookDetailPage({super.key, required this.index});

  @override
  ConsumerState<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends ConsumerState<BookDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.read(bookDetailViewModelProvider);
      if (state.book == null) {
        ref
            .read(bookDetailViewModelProvider.notifier)
            .fetchBook(index: widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookDetailViewModelProvider);
    final pageTitle = state.book?.title ?? "";
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return LoadingView();
            }

            if (state.error != null) {
              return ErrorView(message: state.error ?? "Something went wrong");
            }

            final cs = Theme.of(context).colorScheme;
            final theme = Theme.of(context);
            final book = state.book;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 4 / 7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: book?.cover ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              state.book?.title ?? "",
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Release Date:  ",
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: cs.onSurface,
                                      fontFamily: 'PlayfairDisplay',
                                    ),
                                  ),
                                  TextSpan(
                                    text: book?.releaseDate ?? '-',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Pages:  ",
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: cs.onSurface,
                                      fontFamily: 'PlayfairDisplay',
                                    ),
                                  ),
                                  TextSpan(
                                    text: book?.pages.toString(),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    "Description",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book?.description ?? "",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
