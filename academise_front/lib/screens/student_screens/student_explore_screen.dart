import 'package:academise_front/screens/student_screens/courses_by_category_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentExploreScreen extends StatefulWidget {
  const StudentExploreScreen({super.key});

  @override
  State<StudentExploreScreen> createState() => _StudentExploreScreenState();
}

class _StudentExploreScreenState extends State<StudentExploreScreen> {
  List<Color> babyColors = [
    Colors.pink[500]!,
    const Color.fromARGB(255, 1, 67, 121),
    Colors.green[500]!,
    Colors.orange[500]!,
    Colors.purple[500]!,
    const Color.fromARGB(255, 237, 215, 17),
    Colors.teal[500]!,
    Colors.red[500]!,
    Colors.indigo[500]!,
    Colors.brown[500]!,
    Colors.pink[500]!,
    const Color.fromARGB(255, 0, 70, 127),
    Colors.green[500]!,
    Colors.orange[500]!,
    Colors.purple[500]!,
  ];
  List<Map<String, String>> Categgories = [
    {"category_name": "Computer Science"},
    {"category_name": "Mathematics"},
    {"category_name": "Science (Physics, Chemistry, Biology)"},
    {"category_name": "History"},
    {"category_name": "Geography"},
    {"category_name": "Literature"},
    {"category_name": "Languages (English, Spanish, French, etc.)"},
    {"category_name": "Social Studies"},
    {"category_name": "Business and Finance"},
    {"category_name": "Marketing"},
    {"category_name": "Project Management"},
    {"category_name": "Communication Skills"},
    {"category_name": "Time Management"},
    {"category_name": "Web Development"},
    {"category_name": "Others"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: GoogleFonts.roboto(
                      color: primaryColor,
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.7,
                  ),
                  itemCount: 15,
                  itemBuilder: ((context, index) => InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CoursesByCategoryScreen()));
                    },
                    child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: babyColors[index],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "${Categgories[index]["category_name"]}"
                                              .length >
                                          20
                                      ? "${Categgories[index]["category_name"]}"
                                              .substring(0, 20) +
                                          "..."
                                      : "${Categgories[index]["category_name"]}",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
