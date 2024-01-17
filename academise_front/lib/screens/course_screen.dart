import 'dart:convert';

import 'package:academise_front/screens/play_video_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:academise_front/widgets/course_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseScreen extends StatefulWidget {
  Map<String, dynamic> courseData;
  String image_path;
  String user_id;
  CourseScreen(
      {super.key,
      required this.courseData,
      required this.image_path,
      required this.user_id});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool isenrolled = false;

  Future<String> isEnrolled() async {
    try {
      String uri = is_enrolled_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "course_id": widget.courseData["course_id"],
        "student_id": widget.user_id,
      });
      var response = json.decode(res.body);
      if (response["success"] == "true") {
        return response["is_enrolled"];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response["message"]}'),
            backgroundColor: Color.fromARGB(255, 21, 100, 94),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return "false";
  }

  Future<void> enroll() async {
    try {
      String uri = enroll_course_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "course_id": widget.courseData["course_id"],
        "student_id": widget.user_id,
      });
      var response = json.decode(res.body);
      if (response["success"] == "true") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Enrolled Successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          isenrolled = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response["message"]}'),
            backgroundColor: Color.fromARGB(255, 21, 100, 94),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void initState() {
    super.initState();
    isEnrolled().then((value) {
      if (value == "1") {
        setState(() {
          isenrolled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
      ),
      bottomSheet: !isenrolled
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              width: double.infinity,
              height: 70,
              color: mobileBackgroundColor,
              child: InkWell(
                onTap: () => enroll(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enroll Now",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Image(
                  image: NetworkImage(
                    "$Url${widget.image_path}",
                  ),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.courseData["course_name"],
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Description",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.courseData["description"],
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Course Content",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CourseContentWidget(
                course_id: widget.courseData["course_id"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
