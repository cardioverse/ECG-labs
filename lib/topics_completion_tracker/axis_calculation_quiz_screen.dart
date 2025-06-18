import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AxisCalculationQuizScreen extends StatefulWidget {
  const AxisCalculationQuizScreen({super.key});

  @override
  _AxisCalculationQuizScreenState createState() => _AxisCalculationQuizScreenState();
}

class _AxisCalculationQuizScreenState extends State<AxisCalculationQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResetButton = false; // This variable isn't used in the provided code logic, consider removing if not needed.

  // New state variables for feedback
  int? _selectedOptionIndex; // Stores the index of the option the user tapped
  bool _isAnswerEvaluated = false; // True when an answer has been picked and evaluated

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which leads are primarily used to determine the cardiac axis?',
      'options': ['Leads I and II', 'Leads I and aVF', 'Leads V1 and V2', 'Leads III and aVR'],
      'answer': 1,
    },
    {
      'question': 'What does a positive QRS in both Lead I and aVF indicate?',
      'options': ['Left Axis Deviation', 'Normal Axis', 'Right Axis Deviation', 'Extreme Axis'],
      'answer': 1,
    },
    {
      'question': 'What is the normal range for the cardiac axis?',
      'options': ['0° to +90°', '-30° to +120°', '0° to +180°', '-90° to 0°'],
      'answer': 0,
    },
    {
      'question': 'Which condition is commonly associated with left axis deviation?',
      'options': ['Right Ventricular Hypertrophy', 'Left Ventricular Hypertrophy', 'Hyperkalemia', 'Pulmonary Embolism'],
      'answer': 1,
    },
    {
      'question': 'A right axis deviation is defined as an axis between:',
      'options': ['0° and +90°', '+90° and +180°', '-90° and 0°', '-30° and +120°'],
      'answer': 1,
    },
    {
      'question': 'Which condition is commonly associated with right axis deviation?',
      'options': ['Hypertension', 'Left Bundle Branch Block', 'Pulmonary Hypertension', 'Hyperthyroidism'],
      'answer': 2,
    },
    {
      'question': 'Extreme axis deviation is often seen in which condition?',
      'options': ['Atrial Fibrillation', 'Ventricular Tachycardia', 'Dextrocardia', 'Hypercalcemia'],
      'answer': 2,
    },
    {
      'question': 'Which lead is most useful in identifying left axis deviation?',
      'options': ['Lead III', 'Lead aVL', 'Lead V1', 'Lead II'],
      'answer': 1,
    },
    {
      'question': 'Which of the following is a normal variant and does not necessarily indicate disease?',
      'options': ['Right Axis Deviation', 'Extreme Axis Deviation', 'Physiological Left Axis Deviation', 'Indeterminate Axis'],
      'answer': 2,
    },
    {
      'question': 'Which method is commonly used to estimate cardiac axis?',
      'options': ['Hexaxial Reference System', 'Einthoven’s Triangle', 'Bayley’s Theorem', 'Wolff-Parkinson-White Calculation'],
      'answer': 0,
    },
  ];

  void _checkAnswer(int selectedIndex) {
    // This check is crucial to prevent multiple evaluations if the button
    // is tapped again before _isAnswerEvaluated is reset for the next question.
    if (_isAnswerEvaluated) {
      return;
    }

    setState(() {
      _selectedOptionIndex = selectedIndex;
      _isAnswerEvaluated = true; // Mark that the answer has been evaluated for this question

      if (selectedIndex == questions[currentQuestionIndex]['answer']) {
        score++;
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      _selectedOptionIndex = null; // Reset selected option for next question
      _isAnswerEvaluated = false; // Reset evaluation status

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
          'completedTopics.axisCalculation': true,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error storing completion status: $e');
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Completed!'),
          content: Text('You scored $score out of ${questions.length}.'),
          actions: [
            if (score >= 8) ...[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Pop the dialog
                  Navigator.of(context).pop(); // Pop the quiz screen
                  _storeCompletionStatus();
                },
                child: const Text('Mark as Complete'),
              ),
            ],
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pop the dialog
                _resetQuiz();
              },
              child: const Text('Retry'),
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
      _selectedOptionIndex = null;
      _isAnswerEvaluated = false;
      showResetButton = false; // Unused, consider removing
    });
  }

  // Helper function to determine button color based on feedback
  Color _getOptionButtonColor(int index) {
    if (!_isAnswerEvaluated) {
      return Colors.white; // Default color before evaluation
    }
    // After evaluation
    if (index == questions[currentQuestionIndex]['answer']) {
      return Colors.green.shade700; // Correct answer is always green
    } else if (index == _selectedOptionIndex) {
      return Colors.red.shade700; // Incorrectly selected answer is red
    }
    return Colors.white; // Other unselected options remain white
  }

  // Helper function to determine button text color for contrast
  Color _getOptionButtonTextColor(int index) {
    if (!_isAnswerEvaluated) {
      return Colors.black; // Default text color
    }
    // After evaluation
    if (index == questions[currentQuestionIndex]['answer'] || index == _selectedOptionIndex) {
      return Colors.white; // Text is white for highlighted (green/red) buttons
    }
    return Colors.black; // Text is black for non-highlighted buttons
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Axis Calculation Quiz'), // Removed score from AppBar
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // Ensures title and icons are white
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Score Tracker (relocated) ---
            Text(
              'Score: $score / ${questions.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // Spacing after score
            // --- End Score Tracker ---

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
            Expanded( // Use Expanded to give the list of buttons available space
              child: ListView.builder(
                itemCount: questions[currentQuestionIndex]['options'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getOptionButtonColor(index),
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Optional: add some rounded corners
                        ),
                      ),
                      // *********************************************************************
                      // FIX: The onPressed callback should always be present,
                      // and the _checkAnswer function itself will handle
                      // preventing re-evaluation. This ensures the button
                      // remains visually "active" to apply custom colors.
                      // *********************************************************************
                      onPressed: () => _checkAnswer(index),
                      child: Text(
                        questions[currentQuestionIndex]['options'][index],
                        style: TextStyle(
                          color: _getOptionButtonTextColor(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isAnswerEvaluated) // Show "Next Question" button only after an answer is selected
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _goToNextQuestion,
                    child: Text(
                      currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz',
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16), // Add some bottom spacing
          ],
        ),
      ),
    );
  }
}
