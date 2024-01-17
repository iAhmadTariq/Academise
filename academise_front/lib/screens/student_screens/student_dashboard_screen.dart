import 'dart:convert';

import 'package:academise_front/screens/course_screen.dart';
import 'package:academise_front/userPreference/current_user.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:academise_front/widgets/course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<StudentDashboardScreen> {
  CurrentUser _currentUser = Get.put(CurrentUser());
  String image_id = "";

  Future<String> fetchImagePath() async {
    try {
      String uri = fetch_image_path_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "image_id": image_id,
      });
      var response = json.decode(res.body);
      if (response["success"] == "true") {
        return response["image_path"];
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
    return "";
  }

  Future<List<dynamic>> fetchCourses() async {
    // Function implementation here
    try {
      String uri = fetch_courses_Url;
      var res = await http.post(Uri.parse(uri));
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
                    vertical: 15,
                  ),
                  child: Text(
                    'Hey, ' + _currentUser.user.firstName + '!',
                    style: GoogleFonts.roboto(
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'Nice to see you again!',
                  style: GoogleFonts.roboto(
                    color: primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: purpleColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    hintText: 'Search anything',
                    hintStyle: GoogleFonts.roboto(
                      color: secondaryColor,
                      fontSize: 18,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: secondaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: thirdColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: thirdColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: thirdColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [purpleColor, Color.fromRGBO(122, 96, 219, 1)],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Recommended Courses',
                  style: GoogleFonts.roboto(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
                        return Text(
                          'There are no courses yet. Please check back later.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        );
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            var course = snapshot.data![index];
                            image_id = course["image_id"];
                            return FutureBuilder<String>(
                                future:
                                    fetchImagePath(), // your function that returns Future<String>
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> imagePathSnapshot) {
                                  if (imagePathSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // show loading spinner while waiting for data
                                  } else if (imagePathSnapshot.hasError) {
                                    return Text(
                                        'Error: ${imagePathSnapshot.error}'); // show error message if there's an error
                                  } else {
                                    return Container(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseScreen(
                                                courseData: course,
                                                image_path: imagePathSnapshot.data!.toString(),
                                                user_id: _currentUser.user.uid,
                                              ),
                                            ),
                                          );
                                        },
                                        child: CourseWidget(
                                          courseTitle: course["course_name"],
                                          courseDescription:
                                              course["description"],
                                          coursePrice: course["course_price"],
                                          image_path: imagePathSnapshot
                                              .data!, // use the fetched image path here
                                        ),
                                      ),
                                    );
                                  }
                                });
                          }),
                          shrinkWrap: true,
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
