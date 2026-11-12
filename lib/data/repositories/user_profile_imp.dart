import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/Mappers/user_profile_mapper.dart';
import 'package:habix/data/datasource/userProfile/local_datasource.dart';
import 'package:habix/data/datasource/userProfile/remote_datasource.dart';
import 'package:habix/data/model/user_profile_model.dart';
import 'package:habix/domain/entity/UserProfile.dart';
import 'package:habix/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImp implements UserProfileRespository {

  final UserProfileRemoteDataSource _userProfileRemoteDataSource = UserProfileRemoteDataSource();
  final UserProfileLocalDataSource _userProfileLocalDataSource = UserProfileLocalDataSource();
  @override
  Future<Result<UserProfile>> updateProfile(UserProfile user) async{
    try{
      UserProfileModel userProfileModel = user.toModel;
      UserProfileModel userCreated = await _userProfileRemoteDataSource.updateProfile(userProfileModel);
      _userProfileLocalDataSource.addToCache( userCreated.toJson());
      
      return Result.ok(userCreated.toEntity);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<UserProfile>> fethUserDetails() async {
    try{
      UserProfileModel userProfileModel;
      try{
        userProfileModel = await _userProfileLocalDataSource.getUserProfile();
      }
      catch(e) 
      {
        userProfileModel = await _userProfileRemoteDataSource.getUserProfile();
      }

      UserProfile userProfile = userProfileModel.toEntity;
      return Result.ok(userProfile);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }

  }

 }