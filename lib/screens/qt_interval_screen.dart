import 'package:flutter/material.dart';
import 'how_to_measure_qt_interval_screen.dart';  // Import the new screen
import 'package:ecg_trainer/topics_completion_tracker/qt_interval_quiz_screen.dart';  // Import the quiz screen

class QTIntervalScreen extends StatelessWidget {
  const QTIntervalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QT Interval'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // QT Interval Image
            Image.asset(
              'assets/images/qt_interval_example.png',
              height: 200.0,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width, // Ensure image fits the screen width
            ),
            const SizedBox(height: 16.0),

            // Introduction Text
            const Text(
              'The QT interval represents the time taken for the ventricles to depolarize and then repolarize. It begins at the start of the QRS complex '
                  'and ends at the end of the T wave. Abnormal QT intervals can indicate significant cardiac conditions such as Long QT Syndrome.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Key Points or Details
            const Text(
              'Key Points:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Change color to match other headings
              ),
            ),
            const SizedBox(height: 8.0),

            // List of Key Points
            const Text(
              '• The QT interval should be measured in Lead II.\n'
                  '• A normal QT interval duration is typically between 350-450 milliseconds.\n'
                  '• QT prolongation can predispose to life-threatening arrhythmias like Torsades de Pointes.\n'
                  '• Short QT intervals can also indicate underlying conditions.',
              style: TextStyle(fontSize: 16.0, color: Colors.white), // Set text color
            ),
            const SizedBox(height: 16.0),

            // How to Measure QT Interval Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HowToMeasureQTIntervalScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button color to orange
              ),
              child: const Text('How to Measure'),
            ),
            const SizedBox(height: 16.0),

            // Conclusion Text
            const Text(
              'Concluding remarks about the QT interval could be added here, explaining its relevance to various cardiac pathologies and how it '
                  'can be a useful indicator for assessing the risk of arrhythmias.',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),

            // Completed Topic Button for Quiz
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QTIntervalQuizScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set button color to green
              ),
              child: const Text('Completed Topic'),
            ),
          ],
        ),
      ),
    );
  }
}
