import 'package:flutter/material.dart';
import 'package:habix/presentation/screens/login_screen.dart';
import 'package:habix/presentation/screens/tabs.dart';
import 'package:habix/presentation/screens/widgets/animated_progress_bar.dart';
import 'package:habix/utilities/image_paths.dart';
import 'package:habix/utilities/storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this,
    duration: Duration(seconds: 3)
    );
    _startAnimation();
  }

  _startAnimation() async
  {
    String token = '';
    _animationController.addListener(()async{
      token = await getDataFromLocalStorage('token');
    });

    await _animationController.forward().whenComplete(()async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> token.trim().isEmpty? LoginScreen():TabScreen()));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context,child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _calenderImage(),
              Text('Habix',style: TextStyle(fontSize: 40),),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.widthOf(context) * 0.8,
                child: AnimatedProgressBar(value: _animationController.value))
          
            ],
          );
        }
      ),
    );
  }

  _calenderImage()
  {
    return Center(
                child: Image.asset(
                  calendarImagePath,
                  fit: BoxFit.fitHeight,
                  width: MediaQuery.widthOf(context),
                  height: 300,
                  errorBuilder: (context, error, stackTrace) => Container(),
                ),
              );
  }
}