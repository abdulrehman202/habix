import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double value; // Value between 0.0 and 1.0
  final Duration duration;

  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, animatedValue, child) {
        return Container(
          height: 12.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: FractionalTranslation(
            translation: Offset.zero,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: animatedValue,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.lightGreenAccent, Colors.green],
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}