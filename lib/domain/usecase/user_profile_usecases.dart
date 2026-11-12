import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/repositories/user_profile_imp.dart';
import 'package:habix/domain/entity/UserProfile.dart';

class UserProfileUsecases {
  final UserProfileRepositoryImp _userProfileRepositoryImp = UserProfileRepositoryImp();
  
  Future<Result<bool>> setProfile(UserProfile user)async{
    return _userProfileRepositoryImp.setProfile(user);
  }
  Future<Result<UserProfile>> fetchUserDetails(){
    return _userProfileRepositoryImp.fethUserDetails();
  }
}