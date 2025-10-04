import '../../domain/model/house.dart';

class HouseDto {
  final String? house;
  final String? emoji;
  final String? founder;
  final List<String>? colors;
  final String? animal;
  final int? index;

  const HouseDto({
    this.house,
    this.emoji,
    this.founder,
    this.colors,
    this.animal,
    this.index,
  });

  factory HouseDto.fromJson(Map<String, dynamic> json) {
    return HouseDto(
      house: json['house'] as String?,
      emoji: json['emoji'] as String?,
      founder: json['founder'] as String?,
      colors: (json['colors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      animal: json['animal'] as String?,
      index: json['index'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'house': house,
    'emoji': emoji,
    'founder': founder,
    'colors': colors,
    'animal': animal,
    'index': index,
  };

  House toDomain() => House(
    name: house ?? "",
    emoji: emoji ?? "",
    founder: founder ?? "",
    colors: colors ?? const [],
    animal: animal ?? "",
    index: index ?? 0,
  );
}
