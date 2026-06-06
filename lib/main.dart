import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/screens/tabs.dart';

void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 95, 237, 164));
  final kdarkColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 51, 25));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // darkTheme: ThemeData.dark().copyWith(
      //   colorScheme: kdarkColorScheme,
      //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //     showUnselectedLabels: false,
      //     selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary)
      //   )
        
      // ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: false,
          selectedItemColor: kColorScheme.primary,
          unselectedItemColor: Colors.black54,
        )
      ),
      
      home: TabScreen(),
    );
  }
}