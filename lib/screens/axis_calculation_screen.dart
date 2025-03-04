import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/axis_calculation_quiz_screen.dart';

class AxisCalculationScreen extends StatelessWidget {
  const AxisCalculationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardiac Axis Calculation'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),

            // Introductory text
            _buildInfoCard(
              context,
              'The cardiac axis represents the overall direction of the hearts electrical activity in the frontal plane. '
            'Knowing the axis can help in diagnosing various conditions such as ventricular hypertrophy, bundle branch blocks, and infarctions.',
            ),
            const SizedBox(height: 16),

            // Image of cardiac axis
            Image.asset(
              'assets/images/axis_reference.png', // Make sure the path is correct
              height: 350, // Adjust height based on your design
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),

            // Understanding the Cardiac Axis
            _buildSectionTitle(context, 'Understanding the Cardiac Axis'),
            _buildInfoCard(
              context,
              'The electrical axis of the heart typically lies between -30° and +90°. '
                  'When the axis deviates outside this range, it can indicate specific cardiac conditions.\n\n'
                  '• Normal Axis: Between -30° and +90°.\n'
                  '• Left Axis Deviation (LAD): Less than -30°.\n'
                  '• Right Axis Deviation (RAD): Greater than +90°.\n'
                  '• Extreme Axis Deviation: Between -90° and ±180° (also called "Northwest Axis").',
            ),
            const SizedBox(height: 16),

            // Step-by-Step Axis Calculation
            _buildSectionTitle(context, 'Step-by-Step Axis Calculation'),
            _buildInfoCard(
              context,
              '1. Examine Leads I and aVF:\n'
                  '• Lead I represents the left-to-right electrical activity of the heart.\n'
                  '• Lead aVF represents the superior-to-inferior electrical activity of the heart.\n\n'
                  'To determine the axis, examine whether the QRS complexes in Lead I and aVF are positive, negative, or isoelectric.',
            ),
            const SizedBox(height: 16),

            // Axis Determination Table
            _buildSectionTitle(context, 'Determine Axis Based on Lead I and aVF'),
            _buildInfoCard(
              context,
              '• Both Leads Positive: Normal axis (between -30° and +90°).\n'
                  '• Lead I Positive, Lead aVF Negative: Left axis deviation (LAD).\n'
                  '• Lead I Negative, Lead aVF Positive: Right axis deviation (RAD).\n'
                  '• Both Leads Negative: Extreme axis deviation or "Northwest Axis."',
            ),
            const SizedBox(height: 16),

            // Isoelectric Lead Method
            _buildSectionTitle(context, 'Isoelectric Lead Method'),
            _buildInfoCard(
              context,
              'This method allows for a more precise calculation of the cardiac axis:\n'
                  '• Find the lead in which the QRS complex is isoelectric (equally positive and negative). '
                  'The axis is approximately perpendicular to this lead.\n'
                  '• Next, find the perpendicular lead, and check whether the QRS complex in that lead is predominantly positive or negative.\n'
                  '• If positive, the axis points in the direction of that lead. If negative, the axis points in the opposite direction.',
            ),
            const SizedBox(height: 16),

            // Example Axis Calculation
            _buildSectionTitle(context, 'Example: Determining the Cardiac Axis'),
            _buildInfoCard(
              context,
              'Suppose Lead I is positive, and Lead aVF is negative. This suggests left axis deviation. '
                  'Now, check Lead II. If Lead II is also negative, the axis is likely between -30° and -90°, confirming a left axis deviation (LAD).',
            ),
            const SizedBox(height: 16),

            // Common Causes of Axis Deviation
            _buildSectionTitle(context, 'Common Causes of Axis Deviation'),
            _buildInfoCard(
              context,
              'Left Axis Deviation (LAD):\n'
                  '• Left ventricular hypertrophy (LVH)\n'
                  '• Left bundle branch block (LBBB)\n'
                  '• Inferior wall myocardial infarction\n'
                  '• WPW syndrome (with right-sided accessory pathways)\n\n'
                  'Right Axis Deviation (RAD):\n'
                  '• Right ventricular hypertrophy (RVH)\n'
                  '• Right bundle branch block (RBBB)\n'
                  '• Pulmonary embolism\n'
                  '• Chronic lung disease (COPD)\n',
            ),
            const SizedBox(height: 16),

            // Finished Topic button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AxisCalculationQuizScreen()),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String content) {
    return Card(
      color: Colors.grey[70],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
