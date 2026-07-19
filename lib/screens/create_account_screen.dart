import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:habix/screens/login_screen.dart';
import 'package:habix/screens/widgets/password_text_box.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clipperHeight = MediaQuery.sizeOf(context).height * 0.4;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              height: clipperHeight,
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              alignment: Alignment.center,
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text('Welcome to Habix',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text('Let\'s get started',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: clipperHeight - 80,
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Create an Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  PasswordTextField(controller: _passwordController),
                  SizedBox(height: 10),
                  PasswordTextField(controller: _confirmPasswordController, hint: 'Confirm Password',),
                  SizedBox(height: 20),
              
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      child: Text('Create my Account'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _moveToLoginScreen,
                      child: Text('I already have an Account'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToLoginScreen() {
    Navigator.push(_scaffoldKey.currentContext!, MaterialPageRoute(builder: (ctx)=>LoginScreen()));
  }
}
