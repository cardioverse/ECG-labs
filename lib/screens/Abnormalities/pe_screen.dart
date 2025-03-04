import 'package:flutter/material.dart';

class PEScreen extends StatelessWidget {
  const PEScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulmonary Embolism (PE)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/Abnormalities/pe_example.png',
                height: 200.0,
              ),
            ),
            const SizedBox(height: 16.0),

            // Overview Section
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Pulmonary Embolism (PE) occurs when a blood clot, typically from the deep veins of the legs (deep vein thrombosis), travels to the lungs and obstructs the pulmonary arteries. This can lead to decreased oxygenation and potentially life-threatening cardiovascular collapse.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Pathophysiology Section
            const Text(
              'Pathophysiology',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'PE occurs when a thrombus, usually originating in the deep veins of the legs, embolizes to the pulmonary vasculature. This results in obstruction of blood flow to the lungs, increased pulmonary vascular resistance, and impaired gas exchange, which can lead to right ventricular failure and shock if untreated.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Clinical Significance Section
            const Text(
              'Clinical Significance',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'PE is a medical emergency that can lead to sudden death if not promptly diagnosed and treated. Symptoms include shortness of breath, chest pain, tachycardia, and, in severe cases, hypotension and collapse. Treatment involves anticoagulation, thrombolysis, or surgical embolectomy in severe cases.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // ECG Features Section
            const Text(
              'ECG Features',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const BulletPoint(text: 'S1Q3T3 Pattern: Prominent S wave in lead I, Q wave in lead III, and inverted T wave in lead III.'),
            const BulletPoint(text: 'Sinus Tachycardia: The most common ECG finding in PE, reflecting the bodys response to hypoxia and stress.'),
            const BulletPoint(text: 'Right Bundle Branch Block: A partial or complete RBBB may also be seen in the context of right ventricular strain.'),
            const SizedBox(height: 16.0),

            // Study Pointers Section
            const Text(
              'Pointers for Study',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const BulletPoint(text: 'ECG Recognition: Practice identifying the S1Q3T3 pattern and other signs of right heart strain.'),
            const BulletPoint(text: 'Clinical Presentation: Be aware of the symptoms of PE, such as sudden onset dyspnea, pleuritic chest pain, and tachycardia.'),
            const BulletPoint(text: 'Management: Understand that treatment typically involves anticoagulation, with thrombolysis reserved for hemodynamically unstable patients.'),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
