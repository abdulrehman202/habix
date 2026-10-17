import 'package:habix/data/model/user_auth_model.dart';
import 'package:habix/domain/models/UserAuth.dart';

toUserAuthModel(UserAuth userAuth)=>UserAuthModel(email: userAuth.email, password: userAuth.password);