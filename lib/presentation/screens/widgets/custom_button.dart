import 'package:flutter/material.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onButtonTapped;
  String buttonText;
  bool isLoading;
  double buttonWidth;

  CustomButton({super.key, required this.onButtonTapped,required this.buttonText, required this.isLoading, this.buttonWidth = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 700),
        child: isLoading?_progressLoader(): SizedBox(
          width: buttonWidth,
          child: FilledButton
              (
          onPressed: onButtonTapped,
          child: Text(buttonText),
              ),
        )),
    );
  }
}

Widget _progressLoader()
{
  return FlutterAnimatedLoader.pulseTrack(color: Colors.black, size: 50);
;
}