import 'package:dio/dio.dart';
import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Network/dio.dart';
import 'package:habix/data/model/user_auth_model.dart';

class UserAuthRemoteDataSource{

  Future<String> login(UserAuthModel user) async{
    try {
      
      Dio dio = DioClient.getDioObj();
      final json = user.toJson();
      Response response = await dio.post('/user/login/',
      data:json,
      options: Options(
          headers: {
            'Content-Type':
                'application/json', // Let the server know it is JSON
          },
        ),);
      if (response.statusCode == 200) {
        final resData = response.data;
        final token = resData['token'].toString();
      return token;
      }
      
      
      else{
        throw UnknownError();
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if(status == 401)
      {
        throw AuthError(msg: e.response!.data['message'].toString());
      }
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw const NetworkFailure();

    case DioExceptionType.connectionError:
      throw const NetworkFailure();

    case DioExceptionType.badResponse:
      if (status == 404) throw  ServerFailure(statusCode: status??404);
      throw ServerFailure(statusCode: status??404);

    case DioExceptionType.cancel:
      throw ServerFailure(statusCode: status??404);

    default:
      throw ServerFailure(statusCode: status??404);
  }} catch (e) {
      throw UnknownError();
    }

  }
}