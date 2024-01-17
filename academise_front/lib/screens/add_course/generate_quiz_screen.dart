import 'dart:convert';
import 'package:academise_front/screens/generated_questions_screen.dart';
import 'package:http/http.dart' as http;
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class GenerateQuizScreen extends StatefulWidget {
  String course_id;
  GenerateQuizScreen({super.key, required this.course_id});

  @override
  State<GenerateQuizScreen> createState() => _GenerateQuizScreenState();
}

class _GenerateQuizScreenState extends State<GenerateQuizScreen> {
  TextEditingController _topicController = TextEditingController();
  TextEditingController _difficultyController = TextEditingController();
  TextEditingController _courseTitleController = TextEditingController();
  TextEditingController _quizTimeController = TextEditingController();

  bool isLoading = false;
  Future<void> _generateQuiz() async {
  try {
    final topic = _topicController.text;
    final difficulty = _difficultyController.text;
    final courseTitle = _courseTitleController.text;
    final prompt =
        "you will now act as quiz generator for me. I will give you title of course and topic of course from which you will generate random questions. i will also tell you difficulty level from 1-10. you will give me response in json format. first key will be question and then there will be four keys with respect to four options. and sixth key will be correct option key. Separate each question with a comma. give me an answer in this format List<Map<String,String>>Generate only 3 questions. Not less or more than 3 questions.you will only answer me in json files, dont write any extra text. just answer me with the List of json formatted questions with their answers.\n course title: $courseTitle \n topic: $topic \n difficulty: $difficulty Give me response in this format [{\"question\":\"what is your name?\",\"optionA\":\"a\",\"optionB\":\"b\",\"optionC\":\"c\",\"optionD\":\"d\",\"correct_option\":\"a\"},{\"question\":\"what is your name?\",\"optionA\":\"a\",\"optionB\":\"b\",\"optionC\":\"c\",\"optionD\":\"d\",\"correct_option\":\"a\"},{\"question\":\"what is your name?\",\"optionA\":\"a\",\"optionB\":\"b\",\"optionC\":\"c\",\"optionD\":\"d\",\"correct_option\":\"a\"}]}]";
    setState(() {
      isLoading = true;
    });
    final response = await fetchResponse(prompt);
    final responseJson = jsonDecode(response);
    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeneratedQuestions(
          jsonFile: responseJson['response'],
          course_id: widget.course_id,
          quiz_topic: topic,
          quiz_time: _quizTimeController.text,
        ),
      ),
    );
    // Process the responseJson as needed
    print(responseJson['response'].runtimeType);
  } catch (e) {
    // Handle exceptions here
    print('Error: $e');
    // You can show an error message or take appropriate actions based on the error
  }
}

Future<String> fetchResponse(String prompt) async {
  try {
    final response = await http.post(
      Uri.parse('http://address_generated_by_ip_here'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get response');
    }
  } catch (e) {
    throw Exception('Network error: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Generate Quiz'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: isLoading?
          Center(child: CircularProgressIndicator(),):
          SingleChildScrollView(
            child: Column(
              children: [
                TextFieldInput(
                  hintText: 'Enter Course Title',
                  textEditingController: _courseTitleController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter Topic',
                  textEditingController: _topicController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter Difficulty Level(1-10)',
                  textEditingController: _difficultyController,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter Quiz Time (min)',
                  textEditingController: _quizTimeController,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                onTap: () {
                  _generateQuiz();
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    color: purpleColor,
                  ),
                  child: Text(
                    'Generate Quiz',
                  ),
                ),
              ),
              ],
            ),
          ),
        ));
  }
}
