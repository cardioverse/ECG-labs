import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeadPositioningQuizScreen extends StatefulWidget {
  @override
  _LeadPositioningQuizScreenState createState() => _LeadPositioningQuizScreenState();
}

class _LeadPositioningQuizScreenState extends State<LeadPositioningQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
    {'question': 'Where should the V1 electrode be placed?', 'options': ['4th intercostal space, right sternal border', '5th intercostal space, midclavicular line', '4th intercostal space, left sternal border', '5th intercostal space, anterior axillary line'], 'answer': 0},
    {'question': 'Which lead is placed at the left arm?', 'options': ['Lead I', 'Lead III', 'Lead aVL', 'Lead V6'], 'answer': 2},
    {'question': 'Where is the V6 electrode positioned?', 'options': ['4th intercostal space, left sternal border', '5th intercostal space, midaxillary line', '5th intercostal space, midclavicular line', '6th intercostal space, midaxillary line'], 'answer': 1},
    {'question': 'What is the function of the precordial leads?', 'options': ['Monitor limb activity', 'Record electrical activity in the horizontal plane', 'Measure arterial pressure', 'Detect muscle tremors'], 'answer': 1},
    {'question': 'Which lead is most useful for detecting atrial activity?', 'options': ['Lead II', 'Lead III', 'Lead aVL', 'Lead V1'], 'answer': 0},
    {'question': 'What is the correct placement of Lead II?', 'options': ['RA to LA', 'RA to LL', 'LA to LL', 'V1 to V6'], 'answer': 1},
    {'question': 'Which lead is perpendicular to Lead I?', 'options': ['Lead III', 'Lead aVF', 'Lead aVR', 'Lead aVL'], 'answer': 2},
    {'question': 'What is the purpose of the augmented limb leads?', 'options': ['Provide 360-degree heart monitoring', 'Enhance signals from standard limb leads', 'Measure heart rate only', 'Monitor blood pressure'], 'answer': 1},
    {'question': 'Which chest lead is positioned at the midclavicular line?', 'options': ['V1', 'V2', 'V3', 'V4'], 'answer': 3},
    {'question': 'What do bipolar leads measure?', 'options': ['Electrical potential difference between two limbs', 'Single point voltage changes', 'Respiratory rate', 'Only ventricular activity'], 'answer': 0},
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
        await userDoc.set({'completedTopics.leadPositioning': true}, SetOptions(merge: true));
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
            if (score >= 8)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _storeCompletionStatus();
                },
                child: Text('Mark as Complete'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: Text('Try Again'),
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
        title: Text('Lead Positioning Quiz'),
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
