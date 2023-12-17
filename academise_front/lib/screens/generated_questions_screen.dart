import 'dart:convert';
import 'dart:math';
import 'package:academise_front/screens/add_course/add_course_content.dart';
import 'package:http/http.dart' as http;
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:flutter/material.dart';

class Question {
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correct_option;

  Question({
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correct_option,
  });
}

class GeneratedQuestions extends StatefulWidget {
  String jsonFile;
  String course_id;
  String quiz_topic;
  String quiz_time;
  GeneratedQuestions({super.key, required this.jsonFile, required this.course_id, required this.quiz_topic, required this.quiz_time});

  @override
  State<GeneratedQuestions> createState() => _GeneratedQuestionsState();
}

class _GeneratedQuestionsState extends State<GeneratedQuestions> {
  List<Question> questions = [];
  void initState() {
    super.initState();
    final responseJson = jsonDecode(widget.jsonFile);
    for (var i = 0; i < responseJson.length; i++) {
      questions.add(
        Question(
          question: responseJson[i]['question'],
          optionA: responseJson[i]['optionA'],
          optionB: responseJson[i]['optionB'],
          optionC: responseJson[i]['optionC'],
          optionD: responseJson[i]['optionD'],
          correct_option: responseJson[i]['correct_option'],
        ),
      );
    }
  }
  _insertQuestionRecord(String quiz_id) async{
    try{
      String uri = insert_question_Url;
      for(var i=0; i<questions.length; i++){
        var res = await http.post(Uri.parse(uri), body: {
          "question": questions[i].question,
          "optionA": questions[i].optionA,
          "optionB": questions[i].optionB,
          "optionC": questions[i].optionC,
          "optionD": questions[i].optionD,
          "correct_option": questions[i].correct_option,
          "quiz_id": quiz_id,
        });
        var response = json.decode(res.body);
        if(response["success"] == "true"){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Quiz added Successfully'),
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
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${response["message"]}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
    catch(e){
      print(e);
    }
  }
  _insertQuizRecord()async{
    try{
      String uri = insert_quiz_Url;
      var res = await http.post(Uri.parse(uri), body: {
        "quiz_topic": widget.quiz_topic,
        "quiz_time": widget.quiz_time,
        "course_id": widget.course_id,
      });
      var response = json.decode(res.body);
      if(response["success"] == "true"){
        _insertQuestionRecord(response["quiz_id"].toString());
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response["message"]}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions List'),
      ),
      body: Column(
        children: [
          Container(
            height: 600,
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: secondMobileBackgroundColor),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        questions[index].question,
                        style: TextStyle(fontSize: 18, color: primaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'A. ${questions[index].optionA}',
                        style: TextStyle(fontSize: 15, color: secondaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'B. ${questions[index].optionB}',
                        style: TextStyle(fontSize: 15, color: secondaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'C. ${questions[index].optionC}',
                        style: TextStyle(fontSize: 15, color: secondaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'D. ${questions[index].optionD}',
                        style: TextStyle(fontSize: 15, color: secondaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Correct Option: ${questions[index].correct_option}',
                        style: TextStyle(fontSize: 15, color: secondaryColor),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              _insertQuizRecord();
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
                'Go Back',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
