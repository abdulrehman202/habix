import 'package:dio/dio.dart';
import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Network/dio.dart';
import 'package:habix/data/model/habit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitRemoteDataSource {

  Future<String> getTokenFromLocalStorage()async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token')??'';
  }
  
  Future<List<HabitModel>> getAllHabits() async {
    try {
      List<HabitModel> list = [];
      Dio dio = DioClient.getDioObj();
      String token = await getTokenFromLocalStorage();
      Response response = await dio.get('/habits/',
      options: Options(
          headers: {
            'Content-Type':
                'application/json', // Let the server know it is JSON
                'Authorization':'Bearer $token'
          },
        ),
      );
      if (response.statusCode == 200) {
        final resData = response.data;
        final decodedJson = resData['allHabitsList'] as List;

        for (var listItem in decodedJson) {
          HabitModel habitModel = HabitModel.fromJson(listItem);
          list.add(habitModel);
        }
      }
      return list;
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

  Future<List<HabitModel>> addHabit(HabitModel habit) async {
    try {
      Dio dio = DioClient.getDioObj();
      final json = habit.toJson();

      Response response = await dio.post(
        '/habits/add',
        data: json,
        options: Options(
          headers: {
            'Content-Type':
                'application/json', // Let the server know it is JSON
          },
        ),
      );
      List<HabitModel>  list = [];
      if(response.statusCode==200)
    {
      final resData = response.data;
        final decodedJson = resData['allHabits'] as List;

        for (var listItem in decodedJson) {
          HabitModel habitModel = HabitModel.fromJson(listItem);
          list.add(habitModel);
        }
    }
    else {
        throw ServerFailure(statusCode: response.statusCode??404);
      }
      return list;
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

  Future<List<HabitModel>> updateHabit(HabitModel habit) async {
    try {
      Dio dio = DioClient.getDioObj();
      final json = habit.toJson();

      Response response = await dio.put(
        '/habits/update',
        data: json,
        options: Options(
          headers: {
            'Content-Type':
                'application/json', // Let the server know it is JSON
          },
        ),
      );
      List<HabitModel>  list = [];
      if(response.statusCode==200)
    {
      final resData = response.data;
        final decodedJson = resData['updatedHabits'] as List;

        for (var listItem in decodedJson) {
          HabitModel habitModel = HabitModel.fromJson(listItem);
          list.add(habitModel);
        }
    }
    else {
        throw ServerFailure(statusCode: response.statusCode??404);
      }
      return list;
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

  Future<List<HabitModel>> removeHabit(String habitId) async {
    try {
      Dio dio = DioClient.getDioObj();
      
      Response response = await dio.delete(
        '/habits/remove/$habitId'
      );

      List<HabitModel>  list = [];
      if(response.statusCode==200)
    {
      final resData = response.data;
        final decodedJson = resData['updatedHabits'] as List;

        for (var listItem in decodedJson) {
          HabitModel habitModel = HabitModel.fromJson(listItem);
          list.add(habitModel);
        }
    }
    else {
        throw ServerFailure(statusCode: response.statusCode??404);
      }
      return list;
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
