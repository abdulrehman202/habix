import 'package:dio/dio.dart';
import 'package:habix/utilities/storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
      String token = await getDataFromLocalStorage('token');
    options.headers['Authorization'] = 'Bearer $token';
    
    // Always call handler.next() to forward the request
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}