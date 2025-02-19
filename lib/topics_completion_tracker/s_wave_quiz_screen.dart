import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SWaveQuizScreen extends StatefulWidget {
  @override
  _SWaveQuizScreenState createState() => _SWaveQuizScreenState();
}

class _SWaveQuizScreenState extends State<SWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;
  final int passThreshold = 8;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the S wave represent in an ECG?',
      'options': [
        'Atrial depolarization',
        'Ventricular depolarization',
        'Atrial repolarization',
        'Ventricular repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'In which leads is the S wave typically deepest?',
      'options': [
        'Leads I, aVL',
        'Leads II, III, aVF',
        'Leads V1, V2',
        'Leads V5, V6'
      ],
      'answer': 2,
    },
    {
      'question': 'What does an abnormally prominent S wave in lead V1 indicate?',
      'options': [
        'Left ventricular hypertrophy',
        'Right ventricular hypertrophy',
        'Myocardial infarction',
        'Normal variant'
      ],
      'answer': 1,
    },
    {
      'question': 'A deep S wave in lead V6 suggests?',
      'options': [
        'Right bundle branch block',
        'Left bundle branch block',
        'Atrial fibrillation',
        'Pericarditis'
      ],
      'answer': 0,
    },
    {
      'question': 'Which condition is associated with an S1Q3T3 pattern?',
      'options': [
        'Pulmonary embolism',
        'Myocardial infarction',
        'Ventricular tachycardia',
        'Hyperkalemia'
      ],
      'answer': 0,
    },
    {
      'question': 'In which condition can an S wave persist in lateral leads?',
      'options': [
        'Right ventricular hypertrophy',
        'Left atrial enlargement',
        'Pericardial effusion',
        'Hyperthyroidism'
      ],
      'answer': 0,
    },
    {
      'question': 'What does a prominent S wave in lead I suggest?',
      'options': [
        'Left axis deviation',
        'Right axis deviation',
        'Myocardial infarction',
        'Atrial flutter'
      ],
      'answer': 1,
    },
    {
      'question': 'A large S wave in V3 is commonly seen in?',
      'options': [
        'Brugada syndrome',
        'Right ventricular hypertrophy',
        'Atrial fibrillation',
        'Sinus bradycardia'
      ],
      'answer': 1,
    },
    {
      'question': 'What does an S wave in lead aVR indicate?',
      'options': [
        'Normal finding',
        'Right ventricular hypertrophy',
        'Pericarditis',
        'Inferior infarction'
      ],
      'answer': 0,
    },
    {
      'question': 'What does an S wave in all precordial leads suggest?',
      'options': [
        'Ventricular hypertrophy',
        'Myocarditis',
        'Low QRS voltage',
        'Bundle branch block'
      ],
      'answer': 3,
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
          'completedTopics.sWave': true,
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
        title: Text('S Wave Quiz'),
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
