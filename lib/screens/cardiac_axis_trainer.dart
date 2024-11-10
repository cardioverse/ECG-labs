import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class CardiacAxisTrainer extends StatefulWidget {
  @override
  _CardiacAxisTrainerState createState() => _CardiacAxisTrainerState();
}

class _CardiacAxisTrainerState extends State<CardiacAxisTrainer> {
  List<String> normalAxisImages = [
    'assets/images/axis_quiz/normalaxisdeviation1.png',
    'assets/images/axis_quiz/normalaxisdeviation2.png',
    'assets/images/axis_quiz/normalaxisdeviation3.png',
    'assets/images/axis_quiz/normalaxisdeviation4.png',
    'assets/images/axis_quiz/normalaxisdeviation5.png'
  ];

  List<String> rightAxisImages = [
    'assets/images/axis_quiz/rightaxisdeviation1.png',
    'assets/images/axis_quiz/rightaxisdeviation2.png',
    'assets/images/axis_quiz/rightaxisdeviation3.png'
  ];

  List<String> leftAxisImages = [
    'assets/images/axis_quiz/leftaxisdeviation1.png',
    'assets/images/axis_quiz/leftaxisdeviation2.png',
    'assets/images/axis_quiz/leftaxisdeviation3.png',
  ];

  List<String> usedImages = [];
  String currentImage = '';
  String correctAnswer = '';
  int score = 0;
  int wrongAnswers = 0;
  int questionsAnswered = 0;
  String feedbackMessage = '';
  bool isAnswered = false;
  bool showNextButton = false;
  bool isTimerRunning = false;
  bool showRestartButton = false;

  Timer? _timer;
  Timer? countdownTimer;
  int _elapsedTime = 0;
  int countdown = 15;

  @override
  void initState() {
    super.initState();
    _showNextImage();
  }

  @override
  void dispose() {
    _timer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  void _showNextImage() {
    setState(() {
      feedbackMessage = '';
      isAnswered = false;
      showNextButton = false;
      countdown = 15;
      countdownTimer?.cancel();

      List<String> allImages = [...normalAxisImages, ...rightAxisImages, ...leftAxisImages];
      List<String> availableImages = allImages.where((img) => !usedImages.contains(img)).toList();

      if (availableImages.isEmpty) {
        usedImages.clear();
        availableImages = allImages;
      }

      availableImages.shuffle();
      currentImage = availableImages.first;
      usedImages.add(currentImage);

      correctAnswer = normalAxisImages.contains(currentImage)
          ? 'Normal Axis'
          : rightAxisImages.contains(currentImage)
          ? 'Right Axis Deviation'
          : 'Left Axis Deviation';

      _startCountdown();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
    setState(() {
      isTimerRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  void _startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        _checkAnswer(''); // Handle time's up scenario as a wrong answer
      }
    });
  }

  void _checkAnswer(String selectedAnswer) {
    if (!isAnswered) {
      setState(() {
        isAnswered = true;
        questionsAnswered++;

        if (questionsAnswered == 1 && !isTimerRunning) {
          _startTimer(); // Start the timer on the first answer
        }

        if (selectedAnswer == correctAnswer) {
          score++;
          _showFeedbackMessage('Correct!');
        } else {
          wrongAnswers++;
          _showFeedbackMessage('Wrong! The correct answer was $correctAnswer');
          _stopTimer(); // Stop the timer on wrong answer
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              showRestartButton = true;
            });
          });
        }
        showNextButton = true;
      });

      // Automatically show the next image after 2 seconds if no restart button is needed
      if (!showRestartButton) {
        Future.delayed(Duration(seconds: 2), () {
          if (showNextButton) _showNextImage();
        });
      }
    }
  }

  void _showFeedbackMessage(String message) {
    setState(() {
      feedbackMessage = message;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        feedbackMessage = '';
      });
    });
  }

  void _resetQuiz() {
    _stopTimer(); // Stop the timer when resetting the quiz
    countdownTimer?.cancel(); // Stop the countdown timer
    setState(() {
      score = 0;
      wrongAnswers = 0;
      questionsAnswered = 0;
      usedImages.clear();
      _elapsedTime = 0; // Reset the elapsed time
      countdown = 15; // Reset the countdown
      showRestartButton = false; // Hide Restart button on quiz reset
      currentImage = ''; // Clear current image
    });
    _showNextImage(); // Show the next image (starts the quiz)
    // Don't start the timer here
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cardiac Axis Trainer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentImage.isNotEmpty)
              Container(
                width: screenWidth,
                height: 380,
                child: Image.asset(
                  currentImage,
                  fit: BoxFit.contain,
                ),
              ),
            SizedBox(height: 20),

            // Timer display
            Text(
              'Total Time: $_elapsedTime seconds',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Countdown timer display
            Text(
              'Time Left: $countdown seconds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: countdown > 5 ? Colors.black : Colors.red),
            ),
            SizedBox(height: 20),

            // Answer buttons
            if (!showRestartButton)
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  _buildAnswerButton('Left Axis Deviation', Colors.blue),
                  _buildAnswerButton('Normal Axis', Colors.green),
                  _buildAnswerButton('Right Axis Deviation', Colors.orange),
                ],
              ),
            SizedBox(height: 20),

            // Feedback message
            Text(
              feedbackMessage,
              style: TextStyle(
                fontSize: 18,
                color: feedbackMessage == 'Correct!' ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20),

            // Restart button
            if (showRestartButton)
              AnimatedOpacity(
                opacity: showRestartButton ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: ElevatedButton(
                  onPressed: _resetQuiz,
                  child: Text('Restart'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            SizedBox(height: 20),

            // Score display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildScoreCard('Correct', score, Colors.green, Colors.white), // Set text color to white
                SizedBox(width: 80),
                _buildScoreCard('Wrong', wrongAnswers, Colors.red, Colors.white), // Set text color to white
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper to create an answer button with consistent style
  Widget _buildAnswerButton(String answer, Color color) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.3,
      height: screenWidth * 0.3,
      child: ElevatedButton(
        onPressed: () => _checkAnswer(answer),
        child: Text(
          answer,
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          shadowColor: Colors.black54,
          elevation: 6,
        ),
      ),
    );
  }

  // Helper to build a score card
  Widget _buildScoreCard(String label, int value, MaterialColor color, Color textColor) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: color.shade800,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 20.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, color: textColor), // Use the passed textColor
            ),
            SizedBox(height: 10),
            Text(
              '$value',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor), // Use the passed textColor
            ),
          ],
        ),
      ),
    );
  }
}
