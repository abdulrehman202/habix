import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/Mappers/user_auth_mapper.dart';
import 'package:habix/data/datasource/userAuth/remote_datasource.dart';
import 'package:habix/data/model/user_auth_model.dart';
import 'package:habix/domain/entity/UserAuth.dart';
import 'package:habix/domain/repositories/user_auth_repository.dart';
import 'package:habix/utilities/storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserAuthRepository)
class UserAuthRepositoryImp implements UserAuthRepository{
  
  final UserAuthRemoteDataSource _userAuthRemoteDataSource;
  UserAuthRepositoryImp(this._userAuthRemoteDataSource);
  
  @override
  Future<Result<bool>> createUser(UserAuth user) async {
    try{
      UserAuthModel userAuthModel = toUserAuthModel(user);
      bool userCreated = await _userAuthRemoteDataSource.signUp(userAuthModel);
      return Result.ok(userCreated);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  
  @override
  Future<Result<String>> login(UserAuth user) async {
    try{
      UserAuthModel userAuthModel = toUserAuthModel(user);
      String token = await _userAuthRemoteDataSource.login(userAuthModel);
      await addDataToLocalStorage('token', token);
      await addDataToLocalStorage('email', user.email);
      return Result.ok(token);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<bool>> logOut() async {
     try{
      bool success = await _userAuthRemoteDataSource.logOut();
      await addDataToLocalStorage('token', '');
      await addDataToLocalStorage('email', '');
      return Result.ok(success);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }
}