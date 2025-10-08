import 'package:harry_potter/core/network/hp_api.dart';
import 'package:harry_potter/features/spells/data/dto/spell_dto.dart';

class SpellRemoteDataSource {
  final HpApi _api;

  SpellRemoteDataSource(this._api);

  Future<List<SpellDTO>> getSpells() async {
    final spells = await _api.getList('/spells');
    return spells.map((spell) => SpellDTO.fromJson(spell)).toList();
  }
}
