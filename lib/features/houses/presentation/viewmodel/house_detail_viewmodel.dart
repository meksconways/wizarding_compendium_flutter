import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/exceptions/house_exception.dart';
import '../../domain/usecase/fetch_house_usecase.dart';
import '../providers.dart';
import '../state/house_detail_state.dart';

class HouseDetailViewModel extends Notifier<HouseDetailState> {
  late final FetchHouseUseCase _fetchHouseUseCase = ref.watch(
    fetchHouseUseCaseProvider,
  );

  @override
  HouseDetailState build() => HouseDetailState.initial();

  Future<void> fetchHouse(int index) async {
    state = state.copyWith(isLoading: true);
    try {
      final house = await _fetchHouseUseCase(index: index);
      state = state.copyWith(isLoading: false, house: house, error: null);
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
