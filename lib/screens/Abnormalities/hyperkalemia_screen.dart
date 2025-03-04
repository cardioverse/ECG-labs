import 'package:flutter/material.dart';

class HyperkalemiaScreen extends StatelessWidget {
  const HyperkalemiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hyperkalemia'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/Abnormalities/hyperkalemia_example.png',
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
              'Hyperkalemia refers to elevated levels of potassium in the blood, which can have significant effects on cardiac conduction. Severe hyperkalemia can lead to life-threatening arrhythmias and requires urgent treatment.',
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
              'Hyperkalemia affects cardiac cell membrane potential, reducing the resting membrane potential and impairing conduction. This can lead to a range of ECG changes, including peaked T waves, widening of the QRS complex, and, in severe cases, sine wave patterns and asystole.',
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
              'Hyperkalemia can cause symptoms such as muscle weakness, palpitations, and, in severe cases, cardiac arrest. Prompt recognition and treatment are crucial to prevent serious complications. Treatment options include calcium gluconate, insulin with glucose, and potassium-binding resins.',
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
            const BulletPoint(text: 'Peaked T Waves: T waves become tall, narrow, and peaked, especially in the precordial leads.'),
            const BulletPoint(text: 'Widened QRS Complex: As potassium levels increase, the QRS complex may widen, indicating delayed ventricular conduction.'),
            const BulletPoint(text: 'Sine Wave Pattern: In severe hyperkalemia, the P wave may disappear, and the QRS complex and T wave merge into a sine wave pattern.'),
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
            const BulletPoint(text: 'ECG Recognition: Practice identifying the progression of ECG changes in hyperkalemia, starting with peaked T waves.'),
            const BulletPoint(text: 'Causes: Understand the common causes of hyperkalemia, such as renal failure, medications (e.g., ACE inhibitors), and tissue breakdown.'),
            const BulletPoint(text: 'Management: Be familiar with the emergency treatment of hyperkalemia, including stabilizing the cardiac membrane and shifting potassium intracellularly.'),
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
