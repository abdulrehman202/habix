import 'package:habix/utilities/enums.dart';

class UserProfile{
  
  String email;
  String name;
  DateTime dateOfBirth;
  int weight;
  int height;
  Gender gender;


  UserProfile(this.email, this.name, this.dateOfBirth, this.weight, this.height,this.gender);

}