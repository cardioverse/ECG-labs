import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GridQuizScreen extends StatefulWidget {
  @override
  _GridQuizScreenState createState() => _GridQuizScreenState();
}

class _GridQuizScreenState extends State<GridQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {'question': 'What is the smallest division on ECG paper called?', 'options': ['Large Box', 'Small Box', 'Interval', 'Segment'], 'answer': 1},
    {'question': 'How much time does one large box on ECG paper represent?', 'options': ['0.2 seconds', '0.04 seconds', '1 second', '0.5 seconds'], 'answer': 0},
    {'question': 'How much voltage does one small box represent?', 'options': ['0.5 mV', '1 mV', '0.1 mV', '2 mV'], 'answer': 1},
    {'question': 'How many large boxes make up one second on an ECG?', 'options': ['5', '10', '20', '25'], 'answer': 0},
    {'question': 'What is the standard paper speed for an ECG?', 'options': ['25 mm/s', '50 mm/s', '10 mm/s', '100 mm/s'], 'answer': 0},
    {'question': 'What is the standard voltage calibration for an ECG?', 'options': ['5 mm/mV', '10 mm/mV', '15 mm/mV', '20 mm/mV'], 'answer': 1},
    {'question': 'How many small boxes are in one large box?', 'options': ['1', '5', '10', '20'], 'answer': 1},
    {'question': 'What does a small box on ECG paper represent in time?', 'options': ['0.02 sec', '0.04 sec', '0.06 sec', '0.08 sec'], 'answer': 1},
    {'question': 'What does a large box on ECG paper represent in voltage?', 'options': ['0.1 mV', '0.2 mV', '0.5 mV', '1 mV'], 'answer': 3},
    {'question': 'How many large boxes correspond to 6 seconds on ECG paper?', 'options': ['10', '15', '30', '5'], 'answer': 2},
  ];

  void _checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['answer']) {
      score++;
    }
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showCompletionDialog();
      }
    });
  }

  Future<void> _storeCompletionStatus() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);
        await userDoc.set({'completedTopics.grid': true}, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error storing completion status: $e');
    }
  }

  void _showCompletionDialog() {
    bool passed = score >= 8;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed!'),
          content: Text('You scored $score out of ${questions.length}.'),
          actions: [
            if (passed)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _storeCompletionStatus();
                },
                child: Text('Mark as Complete'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Quiz'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              questions[currentQuestionIndex]['question'],
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16),
            ...List.generate(questions[currentQuestionIndex]['options'].length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _checkAnswer(index),
                  child: Text(questions[currentQuestionIndex]['options'][index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
