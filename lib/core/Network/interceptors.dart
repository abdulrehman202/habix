import 'package:dio/dio.dart';
import 'package:habix/utilities/storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
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
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response!.statusCode == 401) {
      try {
        //refresh token here
        final refreshToken = getDataFromLocalStorage('refreshToken');
        final response = await dio.post(
          '/user/refresh',
          data: {'refreshToken': refreshToken},
        );
        final token = response.data['token'];
        //add that token to shared preference
        await addDataToLocalStorage('token', token);
        //make request again with new token
        err.requestOptions.headers['Authorization'] = 'Bearer $token';

        Response newResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(newResponse);
      } catch (_) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
