import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/entity/UserProfile.dart';

abstract class UserProfileRespository{

  Future<Result<UserProfile>> updateProfile(UserProfile user);
  Future<Result<UserProfile>> fethUserDetails();
}