import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:habix/data/model/habit_model.dart';

List<HabitModel> allHabits = [];

class HabitLocalDataSource{
  final _cache = DefaultCacheManager();

Future<List<HabitModel>> getAllHabits() async
{
  try{
  final fileInfo = await _cache.getFileFromMemory('allHabitsList');
  final File? file = fileInfo?.file;
  final decodedJson = jsonDecode(file!.readAsStringSync());
  return (decodedJson['list'] as List).map((e) => HabitModel.fromJson(Map<String, dynamic>.from(e)))
    .toList();
  }
  catch(e)
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