import 'package:material_ui/material_ui.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationWidget extends StatefulWidget {
  String path,text;
  
  LottieAnimationWidget({super.key,required this.path,required this.text});

  @override
  State<LottieAnimationWidget> createState() => _LottieAnimationWidgetState();
}

class _LottieAnimationWidgetState extends State<LottieAnimationWidget> with TickerProviderStateMixin{
  late final AnimationController _animationController; 
  
  @override
  void initState() {
    super.initState();
    _animationController  = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
  _animationController.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return AnimatedScale(scale: _animationController.value, duration: Duration(milliseconds: 300),
        child: child,);
        
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150, child: Lottie.asset('assets/animations/${widget.path}.json')),
            SizedBox(
              height: 50,
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
          ),
    );
  }
}

class LottieAnimation {
  static writing() {
    return LottieAnimationWidget( path: 'writing',text:  'Updating Routine');
  }

  static erasing() {
    return LottieAnimationWidget( path: 'erasing', text: 'Removing Habit');
  }

  static serverError() {
    return LottieAnimationWidget( path: 'error', text:  'Server Error');
  }
}
