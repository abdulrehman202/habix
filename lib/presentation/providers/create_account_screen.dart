import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/models/UserAuth.dart';
import 'package:habix/domain/usecase/user_auth_usecases.dart';
import 'package:state_notifier/state_notifier.dart';

class SignupScreenNotifier extends StateNotifier<Map<String, dynamic>>{
  final UserAuthUsecases _userAuthUsecase = UserAuthUsecases();

  SignupScreenNotifier():super({
    'loading':false,
    'error_message':'',
    });
    
    Future<bool> Signup(UserAuth user) async
    {
      state = {...state,'loading':true};
      Result result = await _userAuthUsecase.createUser(user);
      state = {...state,'loading':false};

      if(result is Error)
      {
        state = {...state,'error_message':result.failure.message};
      }

      return result is Ok;
    }

    }

    final signupScreenNotifier = StateNotifierProvider<SignupScreenNotifier, Map<String, dynamic>>((ref){

return SignupScreenNotifier();

});