import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:habix/data/model/habit_model.dart';
import 'package:habix/utilities/storage.dart';
import 'package:injectable/injectable.dart';

abstract class HabitLocalDataSource{
  Future<List<HabitModel>> getAllHabits();
  void addToCache(Map<String, dynamic> resData);
}

@LazySingleton(as: HabitLocalDataSource)
class HabitLocalDataSourceImp implements HabitLocalDataSource{
  final _cache = DefaultCacheManager();

@override
  Future<List<HabitModel>> getAllHabits() async
{
  try{
  final email = await getDataFromLocalStorage('email');
  final fileInfo = await _cache.getFileFromMemory('allHabitsList-$email');
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

@override
  Future<void> addToCache(Map<String, dynamic> resData)
async {
  final email = await getDataFromLocalStorage('email');
  String jsonString = jsonEncode(resData);
  _cache.putFile('allHabitsList-$email', utf8.encode(jsonString));
}

}