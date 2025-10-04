import 'package:harry_potter/core/network/hp_api.dart';

import '../dto/house_dto.dart';

class HousesRemoteDataSource {
  final HpApi _api;

  HousesRemoteDataSource(this._api);

  Future<List<HouseDto>> getHouses() async {
    final houses = await _api.getList('/houses');
    return houses.map((house) => HouseDto.fromJson(house)).toList();
  }

  Future<HouseDto> getSingleHouse({required int index}) async {
    final qp = <String, dynamic>{};
    qp["index"] = index;
    final house = await _api.getSingleItem('/houses', qp: qp);
    return HouseDto.fromJson(house);
  }
}
