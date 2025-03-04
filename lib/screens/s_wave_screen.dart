import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/s_wave_quiz_screen.dart';

class SWaveScreen extends StatelessWidget {
  const SWaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S Wave'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // S-Wave Overview Section
          _buildImageWithDescriptionSection(
            null,
            'The S-wave is the first negative deflection following the R-wave in the QRS complex. '
                'It represents the depolarization of the basal portions of the ventricles.',
          ),
          const SizedBox(height: 20),

          // Clinical Significance Section
          _buildCardSection(
            'Clinical Significance',
            [
              'The S-wave is important in assessing the electrical axis of the heart and may vary in amplitude depending on the lead. '
                  'A prominent S-wave in certain leads can suggest ventricular hypertrophy or a shift in the heart\'s electrical axis.',
            ],
            Colors.green,
          ),
          const SizedBox(height: 20),

          // Common Abnormalities Section
          _buildCardSection(
            'Common S-Wave Abnormalities',
            [
              '1. An increased S-wave in leads V1-V2 can suggest right ventricular hypertrophy (RVH).',
              '2. A decreased S-wave may be seen in cases of left ventricular hypertrophy (LVH).',
              '3. A deep S-wave in leads V5-V6 is a key finding in right bundle branch block (RBBB).',
            ],
            Colors.red,
          ),
          const SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SWaveQuizScreen()),
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
  Widget _buildImageWithDescriptionSection(String? imagePath, String description) {
    return Column(
      children: [
        // Image first (only if available)
        if (imagePath != null) Image.asset(imagePath, height: 200),
        const SizedBox(height: 16),
        // Description next
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
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
