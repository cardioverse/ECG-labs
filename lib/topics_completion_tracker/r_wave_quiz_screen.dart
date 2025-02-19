import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RWaveQuizScreen extends StatefulWidget {
  @override
  _RWaveQuizScreenState createState() => _RWaveQuizScreenState();
}

class _RWaveQuizScreenState extends State<RWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false;

  final List<Map<String, dynamic>> questions = [
  {'question': 'What does the R wave represent in an ECG?', 'options': ['Atrial depolarization', 'Ventricular depolarization', 'Atrial repolarization', 'Ventricular repolarization'], 'answer': 1},
{'question': 'What is the normal amplitude of the R wave in the limb leads?', 'options': ['Less than 5 mm', 'Less than 10 mm', 'Greater than 20 mm', 'Less than 15 mm'], 'answer': 1},
{'question': 'Which condition is indicated by an abnormally tall R wave in lead V1?', 'options': ['Left ventricular hypertrophy', 'Right ventricular hypertrophy', 'Myocardial infarction', 'Normal variant'], 'answer': 1},
{'question': 'What is the progression pattern of the R wave in precordial leads?', 'options': ['Decreases from V1 to V6', 'Increases from V1 to V6', 'Remains the same', 'Random variation'], 'answer': 1},
{'question': 'Which condition is associated with poor R wave progression?', 'options': ['Hyperkalemia', 'Myocardial infarction', 'Atrial fibrillation', 'Ventricular tachycardia'], 'answer': 1},
{'question': 'What does an absent R wave in V1-V3 suggest?', 'options': ['Bundle branch block', 'Myocardial infarction', 'Pericarditis', 'Atrial enlargement'], 'answer': 1},
{'question': 'A broad R wave in lead I and aVL is suggestive of?', 'options': ['Left bundle branch block', 'Right bundle branch block', 'WPW Syndrome', 'Hypercalcemia'], 'answer': 0},
{'question': 'Which condition can cause a low voltage R wave?', 'options': ['Pericardial effusion', 'Hypertension', 'Hyperthyroidism', 'Sinus tachycardia'], 'answer': 0},
{'question': 'Where is the tallest R wave typically found in a normal ECG?', 'options': ['V1', 'V3', 'V5', 'aVR'], 'answer': 2},
{'question': 'What does an RSR- pattern in V1 indicate?', 'options': ['Left bundle branch block', 'Right bundle branch block', 'Hyperkalemia', 'Hypokalemia'], 'answer': 1},
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
await userDoc.set({'completedTopics.rWave': true}, SetOptions(merge: true));
}
} catch (e) {
print('Error storing completion status: $e');
}
}

void _showCompletionDialog() {
bool passed = score >= 8;
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: Text(passed ? 'Quiz Passed!' : 'Quiz Failed'),
content: Text('You scored $score out of ${questions.length}.'),
actions: [
TextButton(
onPressed: () {
Navigator.of(context).pop();
if (passed) {
Navigator.of(context).pop();
_storeCompletionStatus();
} else {
_resetQuiz();
}
},
child: Text(passed ? 'Finish' : 'Retry'),
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
title: Text('R Wave Quiz'),
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
style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(height: 16),
Text(
questions[currentQuestionIndex]['question'],
style: TextStyle(color: Colors.white, fontSize: 18),
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
] else ...[
Center(
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.red,
padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
onPressed: _resetQuiz,
child: Text('Restart Quiz'),
),
),
],
],
),
),
);
}
}
