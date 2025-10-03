import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static final dio = Dio(
    BaseOptions(
      baseUrl: "https://potterapi-fedeperin.vercel.app",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );
}
