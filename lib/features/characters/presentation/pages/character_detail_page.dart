import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../../../../core/theme/house_colors_theme.dart';

class CharacterDetailPage extends ConsumerStatefulWidget {
  final int index;

  const CharacterDetailPage({super.key, required this.index});

  @override
  ConsumerState<CharacterDetailPage> createState() =>
      _CharacterDetailPageState();
}

class _CharacterDetailPageState extends ConsumerState<CharacterDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final s = ref.read(characterDetailViewModelProvider);
      if (s.character == null) {
        ref
            .read(characterDetailViewModelProvider.notifier)
            .fetchSingleCharacter(index: widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterDetailViewModelProvider);
    final theme = Theme.of(context);

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.error != null) {
      return Scaffold(
        body: Center(
          child: Text(state.error!, style: theme.textTheme.bodyLarge),
        ),
      );
    }
    final c = state.character!;
    final houseColor = HouseColorTheme.getForHouse(c.hogwartsHouse);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: height * 0.6,
            elevation: 0,
            systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Text(
              c.fullName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(imageUrl: c.image, fit: BoxFit.cover),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.35),
                            Colors.black.withValues(alpha: 0.55),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: kToolbarHeight + MediaQuery.of(context).padding.top,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 48),
                child: _CharacterBody(
                  name: c.fullName,
                  nickname: c.nickname,
                  house: c.hogwartsHouse,
                  actor: c.interpretedBy,
                  children: c.children,
                  birthdate: c.birthdate,
                  accent: houseColor.border,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterBody extends StatelessWidget {
  final String name;
  final String nickname;
  final String house;
  final String actor;
  final List<String> children;
  final String birthdate;
  final Color accent;

  const _CharacterBody({
    required this.name,
    required this.nickname,
    required this.house,
    required this.actor,
    required this.children,
    required this.birthdate,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;

    Widget row(String label, String value, {IconData? icon}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: accent),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$label  ',
                      style: t.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    TextSpan(
                      text: value.isEmpty ? '-' : value,
                      style: t.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.22)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: t.textTheme.headlineSmall?.copyWith(
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 16),

          row('Nickname:', nickname, icon: Icons.badge_rounded),
          row('House:', house, icon: Icons.shield_rounded),
          row('Portrayed by:', actor, icon: Icons.person_rounded),
          row('Birthdate:', birthdate, icon: Icons.cake_rounded),
          row(
            'Children:',
            children.isEmpty ? '-' : children.join(', '),
            icon: Icons.family_restroom_rounded,
          ),
        ],
      ),
    );
  }
}
