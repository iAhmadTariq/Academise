import 'package:academise_front/models/video.dart';
import 'package:academise_front/screens/add_course/add_video_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:academise_front/widgets/course_content_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddCourseContent extends StatefulWidget {
  String course_id;
  AddCourseContent({super.key, required this.course_id});

  @override
  State<AddCourseContent> createState() => _AddCourseContentState();
}

class _AddCourseContentState extends State<AddCourseContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course Content'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          children: [
            CourseContentWidget(course_id: widget.course_id),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddVideoScreen(course_id: widget.course_id),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: purpleColor, // Change the color as needed
                  ),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Content",
                        style: TextStyle(
                          fontSize: 20,
                          color: purpleColor, // Change the color as needed
                        ),
                      ),
                      Icon(Icons.add, color: purpleColor, size: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
