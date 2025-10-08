import 'package:harry_potter/features/spells/domain/model/spell.dart';

abstract class SpellRepository {
  Future<List<Spell>> getSpells();
}