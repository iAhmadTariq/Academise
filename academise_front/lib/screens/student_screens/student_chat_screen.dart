import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:academise_front/utils/color.dart';

class StudentChatScreen extends StatefulWidget {
  const StudentChatScreen({super.key});

  @override
  State<StudentChatScreen> createState() => _StudentChatScreenState();
}

class _StudentChatScreenState extends State<StudentChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SvgPicture.asset(
            'assets/images/App_Logo.svg',
            height: 200,
            color: purpleColor,
          ),
        ),
      ),
    );
  }
}
