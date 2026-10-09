import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:habix/data/model/habit_model.dart';

List<HabitModel> allHabits = [];

class HabitLocalDataSource{
  final _cache = DefaultCacheManager();


Future<Map<String, dynamic>> getAllHabits() async
{
  try{
  final cachedData = _cache.getFileFromMemory('allHabitsList');
  final fileInfo = await cachedData;
  final File? file = fileInfo?.file;
  final decodedJson = jsonDecode(file!.readAsStringSync());
  return decodedJson;
  }
  catch(_)
  {
    rethrow;
  }
}

void addToCache(String key, Map<String, dynamic> resData)
{
  String jsonString = jsonEncode(resData);
  _cache.putFile(key, utf8.encode(jsonString));
}

void updateList(List<HabitModel> list)
{
  allHabits  = [...list];
}

}