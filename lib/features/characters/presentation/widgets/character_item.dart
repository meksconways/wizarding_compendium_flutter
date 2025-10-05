import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter/core/theme/house_colors_theme.dart';

import '../../domain/model/character.dart';

class CharacterItem extends StatelessWidget {
  final Character item;
  final VoidCallback onTap;

  const CharacterItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final houseColor = HouseColorTheme.getForHouse(item.hogwartsHouse);
    return Material(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: houseColor.border,
                        blurRadius: 60,
                        offset: Offset.zero,
                        spreadRadius: 10,
                      ),
                    ],
                  ),

                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipOval(
                      child: _CharacterImage(imageUrl: item.image),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 0,
                  ),
                  child: Text(
                    item.fullName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  final String imageUrl;

  const _CharacterImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (_, _) => const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (_, _, _) => const Icon(Icons.person_off_rounded),
    );
  }
}
