import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation{

  static writing()
  {
    return Center(
      child: Column(
        children: [
          Expanded(child: Lottie.asset('assets/animations/writing.json')),
          Expanded(child: Text('Updating Routine'))
        ],
      ),
    );
  }

  static erasing()
  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                    SizedBox(
                      height: 150,
                      child: Lottie.asset('assets/animations/erasing.json')),
          SizedBox(
            height: 50,
            child: Text('Removing Habit',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }

  static serverError()
  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Lottie.asset('assets/animations/error.json')),
          SizedBox(
            height: 100,
            child: Text('Server Error')),
        ],
      ),
    );
  }


}