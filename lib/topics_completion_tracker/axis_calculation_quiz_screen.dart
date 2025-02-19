import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AxisCalculationQuizScreen extends StatefulWidget {
  @override
  _AxisCalculationQuizScreenState createState() => _AxisCalculationQuizScreenState();
}

class _AxisCalculationQuizScreenState extends State<AxisCalculationQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which leads are primarily used to determine the cardiac axis?',
      'options': ['Leads I and II', 'Leads I and aVF', 'Leads V1 and V2', 'Leads III and aVR'],
      'answer': 1,
    },
    {
      'question': 'What does a positive QRS in both Lead I and aVF indicate?',
      'options': ['Left Axis Deviation', 'Normal Axis', 'Right Axis Deviation', 'Extreme Axis'],
      'answer': 1,
    },
    {
      'question': 'What is the normal range for the cardiac axis?',
      'options': ['0° to +90°', '-30° to +120°', '0° to +180°', '-90° to 0°'],
      'answer': 0,
    },
    {
      'question': 'Which condition is commonly associated with left axis deviation?',
      'options': ['Right Ventricular Hypertrophy', 'Left Ventricular Hypertrophy', 'Hyperkalemia', 'Pulmonary Embolism'],
      'answer': 1,
    },
    {
      'question': 'A right axis deviation is defined as an axis between:',
      'options': ['0° and +90°', '+90° and +180°', '-90° and 0°', '-30° and +120°'],
      'answer': 1,
    },
    {
      'question': 'Which condition is commonly associated with right axis deviation?',
      'options': ['Hypertension', 'Left Bundle Branch Block', 'Pulmonary Hypertension', 'Hyperthyroidism'],
      'answer': 2,
    },
    {
      'question': 'Extreme axis deviation is often seen in which condition?',
      'options': ['Atrial Fibrillation', 'Ventricular Tachycardia', 'Dextrocardia', 'Hypercalcemia'],
      'answer': 2,
    },
    {
      'question': 'Which lead is most useful in identifying left axis deviation?',
      'options': ['Lead III', 'Lead aVL', 'Lead V1', 'Lead II'],
      'answer': 1,
    },
    {
      'question': 'Which of the following is a normal variant and does not necessarily indicate disease?',
      'options': ['Right Axis Deviation', 'Extreme Axis Deviation', 'Physiological Left Axis Deviation', 'Indeterminate Axis'],
      'answer': 2,
    },
    {
      'question': 'Which method is commonly used to estimate cardiac axis?',
      'options': ['Hexaxial Reference System', 'Einthoven’s Triangle', 'Bayley’s Theorem', 'Wolff-Parkinson-White Calculation'],
      'answer': 0,
    },
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
      if (user != null && score >= 8) {
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);

        await userDoc.set({
          'completedTopics.axisCalculation': true,
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
            if (score >= 8) ...[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _storeCompletionStatus();
                },
                child: Text('Mark as Complete'),
              ),
            ],
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: Text('Retry'),
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
        title: Text('Axis Calculation Quiz'),
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
          ],
        ),
      ),
    );
  }
}
