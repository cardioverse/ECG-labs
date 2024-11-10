import 'dart:async';
import 'dart:math'; // Import to use Random
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizScreen extends StatefulWidget {
  final String difficulty;

  QuizScreen({required this.difficulty});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _correctCount = 0;
  int _wrongCount = 0;
  bool _isQuizComplete = false;
  bool _isRelaxedMode = false;
  bool _showExplanation = false;
  String? _feedbackMessage;
  int _timeLeft = 30;
  Timer? _timer;

  List<String> _ecgImages = [
    'assets/images/arrhythmia_trainer_ecg/beginner/MI(2).jpg',
    'assets/images/arrhythmia_trainer_ecg/beginner/MI(4).jpg',
    'assets/images/arrhythmia_trainer_ecg/beginner/MI(5).jpg',
    'assets/images/arrhythmia_trainer_ecg/beginner/MI(6).jpg',
    'assets/images/arrhythmia_trainer_ecg/beginner/MI(9).jpg',
    'assets/images/arrhythmia_trainer_ecg/beginner/MI(10).jpg',
  ];

  List<String> _correctAnswers = []; // Interpretations.
  List<String> _diagnosisNames = []; // Diagnosis names.
  List<int> _randomizedQuestionIndices = []; // List of randomized indices.
  Random _random = Random();

  String? _selectedAnswer;


  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  void _initializeQuiz() async {
    // Load the interpretations from a text file
    String data = await rootBundle.loadString('assets/images/arrhythmia_trainer_ecg/beginner/ecg_interpretations.txt');
    List<String> lines = data.split('\n');

    String? currentImage;
    String? currentDiagnosis;
    StringBuffer? currentInterpretation;

    for (var line in lines) {
      line = line.trim();
      if (line.startsWith('"') && line.endsWith(':')) {
        if (currentImage != null && currentInterpretation != null) {
          _correctAnswers.add(currentInterpretation.toString().trim());
          _diagnosisNames.add(currentDiagnosis!);
        }
        currentImage = line.substring(1, line.length - 1);
        currentDiagnosis = "";
        currentInterpretation = StringBuffer();
      } else if (line.startsWith('-') && currentImage != null) {
        currentDiagnosis = line.substring(2).trim();
      } else if (currentImage != null) {
        if (line.isNotEmpty) {
          currentInterpretation?.write(line + '\n');
        } else {
          if (currentInterpretation != null && currentInterpretation.isNotEmpty) {
            _correctAnswers.add(currentInterpretation.toString().trim());
            _diagnosisNames.add(currentDiagnosis!);
          }
          currentImage = null;
          currentDiagnosis = null;
          currentInterpretation = null;
        }
      }
    }

    if (currentImage != null && currentInterpretation != null && currentInterpretation.isNotEmpty) {
      _correctAnswers.add(currentInterpretation.toString().trim());
      _diagnosisNames.add(currentDiagnosis!);
    }

    // Initialize randomized question indices
    _randomizedQuestionIndices = List.generate(_ecgImages.length, (index) => index);
    _randomizedQuestionIndices.shuffle(); // Shuffle the order of the questions

    setState(() {
      if (!_isRelaxedMode) {
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          _isQuizComplete = true;
        }
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _timeLeft = 30;
      _startTimer();
    });
  }

  void _checkAnswer(String selectedAnswer) {
    bool isCorrect = selectedAnswer == _diagnosisNames[_randomizedQuestionIndices[_currentQuestionIndex]];

    setState(() {
      _feedbackMessage = isCorrect ? 'Correct!' : 'Wrong!';
      if (isCorrect) {
        _correctCount++;
      } else {
        _wrongCount++;
      }
      _showExplanation = true;

      if (!_isRelaxedMode) {
        Future.delayed(Duration(seconds: 1), () {
          _nextQuestion();
        });
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _ecgImages.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showExplanation = false;
        _feedbackMessage = null;

        // Shuffle diagnoses for the next question
        _diagnosisNames.shuffle();

        if (!_isRelaxedMode) {
          _resetTimer();
        }
      });
    } else {
      setState(() {
        _isQuizComplete = true;
      });
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - ${widget.difficulty} Difficulty'),
        actions: [
          Switch(
            value: _isRelaxedMode,
            onChanged: (value) {
              setState(() {
                _isRelaxedMode = value;
                if (!_isRelaxedMode) {
                  _startTimer();
                } else {
                  _timer?.cancel();
                }
              });
            },
          ),
          Text(_isRelaxedMode ? 'Relaxed' : 'Rapid'),
          SizedBox(width: 16),
        ],
      ),
      body: _isQuizComplete
          ? Center(
        child: Text('Quiz Complete! Correct: $_correctCount, Wrong: $_wrongCount'),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!_isRelaxedMode)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Timer: $_timeLeft', style: TextStyle(fontSize: 20)),
                  Text('Correct: $_correctCount', style: TextStyle(fontSize: 20)),
                  Text('Wrong: $_wrongCount', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.zero,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.asset(
                _ecgImages[_randomizedQuestionIndices[_currentQuestionIndex]], // Show random image
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10, // Reduced spacing
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(16.0),
              children: [
                for (var diagnosis in _diagnosisNames)
                  _buildCustomOptionButton(diagnosis),
              ],
            ),
          ),

          if (_feedbackMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _feedbackMessage!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          if (_showExplanation && _isRelaxedMode)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Explanation: ${_correctAnswers[_randomizedQuestionIndices[_currentQuestionIndex]]}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          if (_showExplanation && _isRelaxedMode)
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Text('Next Question'),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomOptionButton(String optionText) {
    return InkWell(
      onTap: () => _checkAnswer(optionText),
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.tealAccent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 3, color: Colors.white),
        ),
        child: Center(
          child: Text(
            optionText,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}