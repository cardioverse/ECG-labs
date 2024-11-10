import 'package:flutter/material.dart';

class LateralMIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lateral MI'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header

              SizedBox(height: 16),

              // Clinical Significance
              Text(
                'Clinical Significance of Lateral STEMI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• The lateral wall of the LV is supplied by branches of the left anterior descending (LAD) and left circumflex (LCx) arteries.\n'
                    '• Infarction of the lateral wall usually occurs as part of a larger territory infarction, e.g., anterolateral STEMI.\n'
                    '• Isolated lateral STEMI is less common, but may be produced by occlusion of smaller branch arteries, such as the first diagonal branch (D1) of the LAD, the obtuse marginal branch (OM) of the LCx, or the ramus intermedius.\n'
                    '• Lateral STEMI is a stand-alone indication for emergent reperfusion.\n'
                    '• Lateral extension of an anterior, inferior, or posterior MI indicates a larger territory of myocardium at risk, resulting in worse prognosis.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 16),

              // How to Recognize a Lateral STEMI
              Text(
                'How to Recognise a Lateral STEMI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• ST elevation in the lateral leads (I, aVL, V5-6).\n'
                    '• Reciprocal ST depression in the inferior leads (III and aVF).\n'
                    '• ST elevation primarily localized to leads I and aVL is referred to as a high lateral STEMI.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 16),

              // Patterns of Lateral Infarction
              Text(
                'Patterns of Lateral Infarction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Three broad categories of lateral infarction:\n'
                    '• Anterolateral STEMI due to LAD occlusion.\n'
                    '• Inferior-posterior-lateral STEMI due to LCx occlusion.\n'
                    '• Isolated lateral infarction due to occlusion of smaller branch arteries such as the D1, OM, or ramus intermedius.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 16),

              // ECG Image and Description
              Text(
                'ECG Example: High Lateral STEMI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Image.asset(
                  'assets/images/MI/HighLateralSTEMI.png',
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
                '• ST elevation is present in the high lateral leads (I and aVL).\n'
                    '• There is reciprocal ST depression in the inferior leads (III and aVF).\n'
                    '• QS waves in the anteroseptal leads (V1-4) with poor R wave progression indicate prior anteroseptal infarction.\n'
                    '• This pattern suggests proximal LAD disease with an acute occlusion of the first diagonal branch (D1).',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
