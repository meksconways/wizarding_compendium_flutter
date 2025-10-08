import 'package:harry_potter/features/spells/domain/model/spell.dart';

class SpellsState {
  final bool isLoading;
  final List<Spell> spells;
  final String? error;

  SpellsState({
    required this.isLoading,
    required this.spells,
    required this.error,
  });

  factory SpellsState.initial() =>
      SpellsState(isLoading: false, spells: [], error: null);

  SpellsState copyWith({bool? isLoading, List<Spell>? spells, String? error}) =>
      SpellsState(
        isLoading: isLoading ?? this.isLoading,
        spells: spells ?? this.spells,
        error: error ?? this.error,
      );
}
