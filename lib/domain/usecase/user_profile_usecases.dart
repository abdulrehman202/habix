import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/entity/UserProfile.dart';
import 'package:habix/domain/repositories/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserProfileUsecases {
  final UserProfileRespository _userProfileRepositoryImp;

  UserProfileUsecases(this._userProfileRepositoryImp);
  
  Future<Result<UserProfile>> updateProfile(UserProfile user)async{
    return _userProfileRepositoryImp.updateProfile(user);
  }
  Future<Result<UserProfile>> fetchUserDetails(){
    return _userProfileRepositoryImp.fethUserDetails();
  }

}