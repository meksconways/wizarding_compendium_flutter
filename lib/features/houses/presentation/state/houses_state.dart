import '../../domain/model/house.dart';

class HousesState {
  final bool isLoading;
  final List<House> houses;
  final String? error;

  const HousesState({
    required this.isLoading,
    required this.houses,
    this.error,
  });

  factory HousesState.initial() =>
      const HousesState(isLoading: true, houses: [], error: null);

  HousesState copyWith({bool? isLoading, List<House>? houses, String? error}) {
    return HousesState(
      isLoading: isLoading ?? this.isLoading,
      houses: houses ?? this.houses,
      error: error,
    );
  }
}
