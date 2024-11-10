import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/grid_quiz_screen.dart';

class GridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECG Grid Basics'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Introduction text
            SizedBox(height: 16),
            _buildInfoCard(
              context,
              'The ECG grid consists of small and large squares that allow clinicians to measure the timing and amplitude of ECG waveforms. Understanding the grid is essential for accurately interpreting heart rate, rhythm, and other electrical activities of the heart.',
            ),
            SizedBox(height: 16),

            // Swipeable images with PageView
            Container(
              height: 300, // Adjust height as needed
              child: PageView(
                children: [
                  Image.asset(
                    'assets/images/grid_1.png',
                    fit: BoxFit.contain, // Ensures the entire image is shown without cropping
                  ),
                  Image.asset(
                    'assets/images/grid_2.png',
                    fit: BoxFit.contain, // Ensures the entire image is shown without cropping
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Grid System text
            _buildSectionTitle(context, 'The Grid System'),
            _buildInfoCard(
              context,
              'The ECG paper is made up of small squares and larger boxes, which help in measuring time (on the horizontal axis) and voltage (on the vertical axis).',
            ),
            SizedBox(height: 16),

            // Time Measurement text
            _buildSectionTitle(context, 'Time Measurement (Horizontal Axis)'),
            _buildInfoCard(
              context,
              '• Small Squares: Each small square represents 0.04 seconds (40 milliseconds).\n'
                  '• Large Squares: Each large square, which is made up of 5 small squares, represents 0.2 seconds (200 milliseconds).\n'
                  'This helps in determining the duration of various ECG waveforms, such as the PR interval, QRS complex, and QT interval.',
            ),
            SizedBox(height: 16),

            // Voltage Measurement text
            _buildSectionTitle(context, 'Voltage Measurement (Vertical Axis)'),
            _buildInfoCard(
              context,
              '• Small Squares: Each small square represents 0.1 millivolts (mV) of electrical activity.\n'
                  '• Large Squares: Each large square represents 0.5 millivolts (mV).\n'
                  'This helps in determining the amplitude of various waveforms, such as the height of the P-wave or QRS complex.',
            ),
            SizedBox(height: 16),

            // Finished Topic button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GridQuizScreen()),
                );
              },
              child: Text('Finished Topic'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String content) {
    return Card(
      color: Colors.grey[70],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
