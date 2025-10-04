import '../model/house.dart';
import '../repository/house_repository.dart';

class FetchHouseUseCase {
  final HouseRepository _houseRepository;

  FetchHouseUseCase(this._houseRepository);

  Future<House> call({required int index}) async =>
      _houseRepository.getSingleHouse(index);
}
