import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/Mappers/user_auth_mapper.dart';
import 'package:habix/data/datasource/userAuth/remote_datasource.dart';
import 'package:habix/data/model/user_auth_model.dart';
import 'package:habix/domain/models/UserAuth.dart';
import 'package:habix/domain/repositories/user_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthRepositoryImp implements UserAuthRepository{
  
  final UserAuthRemoteDataSource _userAuthRemoteDataSource = UserAuthRemoteDataSource();
  
  @override
  Future<Result<bool>> createUser(UserAuth user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  addTokenToLocalStorage(String token)async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  @override
  Future<Result<String>> login(UserAuth user) async {
    try{
      UserAuthModel userAuthModel = toUserAuthModel(user);
      String token = await _userAuthRemoteDataSource.login(userAuthModel);
      await addTokenToLocalStorage(token);
      return Result.ok(token);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }
}