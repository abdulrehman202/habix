import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/domain/models/UserAuth.dart';
import 'package:habix/presentation/providers/create_account_screen.dart';
import 'package:habix/presentation/screens/login_screen.dart';
import 'package:habix/presentation/screens/widgets/password_text_box.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final _passwordController = TextEditingController();
final _emailController = TextEditingController();
final _confirmPasswordController = TextEditingController();
late Map<String, dynamic> _params;

  @override
  Widget build(BuildContext context) {
    _params = ref.watch(signupScreenNotifier);
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
                    controller: _emailController,
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
                      onPressed: _params['loading']?null: () 
                      async {
                        UserAuth userAuth = UserAuth(email: _emailController.text, password: _passwordController.text);
                        bool success = await ref.read(signupScreenNotifier.notifier).Signup(userAuth);
                        if(success)
                        {
                          _moveToLoginScreen();
                        }
                        else{
                          await Future.delayed(Duration(milliseconds: 300));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_params['error_message'])));
                        }
                      },
                      child: _params['loading']?CircularProgressIndicator(): Text('Create my Account'),
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
