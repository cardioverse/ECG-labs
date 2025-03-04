import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QRSComplexQuizScreen extends StatefulWidget {
  const QRSComplexQuizScreen({super.key});

  @override
  _QRSComplexQuizScreenState createState() => _QRSComplexQuizScreenState();
}

class _QRSComplexQuizScreenState extends State<QRSComplexQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the QRS complex represent in an ECG?',
      'options': [
        'Atrial depolarization',
        'Ventricular depolarization',
        'Atrial repolarization',
        'Ventricular repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'What is the normal duration of the QRS complex?',
      'options': [
        '0.06 - 0.10 seconds',
        '0.12 - 0.20 seconds',
        '0.20 - 0.30 seconds',
        '0.30 - 0.40 seconds'
      ],
      'answer': 0,
    },
    {
      'question': 'What condition is indicated by a widened QRS complex?',
      'options': [
        'Left atrial enlargement',
        'Right atrial enlargement',
        'Bundle branch block',
        'Normal sinus rhythm'
      ],
      'answer': 2,
    },
    {
      'question': 'Which lead primarily assesses QRS axis deviation?',
      'options': ['Lead I', 'Lead II', 'Lead aVF', 'Lead III'],
      'answer': 0,
    },
    {
      'question': 'What does a notched QRS complex suggest?',
      'options': ['Ventricular hypertrophy', 'Myocardial infarction', 'Bundle branch block', 'Atrial fibrillation'],
      'answer': 2,
    },
    {
      'question': 'What causes pathological Q waves in the QRS complex?',
      'options': ['Hyperkalemia', 'Myocardial infarction', 'Atrial flutter', 'Pericarditis'],
      'answer': 1,
    },
    {
      'question': 'Which electrolyte imbalance can prolong the QRS duration?',
      'options': ['Hypokalemia', 'Hyperkalemia', 'Hyponatremia', 'Hypercalcemia'],
      'answer': 1,
    },
    {
      'question': 'A tall R wave in V1 suggests?',
      'options': ['Right bundle branch block', 'Left bundle branch block', 'Hyperkalemia', 'Pericarditis'],
      'answer': 0,
    },
    {
      'question': 'What does a narrow QRS complex indicate?',
      'options': ['Supraventricular origin', 'Ventricular origin', 'Left atrial enlargement', 'Right atrial enlargement'],
      'answer': 0,
    },
    {
      'question': 'A delta wave in the QRS complex is associated with?',
      'options': ['WPW syndrome', 'AV block', 'Atrial fibrillation', 'PEA arrest'],
      'answer': 0,
    }
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
          'completedTopics.qrsComplex': true,
        }, SetOptions(merge: true));
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
          title: Text(passed ? 'Quiz Passed!' : 'Quiz Failed'),
          content: Text('You scored $score out of ${questions.length}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (passed) {
                  Navigator.of(context).pop();
                  _storeCompletionStatus();
                } else {
                  _resetQuiz();
                }
              },
              child: Text(passed ? 'Finish' : 'Retry'),
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
        title: const Text('QRS Complex Quiz'),
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(questions[currentQuestionIndex]['options'].length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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