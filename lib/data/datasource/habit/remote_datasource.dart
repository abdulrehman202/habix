import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:habix/core/Error/ErrorInfo.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/core/Network/dio.dart';
import 'package:habix/data/model/habit_model.dart';
import 'package:habix/utilities/enums.dart';

final Map<String, Category> catMap = {
  'ALL': Category.ALL,
  'MORNING': Category.MORNING,
  'HEALTH': Category.HEALTH,
  'MIND': Category.MIND,
  'PRODUCTIVITY': Category.PRODUCTIVITY,
  'OTHER': Category.OTHER,
};

final Map<String, HabitInterval> intervalMap = {
  'DAILY': HabitInterval.DAILY,
  'WEEKDAYS': HabitInterval.WEEKDAYS,
  'WEEKEND': HabitInterval.WEEKEND,
};

class HabitRemoteDataSource {
  Future<Response> getAllHabits() async {
    try {
      final dio = DioClient.getDioObj();
      Response response = await dio.get('/habits/');
      return response;
    } catch (e) {
    rethrow;  
    }
  }

  Future<Response> addHabit(HabitModel habit) async {
    try {
      Dio dio = DioClient.getDioObj();
      final json = habit.toJson();
      
      Response response = await dio.post('/habits/add',data: json,options: Options(
        headers: {
          'Content-Type': 'application/json', // Let the server know it is JSON
        },
      ),);
      return response;
    } catch (e) {
    rethrow;  
    }
  }
}
