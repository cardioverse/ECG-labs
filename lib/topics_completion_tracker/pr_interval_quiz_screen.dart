import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PRIntervalQuizScreen extends StatefulWidget {
  const PRIntervalQuizScreen({super.key});

  @override
  _PRIntervalQuizScreenState createState() => _PRIntervalQuizScreenState();
}

class _PRIntervalQuizScreenState extends State<PRIntervalQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  final int passThreshold = 8;

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
    {
      'question': 'What abnormality can a variable PR interval suggest?',
      'options': [
        'Atrial fibrillation',
        'Second-degree AV block',
        'Myocardial infarction',
        'Sinus tachycardia'
      ],
      'answer': 1,
    },
    {
      'question': 'Which electrolyte imbalance can prolong the PR interval?',
      'options': [
        'Hypokalemia',
        'Hypercalcemia',
        'Hyperkalemia',
        'Hyponatremia'
      ],
      'answer': 2,
    },
    {
      'question': 'A progressively lengthening PR interval before a dropped beat is characteristic of?',
      'options': [
        'Mobitz Type I (Wenckebach)',
        'Mobitz Type II',
        'Complete heart block',
        'Atrial flutter'
      ],
      'answer': 0,
    },
    {
      'question': 'What does a PR interval shorter than 0.12 seconds typically indicate?',
      'options': [
        'Atrial fibrillation',
        'Pre-excitation syndrome (e.g., WPW)',
        'Sinus arrhythmia',
        'Right bundle branch block'
      ],
      'answer': 1,
    },
    {
      'question': 'Which drug is known to prolong the PR interval?',
      'options': [
        'Digoxin',
        'Aspirin',
        'Ibuprofen',
        'Lisinopril'
      ],
      'answer': 0,
    },
    {
      'question': 'What heart block can result in complete dissociation between P waves and QRS complexes?',
      'options': [
        'First-degree AV block',
        'Mobitz Type I',
        'Mobitz Type II',
        'Third-degree (complete) heart block'
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
        title: const Text('PR Interval Quiz'),
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