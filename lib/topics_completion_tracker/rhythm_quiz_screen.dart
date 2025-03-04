import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RhythmQuizScreen extends StatefulWidget {
  const RhythmQuizScreen({super.key});

  @override
  _RhythmQuizScreenState createState() => _RhythmQuizScreenState();
}

class _RhythmQuizScreenState extends State<RhythmQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {'question': 'What is the normal rhythm of a healthy heart called?', 'options': ['Atrial Flutter', 'Sinus Rhythm', 'Ventricular Fibrillation', 'Atrial Fibrillation'], 'answer': 1},
    {'question': 'Which part of the heart initiates the electrical impulse for a normal heartbeat?', 'options': ['AV Node', 'SA Node', 'Purkinje Fibers', 'Bundle of His'], 'answer': 1},
    {'question': 'What is an irregular heart rhythm called?', 'options': ['Bradycardia', 'Tachycardia', 'Arrhythmia', 'Sinus Rhythm'], 'answer': 2},
    {'question': 'Which arrhythmia is life-threatening and requires immediate defibrillation?', 'options': ['Atrial Fibrillation', 'Ventricular Fibrillation', 'Sinus Tachycardia', 'First-Degree AV Block'], 'answer': 1},
    {'question': 'Which ECG wave represents atrial depolarization?', 'options': ['P wave', 'QRS complex', 'T wave', 'ST segment'], 'answer': 0},
    {'question': 'What does a prolonged PR interval indicate?', 'options': ['Atrial Fibrillation', 'First-Degree AV Block', 'Bundle Branch Block', 'Sinus Bradycardia'], 'answer': 1},
    {'question': 'Which rhythm has a sawtooth pattern on ECG?', 'options': ['Atrial Fibrillation', 'Atrial Flutter', 'Ventricular Tachycardia', 'Sinus Bradycardia'], 'answer': 1},
    {'question': 'Which electrolyte imbalance can cause prolonged QT interval?', 'options': ['Hypokalemia', 'Hypercalcemia', 'Hypocalcemia', 'Hyperkalemia'], 'answer': 2},
    {'question': 'Which arrhythmia is commonly caused by excessive caffeine intake?', 'options': ['Sinus Tachycardia', 'Ventricular Fibrillation', 'Premature Atrial Contractions (PACs)', 'Atrial Flutter'], 'answer': 2},
    {'question': 'Which rhythm is characterized by no P waves and irregularly irregular QRS complexes?', 'options': ['Atrial Flutter', 'Ventricular Tachycardia', 'Atrial Fibrillation', 'Sinus Arrhythmia'], 'answer': 2},
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
        await userDoc.set({'completedTopics.rhythm': true}, SetOptions(merge: true));
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
          content: Text('You got $score correct and ${questions.length - score} wrong.'),
          actions: [
            TextButton(
              onPressed: () {
                if (score >= 8) {
                  _storeCompletionStatus();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  _resetQuiz();
                }
              },
              child: Text(score >= 8 ? 'Mark as Complete' : 'Try Again'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rhythm Quiz'),
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
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(color: Colors.white, fontSize: 18),
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
