import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/rhythm_quiz_screen.dart';

class RhythmScreen extends StatelessWidget {
  const RhythmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Rhythm Basics'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Heart Rhythm Overview', Colors.green),
            _buildInfoCard(
              'Heart rhythm refers to the regularity and pattern of heartbeats. A normal heart rhythm, known as sinus rhythm, originates from the sinoatrial (SA) node and ensures that the heart beats at a consistent, coordinated pace. Abnormalities in rhythm can indicate various cardiac issues.',
            ),
            _buildSectionTitle('Normal Sinus Rhythm (NSR)', Colors.green),
            _buildInfoCard(
              'NSR is the normal heart rhythm that starts from the SA node, with a regular rate between 60 and 100 beats per minute. It is characterized by consistent P, QRS, and T waves on an ECG, indicating that the electrical impulses are traveling normally through the heart.',
            ),
            _buildSectionTitle('Common Abnormal Rhythms', Colors.red),
            _buildRhythmInfoCard(
                title: 'Bradycardia',
                description:
                'A slower-than-normal heart rate (below 60 bpm), which can indicate a problem with the hearts electrical system or be normal in well-trained athletes.',
            ),
            _buildRhythmInfoCard(
              title: 'Tachycardia',
              description:
              'A faster-than-normal heart rate (above 100 bpm), which may be caused by stress, fever, or more serious issues like atrial fibrillation.',
            ),
            _buildRhythmInfoCard(
              title: 'Atrial Fibrillation (AFib)',
              description:
              'A chaotic, irregular rhythm where the atria quiver instead of contracting normally, leading to an irregular heartbeat.',
            ),
            _buildRhythmInfoCard(
              title: 'Atrial Flutter',
              description:
              'Similar to AFib, but with a more regular rhythm, usually caused by a reentrant circuit in the atria.',
            ),
            _buildRhythmInfoCard(
              title: 'Ventricular Tachycardia',
              description:
              'A dangerous, fast rhythm originating from the ventricles. If untreated, it may lead to ventricular fibrillation or sudden cardiac arrest.',
            ),
            _buildSectionTitle('How to Identify Rhythm on an ECG', Colors.blue),
            _buildIdentificationCard(), // Replaced with a detailed identification card
            _buildSectionTitle('Sinus Arrhythmia', Colors.yellow),
            _buildInfoCard(
              'Sinus arrhythmia is a natural variation in heart rhythm that occurs during the breathing cycle. The heart rate increases during inhalation and decreases during exhalation. This is usually a benign condition and is often seen in young, healthy individuals.',
            ),
            _buildSectionTitle('Premature Beats', Colors.red),
            _buildPrematureBeatsCard(),
            _buildSectionTitle('Heart Blocks', Colors.red),
            _buildHeartBlocksCard(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RhythmQuizScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Finished Topic'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildRhythmInfoCard({required String title, required String description}) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String text) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildIdentificationCard() {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIdentificationPoint('P-wave Analysis', 'In a normal sinus rhythm, the P-wave precedes every QRS complex.'),
            _buildIdentificationPoint('QRS Complex', 'The QRS complex should be narrow and occur at regular intervals.'),
            _buildIdentificationPoint('R-R Interval', 'Regular spacing between the R waves indicates a regular rhythm.'),
            _buildIdentificationPoint('PR Interval', 'A prolonged PR interval may indicate an AV block.'),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentificationPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrematureBeatsCard() {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premature Atrial Contractions (PACs):',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Extra heartbeats originating in the atria. PACs are common and usually benign but can indicate atrial irritation.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Premature Ventricular Contractions (PVCs):',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Extra heartbeats originating in the ventricles. Occasional PVCs are common and may not be concerning, but frequent PVCs may require further evaluation.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartBlocksCard() {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBlockCard('First-degree AV Block:', 'A prolonged PR interval (greater than 200 milliseconds) where every atrial impulse is conducted to the ventricles.'),
            _buildBlockCard('Second-degree AV Block:', 'Intermittent failure of conduction from atria to ventricles, resulting in missing QRS complexes.'),
            _buildBlockCard('Third-degree AV Block (Complete Block):', 'Complete failure of electrical signals to pass from the atria to the ventricles, leading to independent atrial and ventricular rhythms.'),
          ],
        ),
      ),
    );
  }

  Widget _buildBlockCard(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
