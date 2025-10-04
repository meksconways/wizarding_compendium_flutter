import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/house_colors_theme.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/model/house.dart';
import '../providers.dart';

class HouseDetailPage extends ConsumerStatefulWidget {
  final int houseIndex;

  const HouseDetailPage({super.key, required this.houseIndex});

  @override
  ConsumerState<HouseDetailPage> createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends ConsumerState<HouseDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.read(houseDetailViewModelProvider);
      if (state.house == null) {
        ref
            .read(houseDetailViewModelProvider.notifier)
            .fetchHouse(widget.houseIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(houseDetailViewModelProvider);

    if (state.isLoading) {
      return const Scaffold(body: SafeArea(child: LoadingView()));
    }
    if (state.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: SafeArea(child: ErrorView(message: state.error!)),
      );
    }
    final house = state.house;
    if (house == null) {
      return const Scaffold(
        body: SafeArea(child: Center(child: Text('House not found'))),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(house.name)),
      body: SafeArea(child: _HouseDetailBody(house)),
    );
  }
}

class _HouseDetailBody extends StatelessWidget {
  final House house;

  const _HouseDetailBody(this.house);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final houseColor = HouseColorTheme.getForHouse(house.name);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final circlePadding = (maxW * 0.12).clamp(32.0, 72.0);
        final emojiSize = (maxW * 0.22).clamp(72.0, 120.0);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: houseColor.background,
                    border: Border.all(color: houseColor.border, width: 4),
                  ),
                  padding: EdgeInsets.all(circlePadding),
                  child: Text(
                    house.emoji,
                    style: TextStyle(fontSize: emojiSize),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: houseColor.background.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: cs.onSurface.withValues(alpha: 0.28),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      house.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: houseColor.border,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    const SizedBox(height: 24),
                    _iconRow(
                      context,
                      icon: Icons.auto_fix_high_rounded,
                      iconColor: houseColor.border,
                      label: 'Founder:',
                      value: house.founder,
                    ),
                    const SizedBox(height: 16),
                    _iconRow(
                      context,
                      icon: Icons.pets_rounded,
                      iconColor: houseColor.border,
                      label: 'Animal',
                      value: house.animal,
                    ),
                    const SizedBox(height: 16),
                    _iconRow(
                      context,
                      icon: Icons.color_lens_rounded,
                      iconColor: houseColor.border,
                      label: 'Colors',
                      value: house.colors.join(', '),
                    ),
                    const SizedBox(height: 16),
                    _iconRow(
                      context,
                      icon: Icons.emoji_emotions_rounded,
                      iconColor: houseColor.border,
                      label: 'Emoji',
                      value: house.emoji,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _richPair(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label  ',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
          TextSpan(
            text: value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: _richPair(context, label: label, value: value),
        ),
      ],
    );
  }
}
