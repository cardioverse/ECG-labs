import 'package:flutter/material.dart';

class AnteriorMIScreen extends StatelessWidget {
  const AnteriorMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anterior MI'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 16),

              // Overview of Anterior STEMI
              const Text(
                'Anterior ST Elevation MI usually results from occlusion of the left anterior descending artery (LAD). '
                    'Anterior myocardial infarction carries the poorest prognosis of all infarct locations due to the larger area of infarcted myocardium.',
                style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              ),
              const SizedBox(height: 24),

              // Prediction of the Site of LAD Occlusion
              _buildSectionHeader('Prediction of the Site of LAD Occlusion', Colors.red.shade500),
              const Text(
                'The site of LAD occlusion (proximal versus distal) predicts both infarct size and prognosis. '
                    'Proximal LAD / LMCA occlusion has a significantly worse prognosis due to larger infarct territory size and more severe haemodynamic disturbance. '
                    'The site of occlusion can be inferred from the pattern of ST changes in leads corresponding to the two most proximal branches of the LAD: '
                    'the first septal branch (S1) and the first diagonal branch (D1).',
                style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              ),
              const SizedBox(height: 24),

              // Territories Section
              _buildSectionHeader('Territories', Colors.green),
              _buildBulletPoint(
                'S1 supplies the basal part of the interventricular septum, including the bundle branches (corresponding to leads aVR and V1).',
              ),
              _buildBulletPoint(
                'D1 supplies the high lateral region of the heart (leads I and aVL).',
              ),
              const SizedBox(height: 16),

              // Occlusion Proximal to S1
              _buildSectionHeader('Occlusion Proximal to S1', Colors.teal),
              const Text(
                'Signs of basal septal involvement:',
                style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              ),
              _buildBulletPoint('ST elevation in aVR.'),
              _buildBulletPoint('ST elevation in V1 > 2.5 mm.'),
              _buildBulletPoint('Complete RBBB.'),
              _buildBulletPoint('ST depression in V5.'),
              const SizedBox(height: 24),

              // Occlusion Proximal to D1
              _buildSectionHeader('Occlusion Proximal to D1', Colors.teal),
              const Text(
                'Signs of high lateral involvement:',
                style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
              ),
              _buildBulletPoint('ST elevation / Q-wave formation in aVL and I.'),
              _buildBulletPoint('ST depression ≥ 1 mm in II, III, or aVF (reciprocal to STE in aVL).'),
              const SizedBox(height: 24),

              // ECG Display Section
              _buildSectionHeader('ECG Example - Hyperacute Anterior STEMI', Colors.amber),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/images/MI/HyperacuteAnteriorSTEMI.png',
                  height: 250,
                ),
              ),
              const SizedBox(height: 16),

              // ECG Description (Now Broken into Points)
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

  // ECG Description with bullet points
  Widget _buildECGDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 12),
        _buildBulletPoint('There are hyperacute T-waves in V2-6 (most marked in V2 and V3) with loss of R wave height.'),
        _buildBulletPoint('Normal sinus rhythm with 1st degree AV block.'),
        _buildBulletPoint('Premature atrial complexes (PACs), particularly beat 4 on the rhythm strip.'),
        _buildBulletPoint(
          'Multifocal ventricular ectopy (PVCs of two different types), indicating an “irritable” myocardium at risk of ventricular fibrillation.',
        ),
      ],
    );
  }
}
