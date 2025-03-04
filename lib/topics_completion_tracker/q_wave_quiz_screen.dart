import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QWaveQuizScreen extends StatefulWidget {
  const QWaveQuizScreen({super.key});

  @override
  _QWaveQuizScreenState createState() => _QWaveQuizScreenState();
}

class _QWaveQuizScreenState extends State<QWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;
  final int passThreshold = 8;

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
    {
      'question': 'Which of the following is NOT a characteristic of a normal Q wave?',
      'options': [
        'Less than 40 ms duration',
        'Depth less than 25% of R wave',
        'Present in all leads',
        'Usually seen in lateral leads'
      ],
      'answer': 2,
    },
    {
      'question': 'What is the usual cause of deep Q waves?',
      'options': [
        'Myocardial infarction',
        'Atrial fibrillation',
        'Pericarditis',
        'Sinus bradycardia'
      ],
      'answer': 0,
    },
    {
      'question': 'A pathological Q wave is typically how wide?',
      'options': [
        'Less than 20 ms',
        'Greater than 40 ms',
        'Between 10-30 ms',
        'Greater than 60 ms'
      ],
      'answer': 1,
    },
    {
      'question': 'Which condition can cause pseudo-infarct Q waves?',
      'options': [
        'Hypertrophic cardiomyopathy',
        'Pericardial effusion',
        'Hyperkalemia',
        'AV block'
      ],
      'answer': 0,
    },
    {
      'question': 'Q waves in which lead may suggest an old inferior infarction?',
      'options': [
        'V1',
        'aVR',
        'II, III, aVF',
        'I, aVL'
      ],
      'answer': 2,
    },
    {
      'question': 'In which condition are deep Q waves a normal variant?',
      'options': [
        'Athletes heart',
        'Myocardial infarction',
        'Ventricular tachycardia',
        'Hyperthyroidism'
      ],
      'answer': 0,
    },
    {
      'question': 'What does a Q wave in V1-V3 typically indicate?',
      'options': [
        'Normal finding',
        'Prior anterior infarction',
        'Pericarditis',
        'Atrial enlargement'
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
        title: const Text('Q Wave Quiz'),
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
