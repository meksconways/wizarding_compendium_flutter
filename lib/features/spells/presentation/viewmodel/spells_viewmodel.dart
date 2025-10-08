import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/features/spells/presentation/state/spells_state.dart';

import '../../domain/exceptions/spell_exception.dart';
import '../../domain/usecase/fetch_spells_usecase.dart';
import '../providers.dart';

class SpellsViewModel extends Notifier<SpellsState> {
  late final FetchSpellsUseCase _fetchSpellsUseCase = ref.read(
    fetchSpellsUseCaseProvider,
  );

  @override
  SpellsState build() => SpellsState.initial();

  Future<void> fetchSpells() async {
    state = state.copyWith(isLoading: true);
    try {
      final spells = await _fetchSpellsUseCase();
      state = state.copyWith(isLoading: false, spells: spells, error: null);
    } on SpellException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(SpellException exception) {
    switch (exception) {
      case SpellFetchException():
        state = state.copyWith(
          isLoading: false,
          error: 'Connection Error. Pls try again.',
        );
      case SpellNotFoundException():
        state = state.copyWith(
          isLoading: false,
          error: 'Characters are not found.',
        );
      case SpellInvalidDataException():
        state = state.copyWith(
          isLoading: false,
          error: 'Data format is invalid.',
        );
    }
  }
}
