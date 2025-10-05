import 'package:dio/dio.dart';

import '../../domain/exceptions/character_exception.dart';
import '../../domain/model/character.dart';
import '../../domain/repository/character_repository.dart';
import '../datasource/character_remote_datasource.dart';

class CharacterRepositoryImpl extends CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;

  CharacterRepositoryImpl(this._remoteDataSource);

  @override
  Future<Character> getSingleCharacter(int index) async {
    try {
      final character = await _remoteDataSource.getSingleCharacter(
        index: index,
      );
      return character.toDomain();
    } on DioException catch (e, s) {
      throw CharacterFetchException('Network error while fetching books', e, s);
    } on FormatException catch (e) {
      throw CharacterInvalidDataException('Invalid data format: ${e.message}');
    } catch (e, s) {
      throw CharacterFetchException('Unexpected error', e, s);
    }
  }

  @override
  Future<List<Character>> getCharacters() async {
    try {
      final houses = await _remoteDataSource.getCharacters();
      return houses.map((house) => house.toDomain()).toList();
    } on DioException catch (e, s) {
      throw CharacterFetchException('Network error while fetching books', e, s);
    } on FormatException catch (e) {
      throw CharacterInvalidDataException('Invalid data format: ${e.message}');
    } catch (e, s) {
      throw CharacterFetchException('Unexpected error', e, s);
    }
  }
}
