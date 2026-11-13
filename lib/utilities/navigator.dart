 
 import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget page) => Navigator.push(
  context,
  PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0), // from right
          end: Offset.zero,
        ).animate(curved),
        child: child,
      );
    },
  ),
);