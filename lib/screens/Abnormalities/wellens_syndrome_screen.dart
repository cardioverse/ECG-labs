import 'package:flutter/material.dart';

class WellensSyndromeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wellens Syndrome'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/Abnormalities/wellens_example.png',
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
              'Wellens Syndrome is a pattern of ECG changes that indicates critical stenosis of the left anterior descending (LAD) coronary artery. It is associated with a high risk of impending anterior myocardial infarction if not treated promptly.',
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
              'Wellens Syndrome occurs due to critical stenosis of the proximal LAD artery. The characteristic ECG findings are seen during a pain-free interval, indicating transient ischemia of the anterior wall of the heart. Without intervention, patients are at high risk of progressing to an extensive anterior myocardial infarction.',
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
              'Wellens Syndrome is a warning sign of impending myocardial infarction. Patients with Wellens Syndrome are often pain-free at the time of ECG recording, but they require urgent coronary angiography and revascularization to prevent an extensive anterior myocardial infarction.',
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
            BulletPoint(text: 'Deeply Inverted or Biphasic T Waves: Typically seen in leads V2 and V3, these T wave changes are characteristic of Wellens Syndrome.'),
            BulletPoint(text: 'Minimal or No ST Elevation: There is typically no significant ST elevation, distinguishing Wellens Syndrome from an acute STEMI.'),
            BulletPoint(text: 'Normal Cardiac Enzymes: Cardiac enzymes are usually normal or only mildly elevated, as the changes occur during a pain-free interval.'),
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
            BulletPoint(text: 'ECG Recognition: Practice identifying the deeply inverted or biphasic T waves in leads V2 and V3.'),
            BulletPoint(text: 'Clinical Importance: Understand that Wellens Syndrome is a critical warning sign and requires urgent intervention.'),
            BulletPoint(text: 'Management: Be aware that patients with Wellens Syndrome need prompt coronary angiography and potential revascularization.'),
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
