import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:habix/data/model/user_profile_model.dart';
import 'package:habix/utilities/storage.dart';
import 'package:injectable/injectable.dart';

abstract class UserProfileLocalDataSource{
  Future<UserProfileModel> getUserProfile();
  void addToCache( Map<String, dynamic> resData);
}

@LazySingleton(as: UserProfileLocalDataSource)
class UserProfileLocalDataSourceImp implements UserProfileLocalDataSource{
  final _cache = DefaultCacheManager();

@override
  Future<UserProfileModel> getUserProfile() async
{
  try{
  final email = await getDataFromLocalStorage('email');
  final fileInfo = await _cache.getFileFromMemory('userProfile-$email');
  final File? file = fileInfo?.file;
  final decodedJson = jsonDecode(file!.readAsStringSync());
  return UserProfileModel.fromJson(decodedJson);
  }
  catch(e)
  {
    rethrow;
  }
}

// ignore: annotate_overrides
Future<void> addToCache( Map<String, dynamic> resData)
async {
  final email = await getDataFromLocalStorage('email');
  String jsonString = jsonEncode(resData);
  _cache.putFile('userProfile-$email', utf8.encode(jsonString));
}

}