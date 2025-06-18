import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PRIntervalQuizScreen extends StatefulWidget {
  const PRIntervalQuizScreen({super.key}); // Added const constructor for consistency

  @override
  _PRIntervalQuizScreenState createState() => _PRIntervalQuizScreenState();
}

class _PRIntervalQuizScreenState extends State<PRIntervalQuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  final int passThreshold = 8;

  // New state variables for feedback, consistent with other quiz screens
  int? _selectedOptionIndex; // Stores the index of the option the user tapped
  bool _isAnswerEvaluated = false; // True when an answer has been picked and evaluated


  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What does the PR interval represent?',
      'options': [
        'The time from ventricular depolarization to repolarization',
        'The time from atrial depolarization to ventricular depolarization',
        'The duration of the QRS complex',
        'The time from ventricular depolarization to atrial repolarization'
      ],
      'answer': 1,
    },
    {
      'question': 'What is the normal range for the PR interval?',
      'options': [
        '0.08 to 0.12 seconds',
        '0.12 to 0.20 seconds',
        '0.20 to 0.30 seconds',
        '0.30 to 0.40 seconds'
      ],
      'answer': 1,
    },
    {
      'question': 'What does a prolonged PR interval indicate?',
      'options': [
        'Right ventricular hypertrophy',
        'First-degree AV block',
        'Wolff-Parkinson-White syndrome',
        'Atrial fibrillation'
      ],
      'answer': 1,
    },
    {
      'question': 'Which condition is associated with a shortened PR interval?',
      'options': [
        'First-degree AV block',
        'Right bundle branch block',
        'Pre-excitation syndromes',
        'Second-degree AV block'
      ],
      'answer': 2,
    },
    {
      'question': 'What abnormality can a variable PR interval suggest?',
      'options': [
        'Atrial fibrillation',
        'Second-degree AV block',
        'Myocardial infarction',
        'Sinus tachycardia'
      ],
      'answer': 1,
    },
    {
      'question': 'Which electrolyte imbalance can prolong the PR interval?',
      'options': [
        'Hypokalemia',
        'Hypercalcemia',
        'Hyperkalemia',
        'Hyponatremia'
      ],
      'answer': 2,
    },
    {
      'question': 'A progressively lengthening PR interval before a dropped beat is characteristic of?',
      'options': [
        'Mobitz Type I (Wenckebach)',
        'Mobitz Type II',
        'Complete heart block',
        'Atrial flutter'
      ],
      'answer': 0,
    },
    {
      'question': 'What does a PR interval shorter than 0.12 seconds typically indicate?',
      'options': [
        'Atrial fibrillation',
        'Pre-excitation syndrome (e.g., WPW)',
        'Sinus arrhythmia',
        'Right bundle branch block'
      ],
      'answer': 1,
    },
    {
      'question': 'Which drug is known to prolong the PR interval?',
      'options': [
        'Digoxin',
        'Aspirin',
        'Ibuprofen',
        'Lisinopril'
      ],
      'answer': 0,
    },
    {
      'question': 'What heart block can result in complete dissociation between P waves and QRS complexes?',
      'options': [
        'First-degree AV block',
        'Mobitz Type I',
        'Mobitz Type II',
        'Third-degree (complete) heart block'
      ],
      'answer': 3,
    },
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
          'completedTopics.prInterval': true,
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
          title: Text(passed ? 'Quiz Passed!' : 'Quiz Failed'), // Consistent with P Wave Quiz
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
        title: const Text('PR Interval Quiz'),
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
