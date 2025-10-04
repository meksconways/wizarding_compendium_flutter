import 'package:harry_potter/features/houses/domain/model/house.dart';

class HouseDetailState {
  final bool isLoading;
  final House? house;
  final String? error;

  const HouseDetailState({
    required this.isLoading,
    required this.house,
    this.error,
  });

  factory HouseDetailState.initial() =>
      const HouseDetailState(isLoading: true, house: null, error: null);

  HouseDetailState copyWith({bool? isLoading, House? house, String? error}) {
    return HouseDetailState(
      isLoading: isLoading ?? this.isLoading,
      house: house ?? this.house,
      error: error,
    );
  }
}
