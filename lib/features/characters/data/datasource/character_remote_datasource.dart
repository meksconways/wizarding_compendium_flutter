import 'package:harry_potter/core/network/hp_api.dart';
import 'package:harry_potter/features/characters/data/dto/character_dto.dart';

class CharacterRemoteDataSource {
  final HpApi _api;

  CharacterRemoteDataSource(this._api);

  Future<List<CharacterDTO>> getCharacters() async {
    final houses = await _api.getList('/characters');
    return houses.map((house) => CharacterDTO.fromJson(house)).toList();
  }

  Future<CharacterDTO> getSingleCharacter({required int index}) async {
    final qp = <String, dynamic>{};
    qp["index"] = index;
    final house = await _api.getSingleItem('/characters', qp: qp);
    return CharacterDTO.fromJson(house);
  }
}
