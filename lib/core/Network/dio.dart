import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dioObj;

  DioClient();

  static getDioObj() {
    _dioObj ??= Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8000',
        connectTimeout: Duration(seconds: 5),
      ),
    );

    return _dioObj;
  }
}
