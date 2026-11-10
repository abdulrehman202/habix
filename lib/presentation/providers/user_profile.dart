import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/utilities/enums.dart';


class UserProfileNotifier extends StateNotifier<Map<String, dynamic>>{

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
}
    final userProfileScreenNotifier = StateNotifierProvider<UserProfileNotifier, Map<String, dynamic>>((ref){

return UserProfileNotifier();

});