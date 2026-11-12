import 'package:habix/utilities/enums.dart';

class UserProfileUIModel {
  String  firstName;
  String lastName;
  DateTime dob;
  Gender gender;
  int? age;
  int weight;
  int height;

  UserProfileUIModel(
    this.firstName,
    this.lastName,
    this.dob,
    this.gender,
    this.weight,
    this.height,
    {this.age}
  );
}