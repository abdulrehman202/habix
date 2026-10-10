import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerAnimation{
  
  

  static listPlaceholder()
  { Widget shimmer = Shimmer(
    duration: Duration(seconds: 2), //Default value
    // interval: Duration(seconds: 1), //Default value: Duration(seconds: 0)
    color: Colors.grey, //Default value
    colorOpacity: 0.5, //Default value
    enabled: true, //Default value
    direction: ShimmerDirection.fromLBRT(),  //Default Value
    child: Container(
      height: 75,
      decoration: BoxDecoration(
      color: const Color.fromARGB(179, 240, 234, 234),
      borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
      );
    return ListView(
      children: [
        SizedBox(height: 10,),
        shimmer,
        SizedBox(height: 10,),
        shimmer,
        SizedBox(height: 10,),
        shimmer,
        SizedBox(height: 10,),
        shimmer,
        SizedBox(height: 10,),
        shimmer,
        SizedBox(height: 10,),
        shimmer,
      ],
    );
  }
}