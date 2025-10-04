import 'package:dio/dio.dart';
import 'package:harry_potter/features/houses/domain/model/house.dart';

import '../../domain/exceptions/house_exception.dart';
import '../../domain/repository/house_repository.dart';
import '../datasource/houses_remote_data_source.dart';

class HouseRepositoryImpl extends HouseRepository {
  final HousesRemoteDataSource _remoteDataSource;

  HouseRepositoryImpl(this._remoteDataSource);

  @override
  Future<House> getSingleHouse(int index) async {
    try {
      final house = await _remoteDataSource.getSingleHouse(index: index);
      return house.toDomain();
    } on DioException catch (e, s) {
      throw HouseFetchException('Network error while fetching books', e, s);
    } on FormatException catch (e) {
      throw HouseInvalidDataException('Invalid data format: ${e.message}');
    } catch (e, s) {
      throw HouseFetchException('Unexpected error', e, s);
    }
  }

  @override
  Future<List<House>> list() async {
    try {
      final houses = await _remoteDataSource.getHouses();
      return houses.map((house) => house.toDomain()).toList();
    } on DioException catch (e, s) {
      throw HouseFetchException('Network error while fetching books', e, s);
    } on FormatException catch (e) {
      throw HouseInvalidDataException('Invalid data format: ${e.message}');
    } catch (e, s) {
      throw HouseFetchException('Unexpected error', e, s);
    }
  }
}
