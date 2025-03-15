import 'package:flutter/material.dart';
import 'dart:async';

class CardiacAxisTrainer extends StatefulWidget {
  const CardiacAxisTrainer({super.key});

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
  bool showRestartButton = false;

  Timer? countdownTimer;
  int countdown = 15;

  @override
  void initState() {
    super.initState();
    _showNextImage();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void _showNextImage() {
    setState(() {
      feedbackMessage = '';
      isAnswered = false;
      countdown = 15;
      countdownTimer?.cancel();

      List<String> allImages = [...normalAxisImages, ...rightAxisImages, ...leftAxisImages];
      List<String> availableImages = allImages.where((img) => !usedImages.contains(img)).toList();

      if (availableImages.isEmpty) {
        usedImages.clear();
        availableImages = allImages;
        showRestartButton = true;
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

  void _startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        _checkAnswer('');
      }
    });
  }

  void _checkAnswer(String selectedAnswer) {
    if (!isAnswered) {
      setState(() {
        isAnswered = true;
        questionsAnswered++;

        if (selectedAnswer == correctAnswer) {
          score++;
          feedbackMessage = '✅ Correct!';
        } else {
          wrongAnswers++;
          feedbackMessage = '❌ Wrong! Correct: $correctAnswer';
        }
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (!showRestartButton) _showNextImage();
      });
    }
  }

  void _resetQuiz() {
    countdownTimer?.cancel();
    setState(() {
      score = 0;
      wrongAnswers = 0;
      questionsAnswered = 0;
      usedImages.clear();
      countdown = 15;
      showRestartButton = false;
      currentImage = '';
    });
    _showNextImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardiac Axis Trainer'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(currentImage, height: 300, fit: BoxFit.contain),
              ),
            const SizedBox(height: 20),
            Text(
              '⏳ Time Left: $countdown s',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: countdown > 5 ? Colors.white : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(feedbackMessage, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildAnswerButton('Left Axis Deviation', Colors.blue),
                _buildAnswerButton('Normal Axis', Colors.green),
                _buildAnswerButton('Right Axis Deviation', Colors.orange),
              ],
            ),
            if (showRestartButton)
              ElevatedButton(
                onPressed: _resetQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Restart', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButton(String answer, Color color) {
    return ElevatedButton(
      onPressed: () => _checkAnswer(answer),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(answer, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}