import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PWaveQuizScreen extends StatefulWidget {
  const PWaveQuizScreen({super.key});

  @override
  _PWaveQuizScreenState createState() => _PWaveQuizScreenState();
}

class _PWaveQuizScreenState extends State<PWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the P wave represent in an ECG?',
      'options': ['Atrial depolarization', 'Ventricular depolarization', 'Atrial repolarization', 'Ventricular repolarization'],
      'answer': 0,
    },
    {
      'question': 'What is the normal duration of a P wave?',
      'options': ['0.04 - 0.06 seconds', '0.06 - 0.12 seconds', '0.12 - 0.20 seconds', '0.20 - 0.30 seconds'],
      'answer': 1,
    },
    {
      'question': 'Which condition is indicated by a peaked P wave?',
      'options': ['Left atrial enlargement', 'Right atrial enlargement', 'Myocardial infarction', 'Right bundle branch block'],
      'answer': 1,
    },
    // 7 more questions added
    {
      'question': 'Where is the P wave best observed in a normal ECG?',
      'options': ['Lead II', 'aVR', 'V5', 'V6'],
      'answer': 0,
    },
    {
      'question': 'Which leads usually show an inverted P wave in normal conditions?',
      'options': ['Lead I', 'Lead II', 'aVR', 'V3'],
      'answer': 2,
    },
    {
      'question': 'What does a notched P wave suggest?',
      'options': ['Atrial fibrillation', 'Right atrial enlargement', 'Left atrial enlargement', 'Sinus tachycardia'],
      'answer': 2,
    },
    {
      'question': 'What happens to the P wave in atrial fibrillation?',
      'options': ['It disappears', 'Becomes peaked', 'Becomes biphasic', 'Becomes larger'],
      'answer': 0,
    },
    {
      'question': 'What condition is indicated by a short PR interval and slurred P wave?',
      'options': ['Atrial flutter', 'Wolff-Parkinson-White syndrome', 'AV Block', 'Hyperkalemia'],
      'answer': 1,
    },
    {
      'question': 'What is a common cause of absent P waves?',
      'options': ['AV block', 'Sinus arrest', 'Atrial fibrillation', 'All of the above'],
      'answer': 3,
    },
    {
      'question': 'Which electrolyte imbalance can flatten the P wave?',
      'options': ['Hyperkalemia', 'Hypokalemia', 'Hypercalcemia', 'Hyponatremia'],
      'answer': 0,
    },
  ];

  void _checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['answer']) {
      correctAnswers++;
    } else {
      incorrectAnswers++;
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
      if (user != null && correctAnswers >= 8) {
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);
        await userDoc.set({
          'completedTopics.pWave': true,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error storing completion status: $e');
    }
  }

  void _showCompletionDialog() {
    bool passed = correctAnswers >= 8;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(passed ? 'Quiz Passed!' : 'Quiz Failed'),
          content: Text('Correct: $correctAnswers | Incorrect: $incorrectAnswers'),
          actions: [
            if (passed)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _storeCompletionStatus();
                },
                child: const Text('Finish'),
              )
            else
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetQuiz();
                },
                child: const Text('Retry'),
              )
          ],
        );
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      correctAnswers = 0;
      incorrectAnswers = 0;
      showResetButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P Wave Quiz'),
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
