import '../../domain/model/character.dart';

class CharacterDetailState {
  final bool isLoading;
  final Character? character;
  final String? error;

  const CharacterDetailState({
    required this.isLoading,
    required this.character,
    this.error,
  });

  factory CharacterDetailState.initial() =>
      const CharacterDetailState(isLoading: true, character: null, error: null);

  CharacterDetailState copyWith({
    bool? isLoading,
    Character? character,
    String? error,
  }) {
    return CharacterDetailState(
      isLoading: isLoading ?? this.isLoading,
      character: character ?? this.character,
      error: error,
    );
  }
}
