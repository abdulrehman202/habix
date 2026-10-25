import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/domain/models/UserAuth.dart';
import 'package:habix/presentation/providers/login_screen.dart';
import 'package:habix/presentation/screens/create_account_screen.dart';
import 'package:habix/presentation/screens/tabs.dart';
import 'package:habix/presentation/screens/widgets/email_text_box.dart';
import 'package:habix/presentation/screens/widgets/password_text_box.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final _passwordController = TextEditingController();
final _emailController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

late Map<String, dynamic> _params;

  @override
  Widget build(BuildContext context) {
  final clipperHeight = MediaQuery.sizeOf(context).height * 0.3;
  _params = ref.watch(loginScreenNotifier);

  _emailController.text= 'abdulrehman1411@gmail.com';
  _passwordController.text = 'abc123';
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          ClipPath(
          clipper:  WaveClipperTwo( flip:  true),
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: clipperHeight,
            width: double.infinity,
            // child: Image.asset(natureImagePath,fit: BoxFit.cover,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Habix',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
                ),
                Text('Schedule your life',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 13,
                ),
                ),
              ],
            ),
          ),
          ),
          Container(
            margin:EdgeInsets.only(top: clipperHeight - 30 , right: 10,left: 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  SizedBox(height: 20,),
                  EmailTextField(controller: _emailController, ),
                  SizedBox(height: 10,),
                  PasswordTextField(controller: _passwordController,),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: _params['loading']?null: _login, child: _params['loading']?CircularProgressIndicator():Text('Sign In'))),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                    width: double.infinity,
                    child: TextButton(onPressed: _moveToCreateAccountScreen, child: Text('Create Account')))
                ],),
              ),
            ))
        ],
      )
    );
  }

  _login()async {
    if(_formKey.currentState!.validate()){
    _formKey.currentState!.save();
    UserAuth userAuth = UserAuth(email: _emailController.text, password: _passwordController.text);
    bool success = await ref.read(loginScreenNotifier.notifier).login(userAuth);
    if(success){
    Navigator.push( _scaffoldKey.currentContext! , MaterialPageRoute(builder: (ctx)=>TabScreen()));
    }

    else{
      await Future.delayed(Duration(milliseconds: 300));
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text(_params['error_message'])));
    }
    }
    
  }

  void _moveToCreateAccountScreen() {
    Navigator.pushReplacement ( _scaffoldKey.currentContext! , MaterialPageRoute(builder: (ctx)=>CreateAccountScreen()));
  
  }
}
