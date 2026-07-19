import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:habix/screens/create_account_screen.dart';
import 'package:habix/screens/tabs.dart';
import 'package:habix/screens/widgets/password_text_box.dart';

class LoginScreen extends StatelessWidget {

   LoginScreen({super.key});

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  final clipperHeight = MediaQuery.sizeOf(context).height * 0.3;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hint: Text('example@abc.com'),
                    label: Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                PasswordTextField(controller: _passwordController),
                SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(onPressed: _login, child: Text('Sign In'))),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: _moveToCreateAccountScreen, child: Text('Create Account')))
              ],),
            ))
        ],
      )
    );
  }

  void _login() {
    Navigator.push( _scaffoldKey.currentContext! , MaterialPageRoute(builder: (ctx)=>TabScreen()));
  }

  void _moveToCreateAccountScreen() {
    Navigator.pushReplacement ( _scaffoldKey.currentContext! , MaterialPageRoute(builder: (ctx)=>CreateAccountScreen()));
  
  }
}
