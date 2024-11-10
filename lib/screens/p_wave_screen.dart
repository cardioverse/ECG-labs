import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/p_wave_quiz_screen.dart';

class PWaveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('P-Wave'),
        backgroundColor: Colors.black, // Consistent with RWaveScreen
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [

          // Section 1: P-Wave Overview
          _buildImageWithDescriptionSection(
              'assets/images/p_wave_example.png',
              'The P-wave represents atrial depolarization, which triggers the atria to contract. '
                  'It’s usually upright in leads I, II, and V2-V6, and is the first deflection in the ECG waveform.'
          ),
          SizedBox(height: 20),

          // Section 2: Normal P-Wave Parameters
          _buildCardSection(
            'Normal Parameters',
            [
              'Duration: 0.08-0.12 seconds (2-3 small squares).',
              'Amplitude: Less than 2.5 mm.',
              'Shape: Smooth and rounded.'
            ],
            Colors.green,  // Use green for normal parameters
          ),
          SizedBox(height: 20),

          // Section 3: Abnormal P-Waves
          Text(
            'Abnormal P-Waves',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),

          _buildCardWithImage(
            'P Pulmonale',
            'Large, peaked P-waves that indicate right atrial enlargement.',
            'assets/images/p_pulmonale_example.png',
            Colors.red,  // Use red for abnormalities
          ),
          _buildCardWithImage(
            'P Mitrale',
            'Notched or wide P-wave suggesting left atrial enlargement.',
            'assets/images/p_mitrale_example.png',
            Colors.red,
          ),
          _buildCardWithImage(
            'Inverted P-Waves',
            'Occurs when the atrial impulse originates outside the sinoatrial (SA) node.',
            'assets/images/inverted_p_wave_example.png',
            Colors.red,
          ),

          SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PWaveQuizScreen()),
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
        Image.asset(imagePath, height: 200),
        SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(fontSize: 18, color: Colors.white, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Helper Widget to build Sections with Important Info in Cards
  Widget _buildCardSection(String title, List<String> details, Color highlightColor) {
    return Card(
      elevation: 4,
      color: Colors.black87,  // Dark background for contrast
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
                color: highlightColor,  // Use color for emphasis
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

  // Helper Widget to build Image Cards for Abnormalities
  Widget _buildCardWithImage(String title, String description, String imagePath, Color highlightColor) {
    return Card(
      elevation: 4,
      color: Colors.black87,  // Dark card background for contrast
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: highlightColor,  // Use highlight color for abnormalities
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10),
            Image.asset(imagePath, height: 150),
          ],
        ),
      ),
    );
  }
}
