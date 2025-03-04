import 'package:flutter/material.dart';

class InferiorMIScreen extends StatelessWidget {
  const InferiorMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inferior MI'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section

              const SizedBox(height: 16),

              // General information about Inferior STEMI
              const Text(
                'Inferior STEMI can result from occlusion of any of the three main coronary arteries:',
                style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              ),
              const SizedBox(height: 16),

              // Culprit Arteries and their involvement
              _buildBulletPoint('Dominant right coronary artery (RCA) in 80% of cases.'),
              _buildBulletPoint('Dominant left circumflex artery (LCx) in 18%.'),
              _buildBulletPoint(
                'Occasionally, a “type III” or “wraparound” left anterior descending artery (LAD), '
                    'producing the unusual pattern of concomitant inferior and anterior ST elevation.',
              ),
              const SizedBox(height: 24),

              // RCA Occlusion Section
              _buildSectionHeader('RCA Occlusion', Colors.blueAccent),
              const Text(
                'RCA occlusion is suggested by:',
                style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              ),
              _buildBulletPoint('ST elevation in lead III > lead II.'),
              _buildBulletPoint('Presence of reciprocal ST depression in lead I.'),
              _buildBulletPoint('Signs of right ventricular infarction: STE in V1 and V4R.'),
              const SizedBox(height: 24),

              // Circumflex Occlusion Section
              _buildSectionHeader('Circumflex Occlusion', Colors.green),
              const Text(
                'Circumflex occlusion is suggested by:',
                style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              ),
              _buildBulletPoint('ST elevation in lead II = lead III.'),
              _buildBulletPoint('Absence of reciprocal ST depression in lead I.'),
              _buildBulletPoint('Signs of lateral infarction: ST elevation in the lateral leads I and aVL or V5-6.'),
              const SizedBox(height: 24),

              // ECG Example Section
              _buildSectionHeader('ECG Example - Early Inferior STEMI', Colors.amber),
              const SizedBox(height: 16),

              // ECG Image Display
              Center(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/MI/EarlyinferiorSTEMI.png', // Path to the ECG image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ECG Description
              _buildECGDescription(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section headers with specific colors
  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  // Helper method to build bullet points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // ECG description for Early Inferior STEMI in bullet points
  Widget _buildECGDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ECG Description:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint('Hyperacute (peaked) T waves in II, III, and aVF with relative loss of R wave height.'),
              _buildBulletPoint('Early ST elevation and Q-wave formation in lead III.'),
              _buildBulletPoint('Reciprocal ST depression and T wave inversion in aVL.'),
              _buildBulletPoint('ST elevation in lead III > lead II suggests an RCA occlusion.'),
              _buildBulletPoint('Subtle ST elevation in V4R, consistent with an RCA occlusion.'),
            ],
          ),
        ),
      ],
    );
  }
}
