import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/lead_positioning_quiz_screen.dart';

class LeadPositioningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECG Lead Positioning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Add the image at the beginning
            Image.asset(
              'assets/images/basiclandmarks.png',
              height: 250,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),

            // Introduction Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Proper lead placement is crucial for obtaining an accurate ECG recording. Incorrect lead positioning can result in incorrect diagnoses, so understanding where to place the leads is essential.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),

            // 12-lead ECG system overview Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview of the 12-Lead ECG System',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'A standard 12-lead ECG consists of:\n'
                          '• 3 bipolar limb leads (I, II, III)\n'
                          '• 3 augmented limb leads (aVR, aVL, aVF)\n'
                          '• 6 precordial (chest) leads (V1-V6)\n\n'
                          'These leads capture the electrical activity of the heart from multiple angles, helping in the diagnosis of various cardiac conditions.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Add the 12-lead ECG image here
            Image.asset(
              'assets/images/12lead.png',
              height: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),

            // Limb lead placement Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Limb Lead Placement (Leads I, II, III, aVR, aVL, aVF)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Limb leads are placed on the arms and legs. Ensure that the patient is relaxed, and limbs are clean and dry.\n\n'
                          '• RA (Right Arm): Anywhere between the right shoulder and the wrist, but typically on the upper right arm.\n'
                          '• LA (Left Arm): Anywhere between the left shoulder and the wrist, typically on the upper left arm.\n'
                          '• RL (Right Leg): Anywhere above the right ankle and below the torso, typically placed on the right lower leg.\n'
                          '• LL (Left Leg): Anywhere above the left ankle and below the torso, typically placed on the left lower leg.\n\n'
                          'These electrodes form the bipolar leads (I, II, III) and augmented leads (aVR, aVL, aVF).',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Chest lead placement Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Precordial (Chest) Lead Placement (V1 - V6)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'The chest leads (V1-V6) provide detailed information about the horizontal plane of the heart. These are placed as follows:\n\n'
                          '• V1: 4th intercostal space (ICS), right of the sternum.\n'
                          '• V2: 4th intercostal space (ICS), left of the sternum.\n'
                          '• V3: Midway between V2 and V4.\n'
                          '• V4: 5th intercostal space (ICS), at the midclavicular line (left side).\n'
                          '• V5: Horizontally in line with V4, at the anterior axillary line.\n'
                          '• V6: Horizontally in line with V4 and V5, at the midaxillary line.\n',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Tips for accurate positioning Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tips for Accurate Lead Positioning',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Ensure the leads are placed on clean, dry skin. Avoid placing leads over bones or skin folds.\n'
                          '• Check that the cables are properly connected and not tangled.\n'
                          '• Make sure the patient is relaxed and comfortable to minimize movement.\n'
                          '• Re-check placement, especially for the chest leads, as incorrect positioning can affect the ECG interpretation.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // 3-electrode ECG section Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3-Electrode ECG',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'A 3-electrode ECG typically uses:\n'
                          '• RA (Right Arm)\n'
                          '• LA (Left Arm)\n'
                          '• RL (Right Leg)\n\n'
                          'This configuration is often used for basic monitoring, such as during exercise or for short-term ECG recordings. It provides limited information compared to a full 12-lead ECG but can be sufficient for basic heart rate and rhythm assessment.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Add 3-electrode image
            Image.asset(
              'assets/images/3electrode.png',
              height: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),

            // 5-electrode ECG section Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5-Electrode ECG',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'A 5-electrode ECG generally consists of:\n'
                          '• RA (Right Arm)\n'
                          '• LA (Left Arm)\n'
                          '• RL (Right Leg)\n'
                          '• V1 (Chest Lead)\n'
                          '• V2 (Chest Lead)\n\n'
                          'This setup allows for enhanced monitoring by incorporating two chest leads, providing better detail about the heart’s electrical activity compared to a 3-electrode configuration. It’s commonly used in telemetry and some clinical settings.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Add 5-electrode image
            Image.asset(
              'assets/images/5electrode.png',
              height: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),

            // Importance of correct lead placement Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Importance of Correct Lead Placement',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Correct lead placement ensures accurate ECG readings, allowing for proper diagnosis and treatment of cardiac conditions. Misplaced leads can lead to:\n'
                          '• Inaccurate heart rate readings\n'
                          '• Misinterpretation of cardiac events\n'
                          '• Delayed diagnosis\n\n'
                          'Always double-check lead placements to avoid these issues.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Finished Topic button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeadPositioningQuizScreen()),
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
}
