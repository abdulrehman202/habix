import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/usecase/user_profile_usecases.dart';
import 'package:habix/presentation/Mappers/user_profile_mapper.dart';
import 'package:habix/presentation/UIModels/userProfileUI.dart';
import 'package:habix/utilities/enums.dart';


class UserProfileNotifier extends StateNotifier<Map<String, dynamic>>{
  final UserProfileUsecases _userProfileUsecase = UserProfileUsecases();

  UserProfileNotifier():super({
    'loading':false,
    'error_message':'',
    'gender': Gender.MALE,
    'unit_height': HeightUnit.INCH,
    'unit_weight': WeightUnit.KG,
    'dob': DateTime.now(),
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

    changeDOB(DateTime dob)
    {
      change('dob', dob);
    }

    Future<bool> setProfile(UserProfileUIModel userUI) async
    {
      state = {...state,'loading':true};
      Result result = await _userProfileUsecase.setProfile( userUI.toEntity);
      state = {...state,'loading':false};

      if(result is Error)
      {
        state = {...state,'error_message':result.failure.message};
      }

      return result is Ok;
    
    }
}
    final userProfileScreenNotifier = StateNotifierProvider<UserProfileNotifier, Map<String, dynamic>>((ref){

return UserProfileNotifier();

});