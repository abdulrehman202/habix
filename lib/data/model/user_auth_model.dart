class UserAuthModel {
  String email;
  String password;

  UserAuthModel({required this.email, required this.password});

  Map<String, dynamic> toJson(){
    return
  {
    'email': this.email,
    'password':this.password,
  };}
}