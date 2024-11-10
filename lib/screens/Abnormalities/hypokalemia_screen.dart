import 'package:flutter/material.dart';

class HypokalemiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hypokalemia'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/Abnormalities/hypokalemia_example.png',
                height: 200.0,
              ),
            ),
            SizedBox(height: 16.0),

            // Overview Section
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Hypokalemia refers to low levels of potassium in the blood, which can affect cardiac conduction and lead to arrhythmias. Severe hypokalemia can be life-threatening and requires prompt recognition and treatment.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Pathophysiology Section
            Text(
              'Pathophysiology',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Hypokalemia causes hyperpolarization of the cardiac cell membrane, making it more difficult for the cells to depolarize. This can lead to delayed repolarization and an increased risk of arrhythmias, including ventricular tachycardia and fibrillation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Clinical Significance Section
            Text(
              'Clinical Significance',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Hypokalemia can cause symptoms such as muscle weakness, cramps, and palpitations. Severe hypokalemia can lead to dangerous arrhythmias and requires urgent treatment with potassium replacement. The underlying cause, such as diuretic use or gastrointestinal loss, should also be addressed.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // ECG Features Section
            Text(
              'ECG Features',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            BulletPoint(text: 'Flattened T Waves: T waves may become flattened or inverted, especially in the precordial leads.'),
            BulletPoint(text: 'U Waves: A prominent U wave may appear after the T wave, which is a characteristic finding in hypokalemia.'),
            BulletPoint(text: 'ST Depression: The ST segment may be depressed, indicating delayed ventricular repolarization.'),
            SizedBox(height: 16.0),

            // Study Pointers Section
            Text(
              'Pointers for Study',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            BulletPoint(text: 'ECG Recognition: Practice identifying the ECG changes in hypokalemia, including flattened T waves and prominent U waves.'),
            BulletPoint(text: 'Causes: Understand the common causes of hypokalemia, such as diuretic use, vomiting, and diarrhea.'),
            BulletPoint(text: 'Management: Be familiar with the treatment of hypokalemia, including potassium replacement and addressing the underlying cause.'),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
