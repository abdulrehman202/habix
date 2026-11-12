import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/Mappers/user_profile_mapper.dart';
import 'package:habix/data/datasource/userProfile/remote_datasource.dart';
import 'package:habix/data/model/user_profile_model.dart';
import 'package:habix/domain/entity/UserProfile.dart';
import 'package:habix/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImp implements UserProfileRespository {

  final UserProfileRemoteDataSource _userProfileRemoteDataSource = UserProfileRemoteDataSource();
  @override
  Future<Result<bool>> setProfile(UserProfile user) async{
    try{
      UserProfileModel userProfileModel = user.toModel;
      UserProfileModel userCreated = await _userProfileRemoteDataSource.setProfile(userProfileModel);
      return Result.ok(true);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<UserProfile>> fethUserDetails() async {
    try{
      UserProfileModel userProfileModel = await _userProfileRemoteDataSource.getUserProfile();
      UserProfile userProfile = userProfileModel.toEntity;
      return Result.ok(userProfile);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }

  }
 }