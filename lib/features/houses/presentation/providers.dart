import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/features/houses/presentation/state/house_detail_state.dart';

import '../../../core/di/core_providers.dart';
import '../data/datasource/houses_remote_data_source.dart';
import '../data/repository/house_repository_impl.dart';
import '../domain/usecase/fetch_house_usecase.dart';
import '../domain/usecase/fetch_houses_usecase.dart';
import 'state/houses_state.dart';
import 'viewmodel/house_detail_viewmodel.dart';
import 'viewmodel/houses_viewmodel.dart';

//Data layer
final housesRemoteDataSourceProvider = Provider(
  (ref) => HousesRemoteDataSource(ref.watch(hpApiProvider)),
);

final houseRepositoryProvider = Provider(
  (ref) => HouseRepositoryImpl(ref.watch(housesRemoteDataSourceProvider)),
);

//Domain layer
final fetchHousesUseCaseProvider = Provider(
  (ref) => FetchHousesUseCase(ref.watch(houseRepositoryProvider)),
);

final fetchHouseUseCaseProvider = Provider(
  (ref) => FetchHouseUseCase(ref.watch(houseRepositoryProvider)),
);

//Presentation layer
final housesViewModelProvider =
    NotifierProvider.autoDispose<HousesViewModel, HousesState>(
      HousesViewModel.new,
    );

final houseDetailViewModelProvider =
    NotifierProvider.autoDispose<HouseDetailViewModel, HouseDetailState>(
      HouseDetailViewModel.new,
    );
