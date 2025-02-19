import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RateQuizScreen extends StatefulWidget {
  @override
  _RateQuizScreenState createState() => _RateQuizScreenState();
}

class _RateQuizScreenState extends State<RateQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;

  final List<Map<String, dynamic>> questions = [
    {'question': 'What is the normal resting heart rate range for adults?', 'options': ['40-60 bpm', '60-100 bpm', '100-120 bpm', '120-160 bpm'], 'answer': 1},
    {'question': 'Which finger should not be used to measure pulse rate?', 'options': ['Index finger', 'Middle finger', 'Thumb', 'Ring finger'], 'answer': 2},
    {'question': 'How do you estimate heart rate using an ECG?', 'options': ['300 divided by large squares', '1500 divided by large squares', '300 multiplied by small squares', '1500 multiplied by large squares'], 'answer': 0},
    {'question': 'What is the normal heart rate for a newborn?', 'options': ['60-100 bpm', '100-160 bpm', '40-60 bpm', '80-120 bpm'], 'answer': 1},
    {'question': 'Which factor does NOT typically affect heart rate?', 'options': ['Exercise', 'Temperature', 'Age', 'Blood Type'], 'answer': 3},
    {'question': 'Bradycardia refers to a heart rate below:', 'options': ['60 bpm', '80 bpm', '100 bpm', '50 bpm'], 'answer': 0},
    {'question': 'Tachycardia is defined as a heart rate above:', 'options': ['60 bpm', '80 bpm', '100 bpm', '120 bpm'], 'answer': 2},
    {'question': 'Which method is commonly used to measure heart rate manually?', 'options': ['Blood test', 'Chest X-ray', 'Palpation of radial artery', 'MRI scan'], 'answer': 2},
    {'question': 'What device is used for continuous heart rate monitoring?', 'options': ['ECG', 'Sphygmomanometer', 'Pulse oximeter', 'Glucometer'], 'answer': 0},
    {'question': 'Which nervous system primarily controls heart rate?', 'options': ['Somatic', 'Autonomic', 'Central', 'Peripheral'], 'answer': 1},
  ];

  void _checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['answer']) {
      score++;
    }

    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        quizCompleted = true;
      }
    });
  }

  Future<void> _storeCompletionStatus() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);
        await userDoc.set({'completedTopics.rate': true}, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error storing completion status: $e');
    }
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rate Quiz'), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: quizCompleted
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!\nCorrect: $score/10\nIncorrect: ${10 - score}/10',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (score >= 8)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  _storeCompletionStatus();
                  Navigator.of(context).pop();
                },
                child: Text('Mark as Complete'),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _resetQuiz,
              child: Text('Retry Quiz'),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${currentQuestionIndex + 1} of ${questions.length}',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(questions[currentQuestionIndex]['question'],
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 16),
            ...List.generate(questions[currentQuestionIndex]['options'].length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
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
