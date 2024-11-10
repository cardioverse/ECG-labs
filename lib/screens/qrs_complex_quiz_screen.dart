import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class QRSComplexQuizScreen extends StatefulWidget {
  @override
  _QRSComplexQuizScreenState createState() => _QRSComplexQuizScreenState();
}

class _QRSComplexQuizScreenState extends State<QRSComplexQuizScreen> {
  final Map<int, String> qrsLabels = {
    1: 'QR',
    2: 'QS',
    3: 'Qr',
    4: 'R',
    5: 'Rs',
    6: 'qR',
    7: 'qRs',
    8: "rR'",
    9: 'rS',
    10: "rsR'",
  };
  final List<int> qrsMorphologies = List.generate(10, (index) => index + 1);
  late List<int> shuffledMorphologies = List.from(qrsMorphologies)..shuffle();
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int countdown = 10;
  Timer? timer;
  List<String> currentOptions = [];

  @override
  void initState() {
    super.initState();
    startTimer();
    currentOptions = getOptions();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    countdown = 10;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          handleAnswer(null);
        }
      });
    });
  }

  void handleAnswer(String? answer) {
    timer?.cancel();
    bool isCorrect = false;
    String correctAnswer = qrsLabels[shuffledMorphologies[currentQuestionIndex]]!;
    if (answer == correctAnswer) {
      setState(() {
        correctAnswers++;
        isCorrect = true;
      });
    } else {
      setState(() {
        wrongAnswers++;
      });
    }
    showAnswerDialog(isCorrect, correctAnswer);
  }

  void showAnswerDialog(bool isCorrect, String correctAnswer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
        content: Text(isCorrect ? 'Good job!' : 'The correct answer was: $correctAnswer'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              goToNextQuestion();
            },
            child: Text('Next Question'),
          ),
        ],
      ),
    );
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < shuffledMorphologies.length - 1) {
      setState(() {
        currentQuestionIndex++;
        currentOptions = getOptions();
        startTimer();
      });
    } else {
      showQuizEndDialog();
    }
  }

  void showQuizEndDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Completed'),
        content: Text('Correct: $correctAnswers, Wrong: $wrongAnswers'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetQuiz();
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      shuffledMorphologies.shuffle();
      currentQuestionIndex = 0;
      correctAnswers = 0;
      wrongAnswers = 0;
      currentOptions = getOptions();
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRS Complex Quiz'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Score pills
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildScorePill('Correct', correctAnswers, Colors.green),
                _buildScorePill('Wrong', wrongAnswers, Colors.red),
                _buildScorePill('Time', countdown, Colors.grey),
              ],
            ),
            SizedBox(height: 20),
            // QRS Image
            Expanded(
              child: Image.asset(
                'assets/images/qrs_quiz/${shuffledMorphologies[currentQuestionIndex]}.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            // Options Grid
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: currentOptions.length,
              itemBuilder: (context, index) {
                String option = currentOptions[index];
                return ElevatedButton(
                  onPressed: () => handleAnswer(option),
                  child: Text(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            // Progress Bar
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / shuffledMorphologies.length,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScorePill(String label, int value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<String> getOptions() {
    List<int> options = List.from(qrsMorphologies);
    options.remove(shuffledMorphologies[currentQuestionIndex]);
    options.shuffle();
    List<String> selectedOptions = [qrsLabels[shuffledMorphologies[currentQuestionIndex]]!];
    selectedOptions.addAll(options.take(3).map((e) => qrsLabels[e]!));
    selectedOptions.shuffle();
    return selectedOptions;
  }
}
