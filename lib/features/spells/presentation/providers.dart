import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/spells_token.dart';
import '../domain/usecase/fetch_spells_usecase.dart';
import 'state/spells_state.dart';
import 'viewmodel/spells_viewmodel.dart';

final fetchSpellsUseCaseProvider = Provider(
  (ref) => FetchSpellsUseCase(ref.watch(spellRepositoryProvider)),
);

//presentation layer
final spellsViewModelProvider =
    NotifierProvider.autoDispose<SpellsViewModel, SpellsState>(
      SpellsViewModel.new,
    );
