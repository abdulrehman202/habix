import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:habix/core/utilities/enums.dart';
import 'package:habix/data/model/habit_model.dart';

final Map<String, Category> catMap = {
  'ALL': Category.ALL,
  'MORNING':Category.MORNING,
  'HEALTH':Category.HEALTH,
  'MIND':Category.MIND,
  'PRODUCTIVITY':Category.PRODUCTIVITY,
  'OTHER':Category.OTHER
};

final Map<String, HabitInterval> intervalMap = {
  'DAILY': HabitInterval.DAILY,
  'WEEKDAYS': HabitInterval.WEEKDAYS,
  'WEEKEND': HabitInterval.WEEKEND,
};
class HabitRemoteDataSource{

  final dio = Dio(BaseOptions(
  baseUrl: 'http://localhost:8000',
  connectTimeout: Duration(seconds: 5),
));

  Future<Response> getAllHabits() async
  {
    try{
    final response = await dio.get(
    '/habits/',
  );

  
    return response;
    }
    catch(e)
    {
      rethrow;
    }
  }
}