import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/exceptions/character_exception.dart';
import '../../domain/usecase/fetch_single_character_usecase.dart';
import '../providers.dart';
import '../state/character_detail_state.dart';

class CharacterDetailViewModel extends Notifier<CharacterDetailState> {
  late final FetchSingleCharacterUseCase _fetchSingleCharacterUseCase = ref
      .watch(fetchSingleCharacterUseCaseProvider);

  @override
  CharacterDetailState build() => CharacterDetailState.initial();

  Future<void> fetchSingleCharacter({required int index}) async {
    state = state.copyWith(isLoading: true);
    try {
      final character = await _fetchSingleCharacterUseCase(index: index);
      state = state.copyWith(
        isLoading: false,
        character: character,
        error: null,
      );
    } on CharacterException catch (exception) {
      _handleError(exception);
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
