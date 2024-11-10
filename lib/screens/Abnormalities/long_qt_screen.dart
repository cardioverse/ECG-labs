import 'package:flutter/material.dart';

class LongQTScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Long QT Syndrome'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/Abnormalities/long_qt_example.png',
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
              'Long QT Syndrome is a condition characterized by a prolonged QT interval on the ECG, which can increase the risk of sudden, life-threatening arrhythmias, such as Torsades de Pointes. It may be congenital or acquired due to medications or electrolyte imbalances.',
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
              'Long QT Syndrome occurs due to delayed repolarization of the heart, which can lead to early afterdepolarizations and trigger dangerous arrhythmias. Congenital Long QT Syndrome is caused by genetic mutations affecting ion channels, while acquired Long QT is often due to medications, hypokalemia, or hypomagnesemia.',
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
              'Patients with Long QT Syndrome are at increased risk of ventricular arrhythmias, syncope, and sudden cardiac death. Early recognition and management are crucial to prevent these complications. Treatment may include beta-blockers, avoidance of QT-prolonging drugs, or implantation of an ICD in high-risk patients.',
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
            BulletPoint(text: 'Prolonged QT Interval: The QT interval is prolonged, typically greater than 450 ms in males and 460 ms in females.'),
            BulletPoint(text: 'T Wave Abnormalities: The T waves may appear notched or have an abnormal morphology.'),
            BulletPoint(text: 'Risk of Torsades de Pointes: Prolonged QT can lead to the development of Torsades de Pointes, a life-threatening polymorphic ventricular tachycardia.'),
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
            BulletPoint(text: 'ECG Recognition: Practice measuring the QT interval and recognizing prolonged QT in different leads.'),
            BulletPoint(text: 'Causes: Be aware of both congenital and acquired causes of Long QT, including medications and electrolyte abnormalities.'),
            BulletPoint(text: 'Management: Understand the treatment strategies for Long QT, including beta-blockers, lifestyle modifications, and ICD implantation.'),
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