import 'package:flutter/material.dart';

class PosteriorMIScreen extends StatelessWidget {
  const PosteriorMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posterior MI'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header

              const SizedBox(height: 16),

              // Brief Overview of Posterior MI
              const Text(
                'Posterior MI Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'A posterior MI occurs when the posterior wall of the left ventricle is affected, typically due to occlusion of the posterior descending artery (PDA), a branch of the RCA or LCx. '
                    'Because the posterior wall is not directly visualized by standard ECG leads, a posterior MI is often detected through reciprocal changes in the anterior leads.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 16),

              // ECG Image and Description
              const Text(
                'ECG Example: Posterior MI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Image.asset(
                  'assets/images/MI/Posteriormi.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'ECG Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• ST depression in V2-3.\n'
                    '• Tall, broad R waves (> 30ms) in V2-3.\n'
                    '• Dominant R wave (R/S ratio > 1) in V2.\n'
                    '• Upright terminal portions of the T waves in V2-3.\n'
                    '• The ECG changes extend out as far as V4, which may reflect superior-medial misplacement of the V4 electrode from its usual position.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 16),

              // Clinical Significance of Posterior MI
              const Text(
                'Clinical Significance of Posterior MI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Posterior MI is often associated with inferior or lateral infarctions and may be subtle to detect on a standard 12-lead ECG. '
                    'ST depression in the anterior leads (V1-3) is commonly seen as a reciprocal change. '
                    'The presence of a dominant R wave in V2 suggests the posterior involvement of the left ventricle.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
