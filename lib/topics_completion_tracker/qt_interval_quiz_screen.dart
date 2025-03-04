import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QTIntervalQuizScreen extends StatefulWidget {
  const QTIntervalQuizScreen({super.key});

  @override
  _QTIntervalQuizScreenState createState() => _QTIntervalQuizScreenState();
}

class _QTIntervalQuizScreenState extends State<QTIntervalQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  final int passThreshold = 8;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the QT interval represent?',
      'options': [
        'Atrial depolarization and repolarization',
        'Ventricular depolarization and repolarization',
        'Ventricular repolarization only',
        'Atrial depolarization only'
      ],
      'answer': 1,
    },
    {
      'question': 'What is the normal range for the QT interval in milliseconds?',
      'options': [
        '100-200 ms',
        '350-450 ms',
        '500-600 ms',
        '200-300 ms'
      ],
      'answer': 1,
    },
    {
      'question': 'What does a prolonged QT interval indicate?',
      'options': [
        'Bradycardia',
        'Ventricular arrhythmias',
        'Atrial flutter',
        'First-degree AV block'
      ],
      'answer': 1,
    },
    {
      'question': 'In which leads is the QT interval typically measured?',
      'options': [
        'Lead I and II',
        'V1 and V2',
        'Lead II or V5-6',
        'aVR and aVL'
      ],
      'answer': 2,
    },
    {
      'question': 'What is the corrected QT interval (QTc) used for?',
      'options': [
        'Adjusting QT interval for heart rate',
        'Measuring P wave duration',
        'Detecting bundle branch blocks',
        'Assessing atrial fibrillation severity'
      ],
      'answer': 0,
    },
    {
      'question': 'Which electrolyte imbalance can prolong the QT interval?',
      'options': [
        'Hyperkalemia',
        'Hypokalemia',
        'Hypernatremia',
        'Hyponatremia'
      ],
      'answer': 1,
    },
    {
      'question': 'Which medication is known to prolong the QT interval?',
      'options': [
        'Beta-blockers',
        'Macrolide antibiotics',
        'Loop diuretics',
        'Calcium channel blockers'
      ],
      'answer': 1,
    },
    {
      'question': 'What is a dangerously prolonged QT interval associated with?',
      'options': [
        'AV block',
        'Torsades de Pointes',
        'Sinus arrhythmia',
        'Wolff-Parkinson-White syndrome'
      ],
      'answer': 1,
    },
    {
      'question': 'What is a short QT interval commonly associated with?',
      'options': [
        'Hypercalcemia',
        'Hypocalcemia',
        'Hyperkalemia',
        'Hypokalemia'
      ],
      'answer': 0,
    },
    {
      'question': 'Which genetic syndrome is linked to prolonged QT interval?',
      'options': [
        'Brugada syndrome',
        'Long QT syndrome',
        'Wolff-Parkinson-White syndrome',
        'Lown-Ganong-Levine syndrome'
      ],
      'answer': 1,
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
      if (user != null && score >= passThreshold) {
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);

        await userDoc.set({
          'completedTopics.qtInterval': true,
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
          title: const Text('Quiz Completed!'),
          content: Text('You scored $score out of ${questions.length}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _storeCompletionStatus();
              },
              child: const Text('Finish'),
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
        title: const Text('QT Interval Quiz'),
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
