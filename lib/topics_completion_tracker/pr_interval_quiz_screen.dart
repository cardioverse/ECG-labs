import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PRIntervalQuizScreen extends StatefulWidget {
  @override
  _PRIntervalQuizScreenState createState() => _PRIntervalQuizScreenState();
}

class _PRIntervalQuizScreenState extends State<PRIntervalQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the PR interval represent?',
      'options': [
        'The time from ventricular depolarization to repolarization',
        'The time from atrial depolarization to ventricular depolarization',
        'The duration of the QRS complex',
        'The time from ventricular depolarization to atrial repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'What is the normal range for the PR interval?',
      'options': [
        '0.08 to 0.12 seconds',
        '0.12 to 0.20 seconds',
        '0.20 to 0.30 seconds',
        '0.30 to 0.40 seconds'
      ],
      'answer': 1,
    },
    {
      'question': 'What does a prolonged PR interval indicate?',
      'options': [
        'Right ventricular hypertrophy',
        'First-degree AV block',
        'Wolff-Parkinson-White syndrome',
        'Atrial fibrillation'
      ],
      'answer': 1,
    },
    {
      'question': 'Which condition is associated with a shortened PR interval?',
      'options': [
        'First-degree AV block',
        'Right bundle branch block',
        'Pre-excitation syndromes',
        'Second-degree AV block'
      ],
      'answer': 2,
    },
  ];

  void _checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['answer']) {
      score++;
      setState(() {
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
        } else {
          _showCompletionDialog();
        }
      });
    } else {
      setState(() {
        showResetButton = true;
      });
    }
  }

  Future<void> _storeCompletionStatus() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && score == questions.length) {
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);

        await userDoc.set({
          'completedTopics.prInterval': true,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error storing completion status: $e');
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed!'),
          content: Text('You scored $score out of ${questions.length}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _storeCompletionStatus();
              },
              child: Text('Finish'),
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
      showResetButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PR Interval Quiz'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!showResetButton) ...[
              Text(
                'Question ${currentQuestionIndex + 1} of ${questions.length}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                questions[currentQuestionIndex]['question'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              ...List.generate(questions[currentQuestionIndex]['options'].length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _checkAnswer(index),
                    child: Text(questions[currentQuestionIndex]['options'][index]),
                  ),
                );
              }),
            ] else ...[
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _resetQuiz,
                  child: Text('Restart Quiz'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
