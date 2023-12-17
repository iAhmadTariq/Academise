import 'package:academise_front/models/video.dart';
import 'package:academise_front/screens/add_course/add_video_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
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

  Future<List<dynamic>> fetchQuizes() async {
    // Function implementation here
    try {
      String uri = fetch_quizes_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "course_id": widget.course_id,
      });

      var response = json.decode(res.body);
      if (response["success"] == true) {
        return response["quizes"];
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
    return [];
  }
  Future<List<dynamic>> fetchCourseContent() async {
    // Function implementation here
    try {
      String uri = fetch_course_content_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "course_id": widget.course_id,
      });
      var response = json.decode(res.body);
      if (response["success"] == true) {
        return response["videos"];
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
    return [];
  }

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
            FutureBuilder<List<dynamic>>(
              future: fetchCourseContent(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // No existing content, show the "Add Content" button
                  return Container();
                } else {
                  // Display existing content and then show the "Add Content" button
                  return Column(
                    children: [
                      // Display existing content
                      for (var content in snapshot.data!)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color: secondMobileBackgroundColor,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.play_arrow_outlined,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          content["video_title"].toString().length > 25
                                              ? content["video_title"]
                                                      .toString()
                                                      .substring(0, 25) +
                                                  "..."
                                              : content["video_title"],
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          content["video_description"].toString().length > 25
                                              ? content["video_description"]
                                                      .toString()
                                                      .substring(0, 25) +
                                                  "..."
                                              : content["video_description"],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      // "Add Content" button
                      
                    ],
                  );
                }
              },
            ),
            FutureBuilder<List<dynamic>>(
              future: fetchQuizes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // No existing content, show the "Add Content" button
                  return Container();
                } else {
                  // Display existing content and then show the "Add Content" button
                  return Column(
                    children: [
                      // Display existing content
                      for (var content in snapshot.data!)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color: secondMobileBackgroundColor,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.question_mark,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            content["quiz_topic"].toString().length > 25
                                                ? content["quiz_topic"]
                                                        .toString()
                                                        .substring(0, 25) +
                                                    "..."
                                                : content["quiz_topic"],
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        content["quiz_time"].toString()+' min',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      // "Add Content" button
                      
                    ],
                  );
                }
              },
            ),
            InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddVideoScreen(course_id: widget.course_id),
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
