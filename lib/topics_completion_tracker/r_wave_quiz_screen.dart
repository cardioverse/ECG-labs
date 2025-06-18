import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RWaveQuizScreen extends StatefulWidget {
  const RWaveQuizScreen({super.key}); // Added const constructor for consistency

  @override
  _RWaveQuizScreenState createState() => _RWaveQuizScreenState();
}

class _RWaveQuizScreenState extends State<RWaveQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  // bool showResetButton = false; // This variable is no longer needed with the new flow
  final int passThreshold = 8;

  // New state variables for feedback, consistent with other quiz screens
  int? _selectedOptionIndex; // Stores the index of the option the user tapped
  bool _isAnswerEvaluated = false; // True when an answer has been picked and evaluated


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
    // Prevent multiple selections for the same question after it's evaluated
    if (_isAnswerEvaluated) {
      return;
    }

    setState(() {
      _selectedOptionIndex = selectedIndex;
      _isAnswerEvaluated = true; // Mark that the answer has been evaluated for this question

      if (selectedIndex == questions[currentQuestionIndex]['answer']) {
        score++;
      }
      // Do NOT immediately go to the next question here.
      // The "Next Question" button will handle the progression.
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
      if (user != null && score >= passThreshold) { // Only store if user passes the threshold
        String uid = user.uid;
        DocumentReference userDoc = FirebaseFirestore.instance.collection('userProgress').doc(uid);
        await userDoc.set({
          'completedTopics.rWave': true
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error storing completion status: $e');
    }
  }

  void _showCompletionDialog() {
    bool passed = score >= passThreshold; // Determine if user passed for the "Mark as Complete" option
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(passed ? 'Quiz Passed!' : 'Quiz Failed'), // Consistent with other quizzes
          content: Text('You scored $score out of ${questions.length}.'), // Display score directly
          actions: [
            if (passed) // Show "Mark as Complete" only if passed
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Pop the dialog
                  Navigator.of(context).pop(); // Pop the quiz screen
                  _storeCompletionStatus();
                },
                child: const Text('Mark as Complete'), // Consistent text for finishing
              )
            else
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Pop the dialog
                  _resetQuiz();
                },
                child: const Text('Retry'), // Consistent text for retrying
              )
          ],
        );
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0; // Reset score
      _selectedOptionIndex = null; // Reset for new quiz
      _isAnswerEvaluated = false; // Reset for new quiz
      // showResetButton = false; // Removed, not used
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
        title: const Text('R Wave Quiz'), // Added const for consistency
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // Ensures title and icons are white
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Score Tracker ---
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
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(color: Colors.white, fontSize: 18),
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
                        backgroundColor: _getOptionButtonColor(index), // Use helper for color
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Optional: add some rounded corners
                        ),
                      ),
                      // Always provide the onPressed callback, the _checkAnswer logic prevents re-evaluation
                      onPressed: () => _checkAnswer(index),
                      child: Text(
                        questions[currentQuestionIndex]['options'][index],
                        style: TextStyle(
                          color: _getOptionButtonTextColor(index), // Use helper for text color
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
