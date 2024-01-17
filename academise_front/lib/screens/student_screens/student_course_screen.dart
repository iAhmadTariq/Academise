import 'package:flutter/material.dart';

class StudentCourseScreen extends StatefulWidget {
  const StudentCourseScreen ({super.key});

  @override
  State<StudentCourseScreen> createState() => _StudentCourseScreenState();
}

class _StudentCourseScreenState extends State<StudentCourseScreen > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Student Course"),
      ),
    );
  }
}