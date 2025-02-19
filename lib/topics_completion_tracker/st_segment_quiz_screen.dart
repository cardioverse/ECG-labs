import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class STSegmentQuizScreen extends StatefulWidget {
  @override
  _STSegmentQuizScreenState createState() => _STSegmentQuizScreenState();
}

class _STSegmentQuizScreenState extends State<STSegmentQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  final int passThreshold = 8;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the ST segment represent?',
      'options': [
        'Atrial depolarization',
        'The plateau phase of ventricular repolarization',
        'Ventricular depolarization',
        'The time from atrial to ventricular depolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'Where is the ST segment located in the ECG?',
      'options': [
        'Between the P wave and QRS complex',
        'Between the QRS complex and T wave',
        'After the T wave',
        'Before the P wave'
      ],
      'answer': 1,
    },
    {
      'question': 'What does an elevated ST segment suggest?',
      'options': [
        'Myocardial infarction',
        'First-degree AV block',
        'Atrial fibrillation',
        'Ventricular hypertrophy'
      ],
      'answer': 0,
    },
    {
      'question': 'What does a depressed ST segment indicate?',
      'options': [
        'Hyperkalemia',
        'Myocardial ischemia',
        'Left bundle branch block',
        'Right ventricular hypertrophy'
      ],
      'answer': 1,
    },
    {
      'question': 'Which condition is least likely to cause ST segment elevation?',
      'options': [
        'Pericarditis',
        'Myocardial infarction',
        'Hypercalcemia',
        'Left ventricular aneurysm'
      ],
      'answer': 2,
    },
    {
      'question': 'What does a downsloping ST depression indicate?',
      'options': [
        'Pericarditis',
        'Ischemia',
        'Benign early repolarization',
        'Hyperkalemia'
      ],
      'answer': 1,
    },
    {
      'question': 'ST elevation in leads II, III, and aVF suggests infarction in which area?',
      'options': [
        'Anterior',
        'Lateral',
        'Inferior',
        'Septal'
      ],
      'answer': 2,
    },
    {
      'question': 'Which feature differentiates benign early repolarization from myocardial infarction?',
      'options': [
        'Concave ST elevation',
        'Reciprocal ST depression',
        'T wave inversion',
        'Q waves'
      ],
      'answer': 1,
    },
    {
      'question': 'What does ST elevation with PR depression suggest?',
      'options': [
        'Myocardial infarction',
        'Hyperkalemia',
        'Pericarditis',
        'Hypothermia'
      ],
      'answer': 2,
    },
    {
      'question': 'ST elevation in aVR with widespread ST depression suggests?',
      'options': [
        'Hypercalcemia',
        'Pericarditis',
        'Left bundle branch block',
        'Left main coronary artery occlusion'
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
          'completedTopics.stSegment': true,
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
        title: Text('ST Segment Quiz'),
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