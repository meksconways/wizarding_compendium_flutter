import 'package:harry_potter/features/houses/domain/repository/house_repository.dart';

import '../model/house.dart';

class FetchHousesUseCase {
  final HouseRepository _houseRepository;

  FetchHousesUseCase(this._houseRepository);

  Future<List<House>> call() async => _houseRepository.list();
}
