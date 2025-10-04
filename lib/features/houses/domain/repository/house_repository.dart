import 'package:harry_potter/features/houses/domain/model/house.dart';

abstract class HouseRepository {
  Future<List<House>> list();
  Future<House> getSingleHouse(int index);
}