import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/models/UserAuth.dart';

abstract class UserAuthRepository 
{
  Future<Result<bool>> createUser(UserAuth user);
  Future<Result<String>> login(UserAuth user);
}