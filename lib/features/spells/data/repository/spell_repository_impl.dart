import 'package:dio/dio.dart';
import 'package:harry_potter/features/spells/domain/exceptions/spell_exception.dart';
import 'package:harry_potter/features/spells/domain/model/spell.dart';
import 'package:harry_potter/features/spells/domain/repository/spell_repository.dart';

import '../datasource/spell_remote_ds.dart';

class SpellRepositoryImpl extends SpellRepository {
  final SpellRemoteDataSource _remoteDataSource;

  SpellRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Spell>> getSpells() async {
    try {
      final spells = await _remoteDataSource.getSpells();
      return spells.map((spell) => spell.toDomain()).toList();
    } on DioException catch (e, s) {
      throw SpellFetchException('Network error while fetching spells', e, s);
    } on FormatException catch (e, s) {
      throw SpellInvalidDataException('Invalid data format: ${e.message}', s);
    } on TypeError catch (e, s) {
      throw SpellInvalidDataException('Invalid data shape: $e', s);
    } catch (e, s) {
      throw SpellFetchException('Unexpected error', e, s);
    }
  }
}
