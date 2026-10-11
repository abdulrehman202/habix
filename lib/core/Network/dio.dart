import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dioObj;

  DioClient();

  static getDioObj() {
    _dioObj ??= Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8000',
        connectTimeout: Duration(seconds: 60),
      ),
    );

    _dioObj!.interceptors.add(
  InterceptorsWrapper(
    onError: (e, handler) {
      if (e.response?.statusCode == 401) {
        // e.g. refresh token or log the user out
      }
      handler.next(e); // pass the error along
    },
  ),
);

    return _dioObj;
  }
}
