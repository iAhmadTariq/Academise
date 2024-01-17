import 'package:flutter/material.dart';

class QuizAttemptScreen extends StatefulWidget {
  @override
  _QuizAttemptScreenState createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  
  List<Map<String, dynamic>> quizData = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      'correctAnswer': 'Mars',
    },
    {
      'question': 'Who wrote "Romeo and Juliet"?',
      'options': [
        'Charles Dickens',
        'William Shakespeare',
        'Jane Austen',
        'Mark Twain'
      ],
      'correctAnswer': 'William Shakespeare',
    },
  ];

  List<String?> userAnswers = List.filled(3, null);
  bool allQuestionsAnswered = false;

  void checkAnswer(int questionIndex, String selectedAnswer) {
    if (allQuestionsAnswered) {
      return;
    }

    setState(() {
      userAnswers[questionIndex] = selectedAnswer;
    });
  }

  void _showResult() {
    setState(() {
      allQuestionsAnswered = true;
    });

    int correctAnswersCount = 0;
    for (int i = 0; i < quizData.length; i++) {
      if (userAnswers[i] == quizData[i]['correctAnswer']) {
        correctAnswersCount++;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(quizData.length, (index) {
                bool isCorrect =
                    userAnswers[index] == quizData[index]['correctAnswer'];
                String correctAnswer = quizData[index]['correctAnswer'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Question ${index + 1}: ${quizData[index]['question']}'),
                    Text(
                      'Your Answer: ${isCorrect ? 'Correct' : 'Wrong'}',
                      style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red),
                    ),
                    Text('Correct Answer: $correctAnswer'),
                    SizedBox(height: 16.0),
                  ],
                );
              }),
              SizedBox(height: 16.0),
              Text(
                'Overall Result: $correctAnswersCount/${quizData.length}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: quizData.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  quizData[index]['question'],
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                ...((quizData[index]['options'] as List<String>).map((option) {
                  bool isCorrect = option == quizData[index]['correctAnswer'];
                  bool isSelected = userAnswers[index] == option;
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: userAnswers[index],
                    onChanged: (value) => checkAnswer(index, value!),
                    activeColor: isSelected
                        ? allQuestionsAnswered
                            ? isCorrect
                                ? Colors.green
                                : Colors.red
                            : Colors.blue // Change the color when selected
                        : null,
                  );
                })),
                SizedBox(height: 20.0),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: allQuestionsAnswered ? null : _showResult,
        child: Icon(Icons.check),
      ),
    );
  }
}
