import '../model/character.dart';
import '../repository/character_repository.dart';

class FetchCharactersUseCase {
  final CharacterRepository _characterRepository;

  FetchCharactersUseCase(this._characterRepository);

  Future<List<Character>> call() async =>
      _characterRepository.getCharacters();
}
