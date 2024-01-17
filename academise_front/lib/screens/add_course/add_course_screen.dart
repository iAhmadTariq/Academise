import 'dart:convert';
import 'dart:io';
import 'package:academise_front/screens/add_course/add_course_content.dart';
import 'package:academise_front/userPreference/current_user.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Category {
  final String categoryName;

  Category({required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(categoryName: json['category_name']);
  }
}

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  TextEditingController _courseTitleController = TextEditingController();
  TextEditingController _courseDescriptionController = TextEditingController();
  TextEditingController _coursePriceController = TextEditingController();
  String selectedCategory = 'Select a Category'; // Default text for the button
  List<Category> categories = [];
  late CurrentUser _currentUser;
  File? _image;
  String? imageData;
  String? imageName;
  String? image_id;
  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }
  Future<void> uploadImage() async{
    try {
      var uri = upload_image_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "image_name": imageName,
        "image_data": imageData
      });
      var response = json.decode(res.body);
      if (response["success"] == "true") {
        image_id = response["image_id"].toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image Uploaded Successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response["message"]}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
      imageName = imageTemporary.path.split('/').last;
      imageData = base64Encode(imageTemporary.readAsBytesSync());
      uploadImage();
    });

  }

  Future<void> _insertRecord() async {
    try {
      String uri = insert_course_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "course_name": _courseTitleController.text,
        "course_description": _courseDescriptionController.text,
        "course_price": _coursePriceController.text,
        "course_category": selectedCategory,
        "teacher_id": _currentUser.user.uid,
        "image_id": image_id.toString(), 
      });
      var response = json.decode(res.body);
      var course_id = response["course_id"].toString();
      if (response["success"] == "true") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Course Created Successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCourseContent(course_id: course_id)),
          );
        });
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response["message"]}'),
            backgroundColor: Colors.red,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getImage();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 200,
                  width: double.infinity,
                  decoration: _image==null?BoxDecoration(
                    border: Border.all(
                      color: secondaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ):null,
                  child: _image==null?const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        size: 50,
                        color: secondaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Add Course Thumbnail',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ):
                  Image.file(_image!,fit: BoxFit.cover,),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Course Title here',
                textEditingController: _courseTitleController,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  color: secondMobileBackgroundColor,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    cursorColor: purpleColor,
                    controller: _courseDescriptionController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: 'Course Description here',
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Course Price here',
                textEditingController: _coursePriceController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => _showCategorySelectionDialog(context),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    color: secondMobileBackgroundColor,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      selectedCategory,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (_courseTitleController.text.isEmpty ||
                          _courseDescriptionController.text.isEmpty ||
                          _coursePriceController.text.isEmpty ||
                          selectedCategory == 'Select a Category') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all the fields'),
                          ),
                        );
                        return;
                      }
                      _insertRecord();
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        color: purpleColor,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Next',
                            ),
                          ),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCategorySelectionDialog(BuildContext context) async {
    final selectedCategoryName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select a Category'),
          children: categories
              .map(
                (category) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, category.categoryName);
                  },
                  child: Text(category.categoryName),
                ),
              )
              .toList(),
        );
      },
    );

    // Update the selected category when a category is selected
    if (selectedCategoryName != null) {
      setState(() {
        this.selectedCategory = selectedCategoryName;
      });
    }
  }
  
  Future<void> fetchDataFromApi() async {
     _currentUser = Get.put(CurrentUser());
    // Simulate fetching data from API
    await Future.delayed(Duration(seconds: 2));
    const jsonString =
      '[{"category_name":"Mathematics"},{"category_name":"Science (Physics, Chemistry, Biology)"},{"category_name":"History"},{"category_name":"Geography"},{"category_name":"Literature"},{"category_name":"Languages (English, Spanish, French, etc.)"},{"category_name":"Social Studies"},{"category_name":"Business and Finance"},{"category_name":"Marketing"},{"category_name":"Project Management"},{"category_name":"Leadership and Management"},{"category_name":"Communication Skills"},{"category_name":"Time Management"},{"category_name":"Web Development"},{"category_name":"Mobile App Development"},{"category_name":"Data Science"},{"category_name":"Artificial Intelligence"},{"category_name":"Programming Languages (Python, Java, etc.)"},{"category_name":"Cybersecurity"},{"category_name":"Graphic Design"},{"category_name":"Photography"},{"category_name":"Music"},{"category_name":"Writing and Creative Writing"},{"category_name":"Film and Video Production"},{"category_name":"Performing Arts"},{"category_name":"Fitness and Exercise"},{"category_name":"Nutrition"},{"category_name":"Mental Health"},{"category_name":"Yoga and Meditation"},{"category_name":"Personal Development"},{"category_name":"Robotics"},{"category_name":"Engineering"},{"category_name":"Computer Science"},{"category_name":"Physics"},{"category_name":"Chemistry"},{"category_name":"Beginner to Advanced Language Courses"},{"category_name":"Conversational Language Courses"},{"category_name":"Language for Travel"},{"category_name":"SAT\/ACT Preparation"},{"category_name":"GRE\/GMAT Preparation"},{"category_name":"Professional Certifications (e.g., CPA, PMP)"},{"category_name":"Cooking and Culinary Arts"},{"category_name":"Gardening"},{"category_name":"DIY and Crafts"},{"category_name":"Travel Planning"},{"category_name":"Photography"},{"category_name":"Industry-specific courses (e.g., IT certifications"},{"category_name":"Job-specific skills training"}]'; // Replace with your actual JSON data
    final List<dynamic> data = json.decode(jsonString);
    setState(() {
      categories = data.map((json) => Category.fromJson(json)).toList();
    });
  }
}
