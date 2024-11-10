import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'dart:async';

class ArrhythmiaTrainer extends StatefulWidget {
  @override
  _ArrhythmiaTrainerState createState() => _ArrhythmiaTrainerState();
}

class _ArrhythmiaTrainerState extends State<ArrhythmiaTrainer> {
  String mode = 'Relaxed';
  String currentImage = '';
  Map<String, Map<String, String>> ecgInterpretations = {};
  List<String> options = [];
  String correctAnswer = '';
  String interpretation = '';
  bool isLoading = true;
  int correctCount = 0;
  int wrongCount = 0;
  int timeLeft = 30;
  Timer? timer;
  String? selectedAnswer;
  bool showNextButton = false;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    loadInterpretations();
  }

  Future<void> loadInterpretations() async {
    try {
      String data = await rootBundle.loadString('assets/images/arrhythmia_trainer_ecg/ecg_interpretations.txt');
      Map<String, dynamic> jsonData = jsonDecode(data);
      Map<String, Map<String, String>> parsedData = {};

      jsonData.forEach((key, value) {
        parsedData[key] = {
          "name": value["name"],
          "interpretation": value["interpretation"]
        };
      });

      setState(() {
        ecgInterpretations = parsedData;
        loadNextECG();
        if (mode == 'Rapid') {
          startTimer();
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading ECG interpretations: $e')),
      );
    }
  }

  void loadNextECG() {
    if (ecgInterpretations.isNotEmpty) {
      final random = Random();
      List<String> imageKeys = ecgInterpretations.keys.toList();
      currentImage = imageKeys[random.nextInt(imageKeys.length)].trim();

      correctAnswer = ecgInterpretations[currentImage]?['name'] ?? '';
      interpretation = ecgInterpretations[currentImage]?['interpretation'] ?? '';
      generateOptions();
      setState(() {
        isLoading = false;
        selectedAnswer = null;
        showNextButton = false;
        feedbackMessage = '';
      });
    }
  }

  void generateOptions() {
    final random = Random();
    Set<String> optionsSet = {correctAnswer};
    while (optionsSet.length < 4) {
      String randomAnswer = ecgInterpretations.values.elementAt(random.nextInt(ecgInterpretations.length))['name'] ?? '';
      optionsSet.add(randomAnswer);
    }
    options = optionsSet.toList()..shuffle();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          loadNextECG();
        }
      });
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      timeLeft = 30;
      startTimer();
    });
  }

  void checkAnswer(String selectedAnswer) {
    bool isCorrect = selectedAnswer == correctAnswer;

    setState(() {
      this.selectedAnswer = selectedAnswer;
      if (isCorrect) {
        correctCount++;
        feedbackMessage = 'Correct!';
      } else {
        wrongCount++;
        feedbackMessage = 'Incorrect! The correct answer was: ';
      }
      if (mode == 'Relaxed') {
        showDialog(
          context: context,
          barrierDismissible: false,  // Prevent dialog from closing when tapping outside
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(isCorrect ? 'Correct!' : 'Incorrect!'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isCorrect)
                    RichText(
                      text: TextSpan(
                        text: 'The correct answer was: ',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        children: [
                          TextSpan(
                            text: correctAnswer,
                            style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 16),
                  Text(
                    'Interpretation:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: EdgeInsets.zero,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.asset('assets/images/arrhythmia_trainer_ecg/$currentImage'),
                  ),
                  SizedBox(height: 16),
                  ...interpretation.split('. ').map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      '• $point',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    loadNextECG();
                  },
                  child: Text('Next Question'),
                ),
              ],
            );
          },
        );
      }
    });

    if (mode == 'Rapid') {
      Future.delayed(Duration(seconds: 1), () {
        loadNextECG();
        resetTimer();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arrhythmia Trainer'),
        actions: [
          DropdownButton<String>(
            value: mode,
            items: ['Relaxed', 'Rapid'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                mode = newValue ?? 'Relaxed';
                if (mode == 'Rapid') {
                  startTimer();
                } else {
                  timer?.cancel();
                }
              });
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : currentImage.isEmpty
          ? Center(child: Text('No ECG data available'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (mode == 'Rapid')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Timer: $timeLeft', style: TextStyle(fontSize: 20)),
                    Text('Correct: $correctCount', style: TextStyle(fontSize: 20)),
                    Text('Wrong: $wrongCount', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            if (mode == 'Relaxed')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Correct: $correctCount', style: TextStyle(fontSize: 20)),
                    Text('Wrong: $wrongCount', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: InteractiveViewer(
                panEnabled: true,
                boundaryMargin: EdgeInsets.zero,
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.asset('assets/images/arrhythmia_trainer_ecg/$currentImage'),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Select the correct MI:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: mode == 'Rapid' ? 2 : 2,
                childAspectRatio: 1.0,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                Color buttonColor;
                if (selectedAnswer == null) {
                  buttonColor = Colors.blueAccent;
                } else if (options[index] == correctAnswer) {
                  buttonColor = Colors.green;
                } else if (options[index] == selectedAnswer) {
                  buttonColor = Colors.red;
                } else {
                  buttonColor = Colors.blueAccent;
                }

                return Container(
                  height: 50,  // Set the desired height for the button
                  child: InkWell(
                    onTap: selectedAnswer == null ? () => checkAnswer(options[index]) : null,
                    borderRadius: BorderRadius.circular(15),
                    splashColor: Colors.tealAccent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 3, color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          options[index],
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
