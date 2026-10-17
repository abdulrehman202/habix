import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/repositories/user_auth_imp.dart';
import 'package:habix/domain/models/UserAuth.dart';

class UserAuthUsecases {
  final UserAuthRepositoryImp _userAuthRepositoryImp = UserAuthRepositoryImp();
  
  Future<Result<bool>> createUser(UserAuth user)async{
    return _userAuthRepositoryImp.createUser(user);
  }
  Future<Result<String>> login(UserAuth user){
    return _userAuthRepositoryImp.login(user);
  }
}