import 'package:habix/domain/entity/UserProfile.dart';
import 'package:habix/presentation/UIModels/userProfileUI.dart';

extension userProfileMapper on UserProfileUIModel{

   UserProfile get toEntity{
    return UserProfile(
      '$firstName $lastName',
      dob,
      weight,
      height,
      gender
    );
  }
}

extension userProfile on UserProfile{

   UserProfileUIModel get toUIModel{
    int age = DateTime.now().year - dateOfBirth.year;
    if(dateOfBirth.isAfter( DateTime.now().subtract(Duration(days: age * 365)))) {
      age--;
    }
    return UserProfileUIModel(
      name.split(' ').first,
      name.split(' ').last,
      dateOfBirth,
      gender,
      weight,
      height,
      age: age
    );
  }
}