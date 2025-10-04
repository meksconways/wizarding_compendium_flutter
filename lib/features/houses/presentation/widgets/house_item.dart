import 'package:flutter/material.dart';
import '../../../../core/theme/house_colors_theme.dart';
import '../../domain/model/house.dart';

class HouseItem extends StatelessWidget {
  final House house;
  final VoidCallback? onTap;

  const HouseItem({super.key, required this.house, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final colorTheme = HouseColorTheme.getForHouse(house.name);
    final borderColor = colorTheme.border;
    final bgColor = colorTheme.background;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 1.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(house.emoji, style: const TextStyle(fontSize: 64)),
                const SizedBox(height: 12),
                Text(
                  house.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
