import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dioObj;

  DioClient();

  static getDioObj() {
    _dioObj ??= Dio(
      BaseOptions(
        baseUrl: 'https://habix-backend-igvi.onrender.com',// 'http://localhost:8000',
        connectTimeout: Duration(seconds: 60),
      ),
    );

    return _dioObj;
  }
}
