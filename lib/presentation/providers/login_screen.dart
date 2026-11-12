import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/entity/UserAuth.dart';
import 'package:habix/domain/usecase/user_auth_usecases.dart';
import 'package:habix/injection.dart';

class LoginScreenNotifier extends StateNotifier<Map<String, dynamic>>{
  final UserAuthUsecases _userAuthUsecase;

  LoginScreenNotifier(this._userAuthUsecase):super({
    'loading':false,
    'error_message':'',
    });
    
    Future<bool> login(UserAuth user) async
    {
      state = {...state,'loading':true};
      Result result = await _userAuthUsecase.login(user);
      state = {...state,'loading':false};

      if(result is Error)
      {
        state = {...state,'error_message':result.failure.message};
      }

      return result is Ok;
    }

    }

    final loginScreenNotifier = StateNotifierProvider<LoginScreenNotifier, Map<String, dynamic>>((ref){

return LoginScreenNotifier(getIt<UserAuthUsecases>() );

});