import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/repository/spell_repository.dart';

final spellRepositoryProvider = Provider<SpellRepository>((ref) {
  throw UnimplementedError('Provide SpellRepository in app composition root');
});