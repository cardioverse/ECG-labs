import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/t_wave_quiz_screen.dart';

class TWaveScreen extends StatelessWidget {
  const TWaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T Wave'),
        backgroundColor: Colors.black,  // Consistent app bar color
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          // T-Wave Overview Section
          _buildImageWithDescriptionSection(
              'assets/images/t_wave_example.png',
              'The T wave represents the repolarization of the ventricles. '
                  'It follows the QRS complex and reflects the recovery phase of the ventricles.'
          ),
          const SizedBox(height: 20),

          // Normal T-Wave Characteristics
          _buildCardSection(
              'Normal Characteristics',
              [
                'The T wave is typically upright in most leads and has a smooth, rounded shape.',
                'Normal amplitude: less than 5 mm in limb leads and less than 10 mm in precordial leads.',
              ],
              Colors.green  // Use green for normal parameters
          ),
          const SizedBox(height: 20),

          // Clinical Significance Section
          _buildCardSection(
              'Clinical Significance',
              [
                'Abnormal T waves can indicate ischemia, electrolyte imbalances (e.g., hyperkalemia), or pericarditis.',
              ],
              Colors.orange  // Use orange for clinical significance
          ),
          const SizedBox(height: 20),

          // Common T-Wave Abnormalities Title
          const Text(
            'Common T-Wave Abnormalities',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),

          // T-Wave Abnormalities Cards
          _buildAbnormalityCard(
              'T-Wave Inversion',
              'Inverted T waves can indicate ischemia or repolarization abnormalities, commonly seen in myocardial ischemia.',
              'assets/images/t_wave_inversion.png',
              Colors.red  // Use red for abnormalities
          ),
          _buildAbnormalityCard(
              'Peaked T Waves',
              'Peaked T waves are often associated with hyperkalemia, reflecting changes in potassium levels affecting the hearts electrical activity.',
              'assets/images/t_wave_peaked.png',
              Colors.red
          ),
          _buildAbnormalityCard(
              'Flat or Biphasic T Waves',
              'These can indicate ischemia, electrolyte imbalances, or other repolarization abnormalities.',
              'assets/images/t_wave_flat.png',
              Colors.red
          ),

          const SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TWaveQuizScreen()),
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
        Image.asset(imagePath, height: 200),
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(fontSize: 18, color: Colors.white, height: 1.5),
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
                color: highlightColor,  // Use highlight color for sections
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

  // Helper Widget to build Image Cards for Abnormalities
  Widget _buildAbnormalityCard(String title, String description, String imagePath, Color highlightColor) {
    return Card(
      elevation: 4,
      color: Colors.black87,  // Dark card background for contrast
      margin: const EdgeInsets.symmetric(vertical: 10),
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
                color: highlightColor,  // Use red for abnormalities
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Image.asset(imagePath, height: 150),
          ],
        ),
      ),
    );
  }
}
