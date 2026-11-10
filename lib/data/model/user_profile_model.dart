import 'package:habix/utilities/enums.dart';

class UserProfileModel{
  String email;
  String name;
  DateTime dateOfBirth;
  int weight;
  int height;
  Gender gender;


  UserProfileModel(this.email, this.name, this.dateOfBirth, this.weight, this.height,this.gender);
}