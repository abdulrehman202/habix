import 'package:dio/dio.dart';
import 'package:habix/core/Error/Failures.dart';
import 'package:habix/data/model/user_profile_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserProfileRemoteDataSource{
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateProfile(UserProfileModel userProfile);
  Future<UserProfileModel> setProfile(UserProfileModel userProfile);
}

@LazySingleton(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImp implements UserProfileRemoteDataSource{
  Dio dio;

UserProfileRemoteDataSourceImp(this.dio);

  Future<UserProfileModel> getUserProfile() async {
    try {
      Response response = await dio.get('/userProfile/',
      options: Options(
          headers: {
            'Content-Type':
                'application/json', // Let the server know it is JSON
          },
        ),
      );
      if (response.statusCode == 200) {
        final resData = response.data;
        final decodedJson = resData['userProfile'];

          UserProfileModel userProfileModel = UserProfileModel.fromJson(decodedJson);
          return userProfileModel;
      }
      else {
        throw ServerFailure(statusCode: response.statusCode??404);
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
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

  Future<UserProfileModel> updateProfile(UserProfileModel userProfile) async {
    try {
      final json = userProfile.toJson();

      Response response = await dio.put(
        '/userProfile/update',
        data: json,
        options: Options(
          headers: {
            'Content-Type':
                'application/json', // Let the server know it is JSON
          },
        ),
      );
      
      if(response.statusCode==200)
    {
      final resData = response.data;
        final decodedJson = resData['userProfile'];

         UserProfileModel userProfileModel = UserProfileModel.fromJson(decodedJson);
          return userProfileModel;
        
    }
    else {
        throw ServerFailure(statusCode: response.statusCode??404);
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
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

  @override
  Future<UserProfileModel> setProfile(UserProfileModel userProfile) async {
    try {
      final json = userProfile.toJson();

      Response response = await dio.post(
        '/userProfile/set',
        data: json,
        options: Options(
          headers: {
            'Content-Type':
                'application/json', // Let the server know it is JSON
          },
        ),
      );
      
      if(response.statusCode==200)
    {
      final resData = response.data;
        final decodedJson = resData['userProfile'];

         UserProfileModel userProfileModel = UserProfileModel.fromJson(decodedJson);
          return userProfileModel;
        
    }
    else {
        throw ServerFailure(statusCode: response.statusCode??404);
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
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
