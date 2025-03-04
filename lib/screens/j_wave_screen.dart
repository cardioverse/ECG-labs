import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/j_wave_quiz_screen.dart';

class JWaveScreen extends StatelessWidget {
  const JWaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('J Wave'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // J-Wave Overview Section
          _buildImageWithDescriptionSection(
            'assets/images/j_wave_example.png',
            'The J-wave, also known as the Osborn wave, is a positive deflection occurring immediately after the QRS complex '
                'and before the T-wave. It is often seen at the junction between the QRS complex and the ST segment, typically in leads V2-V5.',
          ),
          const SizedBox(height: 20),

          // Clinical Significance Section
          _buildCardSection(
            'Clinical Significance',
            [
              'J-waves are most commonly associated with hypothermia but can also be seen in patients with hypercalcemia, '
                  'early repolarization, and Brugada syndrome. In hypothermia, the amplitude of the J-wave increases as body temperature decreases.',
            ],
            Colors.green,
          ),
          const SizedBox(height: 20),

          // Common Abnormalities Section
          _buildCardSection(
            'Common J-Wave Abnormalities',
            [
              '1. Prominent J-waves are seen in severe hypothermia (body temperature < 32°C).',
              '2. Early repolarization syndrome, commonly seen in young, healthy individuals, can present with J-waves.',
              '3. J-waves are also a feature in some patients with Brugada syndrome, a condition linked to sudden cardiac death.',
            ],
            Colors.red,
          ),
          const SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JWaveQuizScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text('Finished Topic'),
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
        const SizedBox(height: 16),
        // Description next
        Text(
            description,
            style: const TextStyle(fontSize: 18, color: Colors.white, height: 1.5),
            textAlign: TextAlign.left
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
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details.map((detail) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    detail,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
