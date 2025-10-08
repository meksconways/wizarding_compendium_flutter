import '../../domain/model/spell.dart';

class SpellDTO {
  final String? spell;
  final String? use;
  final int? index;

  SpellDTO({required this.spell, required this.use, required this.index});

  factory SpellDTO.fromJson(Map<String, dynamic> json) {
    return SpellDTO(
      spell: json['spell'] as String?,
      use: json['use'] as String?,
      index: json['index'] as int?,
    );
  }

  Spell toDomain() {
    return Spell(spell: spell ?? "", use: use ?? "", index: index ?? 0);
  }
}
