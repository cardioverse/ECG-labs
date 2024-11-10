import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/q_wave_quiz_screen.dart';

class QWaveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Q Wave'),
        backgroundColor: Colors.black,  // Consistent app bar color
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [

          // Q-Wave Overview Section
          _buildImageWithDescriptionSection(
              'assets/images/q_wave_example.png',
              'The Q wave is the first negative deflection of the QRS complex, occurring before the R wave. '
                  'It represents the initial depolarization of the interventricular septum and is crucial for understanding cardiac health.'
          ),
          SizedBox(height: 20),

          // Clinical Significance Section
          _buildCardSection(
              'Clinical Significance',
              [
                'Abnormal Q waves can indicate previous myocardial infarction or other underlying heart conditions.',
              ],
              Colors.green  // Use blue for clinical significance
          ),
          SizedBox(height: 20),

          // Common Abnormalities Section
          _buildCardSection(
              'Common Q-Wave Abnormalities',
              [
                '1. Pathological Q waves may suggest an old myocardial infarction.',
                '2. Increased Q wave amplitude can indicate left ventricular hypertrophy or other cardiac issues.',
              ],
              Colors.red  // Use red for abnormalities
          ),
          SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QWaveQuizScreen()),
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
    );
  }

  // Helper Widget for an Image with Description
  Widget _buildImageWithDescriptionSection(String imagePath, String description) {
    return Column(
      children: [
        // Image first
        Image.asset(imagePath, height: 200),
        SizedBox(height: 16),
        // Description next
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  // Helper Widget to build Sections with Important Info in Cards
  Widget _buildCardSection(String title, List<String> details, Color highlightColor) {
    return Card(
      elevation: 4,
      color: Colors.black87, // Dark background for contrast
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: highlightColor,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details.map((detail) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    detail,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
