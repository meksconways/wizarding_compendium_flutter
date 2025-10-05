import '../model/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
  Future<Character> getSingleCharacter(int index);
}