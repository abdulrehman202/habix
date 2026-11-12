import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/entity/UserAuth.dart';
import 'package:habix/domain/repositories/user_auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserAuthUsecases {
  final UserAuthRepository _userAuthRepositoryImp;

  UserAuthUsecases(this._userAuthRepositoryImp);
  
  Future<Result<bool>> createUser(UserAuth user)async{
    return _userAuthRepositoryImp.createUser(user);
  }
  Future<Result<String>> login(UserAuth user){
    return _userAuthRepositoryImp.login(user);
  }
}