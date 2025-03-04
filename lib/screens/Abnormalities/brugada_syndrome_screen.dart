import 'package:flutter/material.dart';

class BrugadaSyndromeScreen extends StatelessWidget {
  const BrugadaSyndromeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brugada Syndrome'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/Abnormalities/brugada_example.png',
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
              'Brugada Syndrome is a genetic condition characterized by abnormal ECG findings and an increased risk of sudden cardiac death due to ventricular arrhythmias. It primarily affects the sodium channels in the heart and is more common in males.',
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
              'Brugada Syndrome is caused by mutations in the genes that code for cardiac sodium channels. This leads to impaired sodium ion flow and results in abnormal repolarization, particularly in the right ventricular outflow tract. These changes increase the risk of developing life-threatening ventricular arrhythmias.',
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
              'Brugada Syndrome is associated with a high risk of sudden cardiac death, particularly in young, otherwise healthy individuals. Symptoms may include fainting or sudden cardiac arrest, often triggered by fever or certain medications. Implantable cardioverter-defibrillators (ICDs) are often used in high-risk patients to prevent sudden death.',
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
            const BulletPoint(text: 'Coved ST Segment Elevation: Characteristic coved ST segment elevation in leads V1-V3, often followed by a negative T wave.'),
            const BulletPoint(text: 'Right Bundle Branch Block Pattern: A partial or complete right bundle branch block may also be seen.'),
            const BulletPoint(text: 'Type 1 Pattern: The Type 1 ECG pattern is diagnostic of Brugada Syndrome and is characterized by a prominent coved ST segment elevation.'),
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
            const BulletPoint(text: 'ECG Recognition: Practice identifying the coved ST segment elevation in leads V1-V3, which is characteristic of Brugada Syndrome.'),
            const BulletPoint(text: 'Genetics: Understand that Brugada Syndrome is often caused by genetic mutations affecting sodium channels.'),
            const BulletPoint(text: 'Management: Be aware that ICD implantation is the primary treatment for preventing sudden cardiac death in high-risk patients.'),
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
