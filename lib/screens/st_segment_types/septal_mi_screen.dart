import 'package:flutter/material.dart';

class SeptalMIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Septal MI'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header




              SizedBox(height: 8),
              Text(
                'Septal MI primarily affects the septal region of the heart, which is usually supplied by the left anterior descending artery (LAD). The septal leads are V1 and V2.\n'
                    'Involvement of this area can cause significant damage, impacting the conduction system due to its proximity to the bundle branches.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 16),

              // ECG Image and Description
              Text(
                'ECG Example: Hyperacute Anteroseptal STEMI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Image.asset(
                  'assets/images/MI/HyperacuteAnteroseptalSTEMI.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'ECG Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• ST elevation and hyperacute T waves in V2-4.\n'
                    '• ST elevation in I and aVL with reciprocal ST depression in lead III.\n'
                    '• Q waves are present in the septal leads V1-2.\n'
                    '• These features indicate a hyperacute anteroseptal STEMI.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
