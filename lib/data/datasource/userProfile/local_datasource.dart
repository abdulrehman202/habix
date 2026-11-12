import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:habix/data/model/user_profile_model.dart';
import 'package:injectable/injectable.dart';

abstract class UserProfileLocalDataSource{
  Future<UserProfileModel> getUserProfile();
  void addToCache( Map<String, dynamic> resData);
}

@LazySingleton(as: UserProfileLocalDataSource)
class UserProfileLocalDataSourceImp implements UserProfileLocalDataSource{
  final _cache = DefaultCacheManager();

Future<UserProfileModel> getUserProfile() async
{
  try{
  final fileInfo = await _cache.getFileFromMemory('userProfile');
  final File? file = fileInfo?.file;
  final decodedJson = jsonDecode(file!.readAsStringSync());
  return UserProfileModel.fromJson(decodedJson);
  }
  catch(e)
  {
    rethrow;
  }
}

void addToCache( Map<String, dynamic> resData)
{
  String jsonString = jsonEncode(resData);
  _cache.putFile('userProfile', utf8.encode(jsonString));
}

}