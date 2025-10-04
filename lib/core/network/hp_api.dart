import 'package:dio/dio.dart';
import 'dio_client.dart';

class HpApi {
  final Dio _dio;
  HpApi({Dio? dio}) : _dio = dio ?? DioClient.dio;

  Future<List<Map<String, dynamic>>> getList(String path, {Map<String, dynamic>? qp}) async {
    final response = await _dio.get(path, queryParameters: qp);
    final data = response.data;
    if (data is List) return data.cast<Map<String, dynamic>>();
    throw Exception('Unexpected list response: $path');
  }

  Future<Map<String, dynamic>> getSingleItem(String path, {Map<String, dynamic>? qp}) async {
    final response = await _dio.get(path, queryParameters: qp);
    final data = response.data;
    if (data is Map<String, dynamic>) return data;
    throw Exception('Unexpected map response: $path');
  }

}