import 'package:flutter/material.dart';

class CoursesByCategoryScreen extends StatefulWidget {
  const CoursesByCategoryScreen({super.key});

  @override
  State<CoursesByCategoryScreen> createState() => _CoursesByCategoryScreenState();
}

class _CoursesByCategoryScreenState extends State<CoursesByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Courses By Category'),
      ),
      body: Center(
        child: Text('No courses in this category yet'),
      ),
    );
  }
}