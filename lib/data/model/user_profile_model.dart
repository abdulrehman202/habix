import 'package:habix/utilities/enums.dart';

final Map<String, Gender> genderMap = {
  'MALE': Gender.MALE,
  'FEMALE': Gender.FEMALE,
};

class UserProfileModel{
  String name;
  DateTime dateOfBirth;
  int weight;
  int height;
  Gender gender;


  UserProfileModel( this.name, this.dateOfBirth, this.weight, this.height,this.gender);

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      json["name"],
      DateTime.parse(json["dateOfBirth"]),
      json["weight"],
      json["height"],
      genderMap[json["gender"]] as Gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "weight": weight,
      "height": height,
      "gender": gender.name,
    };
  }
}
