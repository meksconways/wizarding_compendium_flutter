import '../../domain/model/character.dart';

class CharacterDTO {
  final String? fullName;
  final String? nickname;
  final String? hogwartsHouse;
  final String? interpretedBy;
  final List<String>? children;
  final String? image;
  final String? birthdate;
  final int? index;

  CharacterDTO({
    this.fullName,
    this.nickname,
    this.hogwartsHouse,
    this.interpretedBy,
    this.children,
    this.image,
    this.birthdate,
    this.index,
  });

  factory CharacterDTO.fromJson(Map<String, dynamic> json) {
    return CharacterDTO(
      fullName: json['fullName'] as String?,
      nickname: json['nickname'] as String?,
      hogwartsHouse: json['hogwartsHouse'] as String?,
      interpretedBy: json['interpretedBy'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      image: json['image'] as String?,
      birthdate: json['birthdate'] as String?,
      index: json['index'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'nickname': nickname,
      'hogwartsHouse': hogwartsHouse,
      'interpretedBy': interpretedBy,
      'children': children,
      'image': image,
      'birthdate': birthdate,
      'index': index,
    };
  }

  Character toDomain() {
    return Character(
      fullName: fullName ?? "",
      nickname: nickname ?? "",
      hogwartsHouse: hogwartsHouse ?? "",
      interpretedBy: interpretedBy ?? "",
      children: children ?? const [],
      image: image ?? "",
      birthdate: birthdate ?? "",
      index: index ?? 0,
    );
  }
}
