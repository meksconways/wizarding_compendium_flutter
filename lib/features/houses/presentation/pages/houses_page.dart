import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/features/houses/presentation/providers.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/house_item.dart';

class HousesPage extends ConsumerStatefulWidget {
  const HousesPage({super.key});

  @override
  ConsumerState<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends ConsumerState<HousesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.read(housesViewModelProvider);
      if (state.houses.isEmpty) {
        ref.read(housesViewModelProvider.notifier).fetchHouses();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(housesViewModelProvider);
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final pageTitle = "The Four Houses of Hogwarts";
    final desc = "Discover the history and traits of Gryffindor, Hufflepuff, Ravenclaw, and Slytherin.";

    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const LoadingView();
            }
            if (state.error != null) {
              return ErrorView(message: state.error ?? "Something went wrong");
            }

            return CustomScrollView(
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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: state.houses.length,
                    itemBuilder: (context, i) {
                      final item = state.houses[i];
                      return HouseItem(
                        house: item,
                        onTap: () => context.push('/houseDetail/${item.index}'),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
