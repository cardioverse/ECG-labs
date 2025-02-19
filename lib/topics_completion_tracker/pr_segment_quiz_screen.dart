import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PRSegmentQuizScreen extends StatefulWidget {
  @override
  _PRSegmentQuizScreenState createState() => _PRSegmentQuizScreenState();
}

class _PRSegmentQuizScreenState extends State<PRSegmentQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  final int passThreshold = 8;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the PR segment represent?',
      'options': [
        'Atrial depolarization',
        'The delay in conduction through the AV node',
        'Ventricular depolarization',
        'Ventricular repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'Where is the PR segment located in the ECG?',
      'options': [
        'Between the P wave and QRS complex',
        'After the T wave',
        'Between the QRS complex and T wave',
        'Before the P wave'
      ],
      'answer': 0,
    },
    {
      'question': 'What is the significance of a prolonged PR segment?',
      'options': [
        'Left ventricular hypertrophy',
        'AV block',
        'Myocardial infarction',
        'Atrial flutter'
      ],
      'answer': 1,
    },
    {
      'question': 'What condition might cause a shortened PR segment?',
      'options': [
        'WPW syndrome',
        'Right bundle branch block',
        'Ventricular fibrillation',
        'Sinus tachycardia'
      ],
      'answer': 0,
    },
    {
      'question': 'What is the normal duration of the PR segment?',
      'options': [
        '40-120 ms',
        '50-150 ms',
        '120-200 ms',
        '200-300 ms'
      ],
      'answer': 2,
    },
    {
      'question': 'Which condition can cause PR segment depression?',
      'options': [
        'Pericarditis',
        'Atrial fibrillation',
        'Left bundle branch block',
        'Hyperkalemia'
      ],
      'answer': 0,
    },
    {
      'question': 'What does an elevated PR segment indicate?',
      'options': [
        'Pericarditis',
        'Atrial enlargement',
        'Hypercalcemia',
        'Sinus tachycardia'
      ],
      'answer': 1,
    },
    {
      'question': 'Which electrolyte imbalance can affect the PR segment?',
      'options': [
        'Hypokalemia',
        'Hypercalcemia',
        'Hyponatremia',
        'Hypomagnesemia'
      ],
      'answer': 0,
    },
    {
      'question': 'Which of these conditions does NOT affect the PR segment?',
      'options': [
        'AV block',
        'Myocarditis',
        'Atrial fibrillation',
        'Ventricular hypertrophy'
      ],
      'answer': 3,
    },
    {
      'question': 'What is the usual cause of a variable PR segment?',
      'options': [
        'Wandering atrial pacemaker',
        'Hyperkalemia',
        'Atrial flutter',
        'Sinus tachycardia'
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
          'completedTopics.prSegment': true,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error storing completion status: \$e');
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
        title: Text('PR Segment Quiz'),
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