import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/rate_quiz_screen.dart';

class RateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Basics'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle('Heart Rate Overview'),
                  _buildInfoCard(
                    'The heart rate is the number of times the heart beats per minute (bpm). '
                        'It varies from person to person but typically falls between 60 and 100 bpm at rest for adults.',
                  ),
                  _buildSectionTitle('How to Measure Heart Rate'),
                  _buildInfoCard(
                    '1. Find the pulse on the wrist (radial) or neck (carotid).\n'
                        '2. Use your index and middle fingers (avoid using the thumb).\n'
                        '3. Count beats for 15 seconds and multiply by 4.\n'
                        '4. Alternatively, use an ECG for precise measurement.',
                  ),
                  _buildSectionTitle('Normal Heart Rate Range'),
                  _buildInfoCard(
                    '• Adults: 60-100 bpm\n'
                        '• Athletes: 40-60 bpm\n'
                        '• Children: 80 to 130 beats, varies by age\n'
                        '• Newborns: 120-160 bpm',
                    highlightColor: Colors.green,
                  ),
                  _buildSectionTitle('Abnormal Heart Rates'),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeartRateCard(
                          title: 'Tachycardia',
                          heartRate: '> 100 bpm',
                          conditions: 'Stress, exertion, anemia',
                          highlightColor: Colors.redAccent,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildHeartRateCard(
                          title: 'Bradycardia',
                          heartRate: '< 60 bpm',
                          conditions: 'Hypothyroidism, sleep apnea',
                          highlightColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  _buildSectionTitle('Factors Affecting Heart Rate'),
                  _buildCleanInfoCard(
                    {
                      'Age': 'Heart rate decreases with age.',
                      'Physical Activity': 'Exercise increases heart rate during activity.',
                      'Fitness Level': 'Athletes have lower resting heart rates.',
                      'Emotions': 'Stress and excitement elevate heart rate temporarily.',
                      'Medications': 'Certain medications like beta-blockers can slow heart rate.',
                      'Health Conditions': 'Fever, dehydration, or heart problems can alter heart rate.',
                    },
                  ),
                  _buildSectionTitle('Heart Rate in an ECG'),
                  _buildCleanInfoCard(
                    {
                      'Formula': 'Heart rate can be calculated using the R-R interval on an ECG. '
                          'To estimate heart rate, use the formula:',
                      'Estimate Formula': '300 ÷ Number of large squares between R-waves.',
                      'Precise Formula': '1500 ÷ Number of small squares between R-waves for more precise calculation.'
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RateQuizScreen()),
                );
              },
              child: Text('Finished Topic'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, [IconData? icon, Color? iconColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, color: iconColor, size: 28),
          if (icon != null)
            SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeartRateCard({
    required String title,
    required String heartRate,
    required String conditions,
    required Color highlightColor,
  }) {
    return Card(
      color: Colors.grey[850],
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: highlightColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              heartRate,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              conditions,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCleanInfoCard(Map<String, String> factors) {
    return Card(
      color: Colors.grey[850],
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: factors.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String text, {Color? highlightColor}) {
    final TextStyle baseTextStyle = TextStyle(
      fontSize: 16,
      height: 1.5,
      color: Colors.white,
    );

    return Card(
      color: Colors.grey[850],
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: baseTextStyle,
            children: _buildHighlightedText(text, highlightColor),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(String text, Color? highlightColor) {
    final RegExp pattern = RegExp(r'\*\*(.*?)\*\*'); // Match bold text between **
    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in pattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      spans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: highlightColor ?? Colors.white,
          ),
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
