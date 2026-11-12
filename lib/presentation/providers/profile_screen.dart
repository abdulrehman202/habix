import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/entity/UserProfile.dart';
import 'package:habix/domain/usecase/user_profile_usecases.dart';
import 'package:habix/presentation/Mappers/user_profile_mapper.dart';
import 'package:state_notifier/state_notifier.dart';

class ProfileScreenNotifier extends StateNotifier<Map<String, dynamic>> {
  final UserProfileUsecases _userProfileUsecase = UserProfileUsecases();
  ProfileScreenNotifier() : super({'error_message':'','loading': false,'profile':null}){
    fetchUserProfile();
  }

  void setLoading(bool value) {
    state = {...state, 'loading': value};
  }

  fetchUserProfile() async {
    setLoading(true);
    Result result = await _userProfileUsecase.fetchUserDetails();
      if (result is Ok) {
        UserProfile userProfile = result.value;
        state = {...state, 'profile': userProfile.toUIModel};
      } else if (result is Error) {
        state = {...state, 'error_message': result.failure.message};
      }
    setLoading(false);
  }
} 

final profileScreenNotifier = StateNotifierProvider<ProfileScreenNotifier, Map<String, dynamic>>((ref){

return ProfileScreenNotifier();

});