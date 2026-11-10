import 'package:habix/data/model/user_profile_model.dart';
import 'package:habix/domain/entity/UserProfile.dart';

extension userProfileMapper on UserProfile{

   UserProfileModel get toModel{
    return UserProfileModel(
      email,
      name,
      dateOfBirth,
      weight,
      height,
      gender
    );
  }
}

extension userProfile on UserProfileModel{

   UserProfile get toEntity{
    return UserProfile(
      email,
      name,
      dateOfBirth,
      weight,
      height,
      gender
    );
  }
}