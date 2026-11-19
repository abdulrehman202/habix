import 'dart:async';

import 'package:flutter/material.dart';

const defaultGradient = [Colors.lightBlue, Color.fromARGB(255, 0, 4, 244)];

class InfoBox extends StatefulWidget {
  String text;
  List<Color> gradient;

  InfoBox({super.key, required this.text, this.gradient = defaultGradient});

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
            height: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: widget.gradient),
            ),
            child: Center(
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      builder: (context, child) {
        return AnimatedScale(
          curve: Curves.easeOut,
          scale: 1*_controller.value,
          duration: Duration(milliseconds: 100),
          child: child
        );
      },
    );
  }
}
