import 'package:academise_front/screens/home_screen.dart';
import 'package:academise_front/screens/login_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      title: "Academise",
      home: HomeScreen(),
    );
  }
}
