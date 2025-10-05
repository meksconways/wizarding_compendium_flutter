import '../model/character.dart';
import '../repository/character_repository.dart';

class FetchSingleCharacterUseCase {
  final CharacterRepository _characterRepository;

  FetchSingleCharacterUseCase(this._characterRepository);

  Future<Character> call({required int index}) async =>
      _characterRepository.getSingleCharacter(index);
}
