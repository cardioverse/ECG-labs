import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QWaveQuizScreen extends StatefulWidget {
  @override
  _QWaveQuizScreenState createState() => _QWaveQuizScreenState();
}

class _QWaveQuizScreenState extends State<QWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the Q wave represent in an ECG?',
      'options': [
        'Atrial depolarization',
        'Septal depolarization',
        'Atrial repolarization',
        'Ventricular repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'What is a significant Q wave an indicator of?',
      'options': [
        'Right ventricular hypertrophy',
        'Previous myocardial infarction',
        'Atrial fibrillation',
        'Bundle branch block'
      ],
      'answer': 1,
    },
    {
      'question': 'In which leads are normal Q waves usually seen?',
      'options': [
        'Leads I, aVL, V5, V6',
        'Leads II, III, aVF',
        'Leads V1, V2',
        'All leads'
      ],
      'answer': 0,
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
          'completedTopics.qWave': true,
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
        title: Text('Q Wave Quiz'),
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