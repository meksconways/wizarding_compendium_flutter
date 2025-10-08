import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/core_providers.dart';
import '../../features/spells/data/datasource/spell_remote_ds.dart';
import '../../features/spells/data/repository/spell_repository_impl.dart';
import '../../features/spells/domain/repository/spell_repository.dart';

final spellRepositoryImplProvider = Provider<SpellRepository>((ref) {
  final api = ref.watch(hpApiProvider);
  final ds  = SpellRemoteDataSource(api);
  return SpellRepositoryImpl(ds);
});