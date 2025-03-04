import 'package:flutter/material.dart';

class DigitalisToxicityScreen extends StatelessWidget {
  const DigitalisToxicityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digitalis Toxicity'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/Abnormalities/digitalis_toxicity_example.png',
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
              'Digitalis toxicity, also known as digoxin toxicity, occurs when there are elevated levels of digoxin in the body, leading to potentially dangerous effects on the heart. It often presents with a variety of arrhythmias and other ECG abnormalities.',
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
              'Digitalis toxicity occurs due to excessive inhibition of the sodium-potassium ATPase pump, which leads to increased intracellular calcium levels. This can result in enhanced contractility, but also increased automaticity and decreased conduction velocity, leading to a variety of arrhythmias.',
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
              'Digitalis toxicity can present with gastrointestinal symptoms (nausea, vomiting), visual disturbances (yellow-green vision), and various cardiac arrhythmias. Common arrhythmias include atrial tachycardia with block, ventricular ectopy, and even complete heart block. Prompt recognition and treatment are crucial to prevent complications.',
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
            const BulletPoint(text: 'Sagging ST Segment Depression: Often described as a "scooped" appearance, particularly in leads V4-V6.'),
            const BulletPoint(text: 'Atrial Tachycardia with Block: Atrial tachycardia with a variable degree of AV block is a common arrhythmia seen in digitalis toxicity.'),
            const BulletPoint(text: 'Ventricular Ectopy: Premature ventricular contractions (PVCs) and other ventricular arrhythmias may also be seen.'),
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
            const BulletPoint(text: 'ECG Recognition: Practice identifying the characteristic "scooped" ST depression and arrhythmias associated with digitalis toxicity.'),
            const BulletPoint(text: 'Signs and Symptoms: Be aware of the non-cardiac symptoms of toxicity, including visual changes and gastrointestinal symptoms.'),
            const BulletPoint(text: 'Management: Treatment includes discontinuing digoxin, correcting electrolyte imbalances, and, in severe cases, using digoxin-specific antibody fragments.'),
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
