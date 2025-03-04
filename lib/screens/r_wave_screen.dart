import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/r_wave_quiz_screen.dart';

class RWaveScreen extends StatelessWidget {
  const RWaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('R Wave'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // R-Wave Overview Section
          _buildImageWithDescriptionSection(
            'assets/images/r_wave_example.png',
            'The R-wave is the first positive deflection in the QRS complex. '
                'It represents the depolarization of the left and right ventricles. '
                'The height and morphology of the R-wave can provide important clinical information '
                'regarding the heart\'s electrical activity, chamber size, and conduction system abnormalities.',
          ),
          const SizedBox(height: 20),

          // Normal Characteristics Section
          _buildCardSection(
            'Clinical Significance',
            [
              'A normal R-wave progression is seen in the precordial leads of a 12-lead ECG. '
                  'Abnormal R-wave progression may indicate conditions such as:',
              '- Left ventricular hypertrophy (LVH)',
              '- Right ventricular hypertrophy (RVH)',
              '- Myocardial infarction (MI)',
              '- Bundle branch block',
              '- Poor R-wave progression',
            ],
            Colors.green,
          ),
          const SizedBox(height: 20),

          // Common R-Wave Abnormalities Section
          _buildCardSection(
            'Common R-Wave Abnormalities',
            [
              'Absent R-wave in some leads',
              'Tall R-wave in lead V1',
              'Poor R-wave progression across precordial leads',
              'R/S ratio abnormalities',
            ],
            Colors.red,
          ),
          const SizedBox(height: 20),

          // R-Wave in Specific Conditions Section
          _buildCardSection(
            'R-Wave in Specific Conditions',
            [
              'In certain conditions like myocardial infarction (MI), the R-wave may be reduced or '
                  'absent in specific leads depending on the location of the infarct. In hypertrophy, '
                  'the R-wave may be significantly enlarged.',
            ],
            Colors.orange,
          ),
          const SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RWaveQuizScreen()),
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
