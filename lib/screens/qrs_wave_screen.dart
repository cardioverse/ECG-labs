import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/qrs_complex_quiz_screen.dart';
import 'qrs_complex_naming_screen.dart';  // Import the new screen

class QRSWaveScreen extends StatelessWidget {
  const QRSWaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRS Complex'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          const SizedBox(height: 10),
          Image.asset(
            'assets/images/qrs_wave_example.png',  // Add a QRS complex image to the assets folder
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            'The QRS complex represents ventricular depolarization. It includes three waves: Q, R, and S.',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'Normal Duration:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            '0.08 to 0.12 seconds (2-3 small squares).',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'Clinical Significance:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            'Abnormal QRS complexes can indicate conditions such as bundle branch blocks or ventricular hypertrophy.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 20),
          // Clickable text for QRS Complex Naming Convention
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRSComplexNamingScreen()),  // Navigate to naming convention screen
              );
            },
            child: const Text(
              'QRS Complex Naming Convention',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,  // To make it look clickable
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Common QRS Abnormalities"),
          _buildAbnormalityCard(
            context,
            "Left Bundle Branch Block (LBBB)",
            "The QRS complex is widened (> 0.12 seconds) with notching in the R wave in leads I and V6.",
            'assets/images/qrs_lbbb.png',  // Add an LBBB image
          ),
          _buildAbnormalityCard(
            context,
            "Right Bundle Branch Block (RBBB)",
            "The QRS complex shows an RSR' pattern in V1 and V2 with a prolonged QRS duration.",
            'assets/images/qrs_rbbb.png',  // Add an RBBB image
          ),
          _buildSectionTitle("Ventricular Hypertrophy"),
          _buildAbnormalityCard(
            context,
            "Left Ventricular Hypertrophy (LVH)",
            "LVH is characterized by an increased QRS amplitude in the lateral leads (V5/V6) and deep S waves in V1/V2.",
            'assets/images/lvh.png',  // Add an LVH image
          ),
          _buildAbnormalityCard(
            context,
            "Right Ventricular Hypertrophy (RVH)",
            "RVH shows tall R waves in V1/V2 and deep S waves in V5/V6, often with right axis deviation.",
            // TODO: Add rvh image
            // 'assets/images/rvh.png',  // Add an RVH image
          ),

          const SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRSComplexQuizScreen()),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

Widget _buildAbnormalityCard(BuildContext context, String title, String description, [String? imagePath]) {
  return Card(
    color: Colors.black87,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          if (imagePath != null) ...[
            const SizedBox(height: 8),
            Image.asset(imagePath),
          ],
        ],
      ),
    ),
  );
}
}
