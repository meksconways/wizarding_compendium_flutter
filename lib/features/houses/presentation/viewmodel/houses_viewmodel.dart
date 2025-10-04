import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/exceptions/house_exception.dart';
import '../../domain/usecase/fetch_houses_usecase.dart';
import '../providers.dart';
import '../state/houses_state.dart';

class HousesViewModel extends Notifier<HousesState> {
  late final FetchHousesUseCase _fetchHouseUseCase = ref.watch(
    fetchHousesUseCaseProvider,
  );

  @override
  HousesState build() => HousesState.initial();

  Future<void> fetchHouses() async {
    state = state.copyWith(isLoading: true);
    try {
      final houses = await _fetchHouseUseCase();
      state = state.copyWith(isLoading: false, houses: houses, error: null);
    } on HouseException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(HouseException exception) {
    switch (exception) {
      case HouseFetchException():
        state = state.copyWith(
          isLoading: false,
          error: 'Connection Error. Pls try again.',
        );
      case HouseNotFoundException():
        state = state.copyWith(
          isLoading: false,
          error: 'Houses are not found.',
        );
      case HouseInvalidDataException():
        state = state.copyWith(
          isLoading: false,
          error: 'Data format is invalid.',
        );
    }
  }
}
