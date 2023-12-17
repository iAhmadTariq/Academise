import 'dart:convert';

import 'package:academise_front/screens/add_course/add_course_screen.dart';
import 'package:academise_front/userPreference/current_user.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CurrentUser _currentUser  = Get.put(CurrentUser());

  Future<List<dynamic>> fetchCourses() async {
    // Function implementation here
    try {
      String uri = fetch_courses_Url;
      var res = await http.post(Uri.parse(uri), body: {
      "teacher_id": _currentUser.user.uid,
      });
      var response = json.decode(res.body);
      if (response["success"] == true) {
        return response["course"];
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
        backgroundColor: Colors.transparent,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/App_Logo.svg',
                height: 35,
                color: purpleColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Academise',
                style: GoogleFonts.montserrat(
                  color: primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    'Welcome '+_currentUser.user.firstName+'!',
                    style: GoogleFonts.roboto(
                      color: primaryColor,
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Courses',
                    style: GoogleFonts.roboto(
                      color: secondaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<dynamic>>(
                future: fetchCourses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // No existing content, show the "Add Content" button
                    return Text('No courses yet! Add a new course to get started.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ));
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
                                          Icons.layers_sharp,
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
                                            content["course_name"].toString().length > 20
                                                ? content["course_name"]
                                                        .toString()
                                                        .substring(0, 20) +
                                                    "..."
                                                : content["course_name"],
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            content["description"].toString().length > 25
                                                ? content["description"]
                                                        .toString()
                                                        .substring(0, 25) +
                                                    "..."
                                                : content["description"],
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
              SizedBox(
                height: 20,
              
              ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCourseScreen()),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: purpleColor,
                      ),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add a New Course",
                            style: TextStyle(
                              fontSize: 20,
                              color: purpleColor,
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
        ),
      ),
    );
  }
}
