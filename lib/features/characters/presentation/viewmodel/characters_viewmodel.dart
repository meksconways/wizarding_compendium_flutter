import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/features/characters/domain/exceptions/character_exception.dart';

import '../../domain/usecase/fetch_characters_usecase.dart';
import '../providers.dart';
import '../state/characters_state.dart';

class CharactersViewModel extends Notifier<CharactersState> {
  late final FetchCharactersUseCase _fetchCharactersUseCase = ref.watch(
    fetchCharactersUseCaseProvider,
  );

  @override
  CharactersState build() => CharactersState.initial();

  Future<void> fetchCharacters() async {
    state = state.copyWith(isLoading: true);
    try {
      final characters = await _fetchCharactersUseCase();
      state = state.copyWith(
        isLoading: false,
        characters: characters,
        error: null,
      );
    } on CharacterException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(CharacterException exception) {
    switch (exception) {
      case CharacterFetchException():
        state = state.copyWith(
          isLoading: false,
          error: 'Connection Error. Pls try again.',
        );
      case CharacterNotFoundException():
        state = state.copyWith(
          isLoading: false,
          error: 'Characters are not found.',
        );
      case CharacterInvalidDataException():
        state = state.copyWith(
          isLoading: false,
          error: 'Data format is invalid.',
        );
    }
  }
}
