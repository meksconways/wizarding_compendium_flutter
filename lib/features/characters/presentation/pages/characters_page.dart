import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/features/characters/presentation/widgets/character_item.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers.dart';

class CharactersPage extends ConsumerStatefulWidget {
  const CharactersPage({super.key});

  @override
  ConsumerState<CharactersPage> createState() => _CharactersPage();
}

class _CharactersPage extends ConsumerState<CharactersPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.read(charactersViewModelProvider);
      if (state.characters.isEmpty) {
        ref.read(charactersViewModelProvider.notifier).fetchCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(charactersViewModelProvider);

    if (state.isLoading) {
      return const Scaffold(body: SafeArea(child: LoadingView()));
    }
    if (state.error != null) {
      return Scaffold(
        body: SafeArea(
          child: Center(child: ErrorView(message: state.error!)),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [_TitleSection(), _CharacterList()]),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final pageTitle = "Character Profiles";
    final desc =
        "Learn more about the witches and wizards of the magical world.";
    return SliverPadding(
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
              style: theme.textTheme.bodyLarge?.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _CharacterList extends ConsumerWidget {
  const _CharacterList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(charactersViewModelProvider);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: state.characters.length,
        itemBuilder: (context, i) {
          final item = state.characters[i];
          return CharacterItem(
            item: item,
            onTap: () => context.push('/characterDetail/${item.index}'),
          );
        },
      ),
    );
  }
}
