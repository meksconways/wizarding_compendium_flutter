import '../../domain/model/character.dart';

class CharactersState {
  final bool isLoading;
  final List<Character> characters;
  final String? error;

  const CharactersState({
    required this.isLoading,
    required this.characters,
    this.error,
  });

  factory CharactersState.initial() =>
      const CharactersState(isLoading: true, characters: [], error: null);

  CharactersState copyWith({
    bool? isLoading,
    List<Character>? characters,
    String? error,
  }) {
    return CharactersState(
      isLoading: isLoading ?? this.isLoading,
      characters: characters ?? this.characters,
      error: error,
    );
  }
}
