import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/pr_interval_quiz_screen.dart';

class PRIntervalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PR Interval'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 10),

          // PR Interval Overview Image
          _buildImageWithDescriptionSection(
            'assets/images/pr_interval_example.png',
            'The PR interval is the time from the onset of the P wave to the start of the QRS complex. It reflects conduction through the AV node.',
          ),
          SizedBox(height: 20),

          // Normal Duration Section
          _buildCardSection(
              'Normal Duration:',
              [
                '120 – 200 ms (0.12-0.20s) in duration (three to five small squares).',
              ],
              Colors.green  // Use green for normal parameters
          ),
          SizedBox(height: 20),

          // Prolonged PR Interval Section
          _buildCardSection(
              'Prolonged PR Interval (> 200 ms):',
              [
                'A prolonged PR interval may indicate first-degree AV block. If the PR interval is greater than 200 ms, it is indicative of delayed conduction through the AV node.',
              ],
              Colors.orange  // Use orange for clinical significance
          ),
          _buildSubsectionCard(
              'First Degree AV Block:',
              'Sinus rhythm with marked 1st degree heart block.',
              'assets/images/av_block_first_degree.png',
              Colors.red  // Use red for abnormalities
          ),
          SizedBox(height: 30),

          _buildSubsectionCard(
              'Second-Degree AV Block (Mobitz I):',
              'Second-degree AV block (Mobitz I) is characterized by progressively prolonging PR intervals followed by a dropped QRS complex. This is also known as the Wenckebach phenomenon.',
              'assets/images/av_block_mobitz_1.png',
              Colors.red
          ),
          SizedBox(height: 20),

          // Short PR Interval Section
          _buildCardSection(
              'Short PR Interval (< 120 ms):',
              [
                'A short PR interval may suggest pre-excitation syndromes (WPW, LGL) or AV nodal (junctional) rhythm.',
              ],
              Colors.orange  // Use orange for clinical significance
          ),
          _buildSubsectionCard(
              'Pre-excitation Syndromes:',
              'In pre-excitation syndromes like Wolff-Parkinson-White (WPW) and Lown-Ganong-Levine (LGL), the presence of an accessory pathway connecting the atria and ventricles leads to a short PR interval. These patients are susceptible to re-entry tachyarrhythmias.',
              'assets/images/wpw_syndrome.png',
              Colors.red
          ),
          SizedBox(height: 20),

          _buildSubsectionCard(
              'AV Nodal (Junctional) Rhythm:',
              'Junctional rhythms originate from the AV node and are characterized by narrow QRS complexes and inverted P waves or absent P waves. This causes a short PR interval.',
              'assets/images/junctional_rhythm.png',
              Colors.red
          ),
          SizedBox(height: 20),

          // Finished Topic button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PRIntervalQuizScreen()),
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
    );
  }

  // Helper Widget for an Image with Description
  Widget _buildImageWithDescriptionSection(String imagePath, String description) {
    return Column(
      children: [
        Image.asset(imagePath, height: 200),
        SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  // Helper Widget to build Sections with Important Info in Cards
  Widget _buildCardSection(String title, List<String> details, Color highlightColor) {
    return Card(
      elevation: 4,
      color: Colors.black87,  // Dark background for contrast
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
                color: highlightColor,  // Use highlight color for sections
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details.map((detail) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    detail,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget to build Subsection Cards with Images
  Widget _buildSubsectionCard(String title, String description, String imagePath, Color highlightColor) {
    return Card(
      elevation: 4,
      color: Colors.black87,  // Dark card background for contrast
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: highlightColor,  // Use red for abnormalities
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10),
            Image.asset(imagePath, height: 150),
          ],
        ),
      ),
    );
  }
}
