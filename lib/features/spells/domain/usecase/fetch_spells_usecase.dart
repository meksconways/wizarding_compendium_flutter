import 'package:harry_potter/features/spells/domain/model/spell.dart';
import 'package:harry_potter/features/spells/domain/repository/spell_repository.dart';

class FetchSpellsUseCase {
  final SpellRepository _spellRepository;
  FetchSpellsUseCase(this._spellRepository);

  Future<List<Spell>> call() => _spellRepository.getSpells();
}