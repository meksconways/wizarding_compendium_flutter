import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/features/characters/presentation/state/character_detail_state.dart';
import 'package:harry_potter/features/characters/presentation/state/characters_state.dart';
import 'package:harry_potter/features/characters/presentation/viewmodel/character_detail_viewmodel.dart';
import 'package:harry_potter/features/characters/presentation/viewmodel/characters_viewmodel.dart';
import '../../../core/di/core_providers.dart';
import '../data/datasource/character_remote_datasource.dart';
import '../data/repository/character_repository_impl.dart';
import '../domain/usecase/fetch_characters_usecase.dart';
import '../domain/usecase/fetch_single_character_usecase.dart';

//Data layer
final characterRemoteDataSourceProvider = Provider(
  (ref) => CharacterRemoteDataSource(ref.watch(hpApiProvider)),
);

final characterRepositoryProvider = Provider(
  (ref) =>
      CharacterRepositoryImpl(ref.watch(characterRemoteDataSourceProvider)),
);

//domain layer
final fetchCharactersUseCaseProvider = Provider(
  (ref) => FetchCharactersUseCase(ref.watch(characterRepositoryProvider)),
);

final fetchSingleCharacterUseCaseProvider = Provider(
  (ref) => FetchSingleCharacterUseCase(ref.watch(characterRepositoryProvider)),
);

//presentation layer
final charactersViewModelProvider =
    NotifierProvider.autoDispose<CharactersViewModel, CharactersState>(
      CharactersViewModel.new,
    );

final characterDetailViewModelProvider =
    NotifierProvider.autoDispose<
      CharacterDetailViewModel,
      CharacterDetailState
    >(CharacterDetailViewModel.new);
