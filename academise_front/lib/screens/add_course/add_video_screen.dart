import 'dart:convert';

import 'package:academise_front/screens/add_course/add_course_content.dart';
import 'package:academise_front/screens/add_course/generate_quiz_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddVideoScreen extends StatefulWidget {
  String course_id;
  AddVideoScreen({super.key, required this.course_id});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  TextEditingController _videoTitleController = TextEditingController();
  TextEditingController _videoLinkController = TextEditingController();
  TextEditingController _videoDescriptionController = TextEditingController();
  TextEditingController _sequenceController = TextEditingController();

  _insertRecord() async {
    try {
      String uri = insert_video_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "video_title": _videoTitleController.text,
        "video_description": _videoDescriptionController.text,
        "course_id": widget.course_id,
        "video_link": _videoLinkController.text,
        "sequence": _sequenceController.text,
      });
      var response = json.decode(res.body);
      if (response["success"] == "true") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video added Successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddCourseContent(
                course_id: widget.course_id,
              ),
            ),
          );
        });
      } else {
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
        title: Text('Add Video/Quiz'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenerateQuizScreen(course_id: widget.course_id),
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
                      color: Colors.grey,
                    ),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Generate Quiz",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Add Video Title',
                textEditingController: _videoTitleController,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Add Video Link',
                textEditingController: _videoLinkController,
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
                    controller: _videoDescriptionController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: 'Add Video Description',
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
                hintText: 'Sequence in course',
                textEditingController: _sequenceController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (_videoTitleController.text.isEmpty ||
                          _videoLinkController.text.isEmpty ||
                          _videoDescriptionController.text.isEmpty) {
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        color: purpleColor,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Done',
                            ),
                          ),
                          const Icon(Icons.done),
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
}
