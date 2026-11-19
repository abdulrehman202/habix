import 'dart:async';

import 'package:flutter/material.dart';

class EmptyListWidget extends StatefulWidget {
  const EmptyListWidget({super.key});

  @override
  State<EmptyListWidget> createState() => _EmptyListWidgetState();
}

class _EmptyListWidgetState extends State<EmptyListWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
     _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) { 
    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.asset( 
                        'assets/images/habbit_tracker.jpg',
                        errorBuilder: (context, error, stackTrace) => Container(),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'No habit found',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
      builder: (context,child) {
        return AnimatedScale( 
          scale: _controller.value, 
          duration: Duration(milliseconds: 500),
          child: child,
        );
      }
    );
  }
}