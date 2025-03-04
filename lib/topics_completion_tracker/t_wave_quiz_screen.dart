import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TWaveQuizScreen extends StatefulWidget {
  const TWaveQuizScreen({super.key});

  @override
  _TWaveQuizScreenState createState() => _TWaveQuizScreenState();
}

class _TWaveQuizScreenState extends State<TWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the T wave represent in an ECG?',
      'options': [
        'Atrial depolarization',
        'Ventricular repolarization',
        'Atrial repolarization',
        'Ventricular depolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'What is the normal shape of a T wave?',
      'options': [
        'Flat',
        'Inverted',
        'Asymmetrical and upright',
        'Biphasic'
      ],
      'answer': 2,
    },
    {
      'question': 'What condition is indicated by an inverted T wave?',
      'options': [
        'Left ventricular hypertrophy',
        'Right ventricular hypertrophy',
        'Myocardial ischemia',
        'Normal variant'
      ],
      'answer': 2,
    },
    {
      'question': 'Which electrolyte imbalance causes peaked T waves?',
      'options': ['Hypokalemia', 'Hyperkalemia', 'Hypocalcemia', 'Hypernatremia'],
      'answer': 1,
    },
    {
      'question': 'What does a flattened T wave suggest?',
      'options': ['Hyperkalemia', 'Hypokalemia', 'Hypercalcemia', 'Hypertension'],
      'answer': 1,
    },
    {
      'question': 'T wave inversion in V1-V3 can indicate?',
      'options': ['Pulmonary embolism', 'Pericarditis', 'Wellens syndrome', 'Atrial fibrillation'],
      'answer': 2,
    },
    {
      'question': 'Which leads typically show an upright T wave in a normal ECG?',
      'options': ['V1-V2', 'aVR', 'II, V3-V6', 'aVL'],
      'answer': 2,
    },
    {
      'question': 'T wave alternans is associated with?',
      'options': ['Atrial fibrillation', 'Ventricular arrhythmias', 'Bradycardia', 'Sinus tachycardia'],
      'answer': 1,
    },
    {
      'question': 'A notched T wave can be seen in?',
      'options': ['Hyperthyroidism', 'Hypothermia', 'Digitalis effect', 'Myocardial infarction'],
      'answer': 2,
    },
    {
      'question': 'Tall, symmetrical T waves may indicate?',
      'options': ['Hyperkalemia', 'Hypomagnesemia', 'Mitral stenosis', 'Pulmonary hypertension'],
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
          'completedTopics.tWave': true,
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
          content: Text(score >= 8
              ? 'You passed! Score: $score/10'
              : 'You failed. Score: $score/10. Try again!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (score >= 8) {
                  _storeCompletionStatus();
                  Navigator.of(context).pop();
                } else {
                  _resetQuiz();
                }
              },
              child: Text(score >= 8 ? 'Finish' : 'Retry'),
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
        title: const Text('T Wave Quiz'),
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
          ],
        ),
      ),
    );
  }
}
