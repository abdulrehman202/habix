import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/models/UserAuth.dart';
import 'package:habix/domain/usecase/user_auth_usecases.dart';
import 'package:state_notifier/state_notifier.dart';

enum Gender{
  MALE,
  FEMALE
}

enum WeightUnit{
  KG,
  LBS
}

enum HeightUnit{ 
  INCH,
  CM
}

class UserProfileNotifier extends StateNotifier<Map<String, dynamic>>{

  UserProfileNotifier():super({
    'loading':false,
    'error_message':'',
    'gender': Gender.MALE,
    'unit_height': HeightUnit.CM,
    'unit_weight': WeightUnit.KG,
    });

    change(String key, value)
    {
      state = {
        ...state,
        key:value,
      };
    }

    changeHeightUnit(HeightUnit unit)
    {
      change('unit_height', unit);
    }

    changeWeightUnit(WeightUnit unit)
    {
      change('unit_weight', unit);
    }

    changeGender(Gender gender)
    {
      change('gender', gender); 
    }
}
    final userProfileScreenNotifier = StateNotifierProvider<UserProfileNotifier, Map<String, dynamic>>((ref){

return UserProfileNotifier();

});