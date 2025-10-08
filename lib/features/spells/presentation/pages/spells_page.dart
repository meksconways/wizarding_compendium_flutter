import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/core/widgets/error_widget.dart';
import 'package:harry_potter/core/widgets/loading_widget.dart';
import 'package:harry_potter/features/spells/presentation/providers.dart';

class SpellsPage extends ConsumerStatefulWidget {
  const SpellsPage({super.key});

  @override
  ConsumerState<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends ConsumerState<SpellsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final s = ref.read(spellsViewModelProvider);
      if (s.spells.isEmpty) {
        ref.read(spellsViewModelProvider.notifier).fetchSpells();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(spellsViewModelProvider);

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
        child: CustomScrollView(
          slivers: const [_TitleSection(), _SpellTable()],
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spell Index',
              style: t.textTheme.titleLarge?.copyWith(
                color: cs.onSurface,
                fontSize: 32,
                fontFamily: 'PlayfairDisplay',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A comprehensive list of spells, their pronunciations, and their effects.',
              style: t.textTheme.bodyLarge?.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _SpellTable extends ConsumerWidget {
  const _SpellTable();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context);
    final cs = t.colorScheme;
    final state = ref.watch(spellsViewModelProvider);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cs.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: cs.primary,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Spell',
                        style: t.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.secondary,
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Effect',
                        style: t.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.secondary,
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ...List.generate(state.spells.length, (i) {
                final s = state.spells[i];
                return _SpellRow(
                  key: ValueKey(i),
                  name: s.spell,
                  effect: s.use,
                  softColor: i % 2 == 0,
                  showDivider: i != state.spells.length - 1,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpellRow extends StatelessWidget {
  final String name;
  final String effect;
  final bool showDivider;
  final bool softColor;

  const _SpellRow({
    super.key,
    required this.name,
    required this.effect,
    required this.softColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;

    final row = Container(
      color: softColor ? cs.surface : cs.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: t.textTheme.titleMedium?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: Text(
                effect,
                softWrap: true,
                style: t.textTheme.bodyLarge?.copyWith(
                  color: cs.onSurface,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!showDivider) return row;

    return Column(
      children: [
        row,
        Divider(
          height: 1,
          thickness: 1,
          color: cs.outlineVariant.withValues(alpha: 0.25),
        ),
      ],
    );
  }
}
