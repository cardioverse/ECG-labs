import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JWaveQuizScreen extends StatefulWidget {
  @override
  _JWaveQuizScreenState createState() => _JWaveQuizScreenState();
}

class _JWaveQuizScreenState extends State<JWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  final int passThreshold = 8;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the J wave represent in an ECG?',
      'options': [
        'Atrial depolarization',
        'Early repolarization of the ventricles',
        'Ventricular depolarization',
        'Atrial repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'In which condition is a prominent J wave typically seen?',
      'options': [
        'Brugada syndrome',
        'Atrial fibrillation',
        'Left ventricular hypertrophy',
        'Ventricular tachycardia'
      ],
      'answer': 0,
    },
    {
      'question': 'The J wave is also known as?',
      'options': [
        'Delta wave',
        'Osborn wave',
        'P wave',
        'U wave'
      ],
      'answer': 1,
    },
    {
      'question': 'J waves are most commonly seen in which leads?',
      'options': [
        'Leads V1-V3',
        'Leads II, III, aVF',
        'Leads I, aVL',
        'All leads'
      ],
      'answer': 0,
    },
    {
      'question': 'Which electrolyte imbalance is associated with J waves?',
      'options': [
        'Hyperkalemia',
        'Hypocalcemia',
        'Hypercalcemia',
        'Hypothermia'
      ],
      'answer': 3,
    },
    {
      'question': 'Which condition is NOT associated with J waves?',
      'options': [
        'Hypothermia',
        'Hyperkalemia',
        'Brugada syndrome',
        'Early repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'J waves in hypothermia are also called?',
      'options': [
        'Epsilon waves',
        'Osborn waves',
        'Delta waves',
        'Q waves'
      ],
      'answer': 1,
    },
    {
      'question': 'J waves are most commonly associated with which cardiac event?',
      'options': [
        'Atrial fibrillation',
        'Ventricular fibrillation',
        'Asystole',
        'First-degree AV block'
      ],
      'answer': 1,
    },
    {
      'question': 'Which population often has benign J waves?',
      'options': [
        'Elderly patients',
        'Athletes',
        'Patients with heart failure',
        'Infants'
      ],
      'answer': 1,
    },
    {
      'question': 'Which ECG feature is often seen alongside J waves?',
      'options': [
        'ST elevation',
        'ST depression',
        'T wave inversion',
        'Prolonged PR interval'
      ],
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
      if (user != null && score >= passThreshold) {
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);

        await userDoc.set({
          'completedTopics.jWave': true,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('J Wave Quiz'),
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