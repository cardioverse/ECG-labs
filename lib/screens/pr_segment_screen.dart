import 'package:flutter/material.dart';
import 'package:ecg_trainer/topics_completion_tracker/pr_segment_quiz_screen.dart'; // Import the quiz screen

class PRSegmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PR Segment'),
        backgroundColor: Colors.black, // Set AppBar color to black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // PR Segment Section (without title)
            _buildCardSection(
              context,
              null, // No title for this section
              'assets/images/pr_segment_example.png', // PR Segment image path
              'The PR segment represents the time between the end of atrial depolarization and the beginning of ventricular depolarization. '
                  'It is the flat line on the ECG between the end of the P wave and the beginning of the QRS complex. This segment is crucial for understanding '
                  'conditions like AV blocks and pre-excitation syndromes.',
              Colors.orange, // Use orange for section highlight
            ),
            SizedBox(height: 16.0),

            // Key Points Section
            _buildCardSection(
              context,
              'Key Points:',
              null, // No image for key points section
              '• Represents the delay in AV node conduction.\n'
                  '• A normal PR segment is usually isoelectric (flat).\n'
                  '• Prolonged PR segment may indicate first-degree AV block.\n'
                  '• A shortened PR segment can be seen in conditions like pre-excitation syndromes (e.g., Wolff-Parkinson-White syndrome).',
              Colors.green, // Use orange for key points title
            ),
            SizedBox(height: 16.0),

            // Conclusion Section
            _buildCardSection(
              context,
              'Conclusion:',
              null, // No image for conclusion section
              'The PR segment is a small but vital component of the ECG, as it reflects the electrical conduction from the atria to the ventricles. '
                  'Abnormalities in the PR segment can provide important diagnostic clues about various heart conditions.',
              Colors.orange, // Use orange for conclusion title
            ),
            SizedBox(height: 16.0),

            // Finished Topic Button for Quiz
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PRSegmentQuizScreen()),
                  );
                },
                child: Text('Finished Topic'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget to build Sections with Important Info in Cards
  Widget _buildCardSection(BuildContext context, String? title, String? imagePath, String description, Color highlightColor) {
    return Card(
      elevation: 4,
      color: Colors.black87, // Dark background for contrast
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath != null) ...[
              Image.asset(
                imagePath,
                height: 200,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width, // Ensure image fits the screen width
              ),
              SizedBox(height: 10), // Add spacing after the image
            ],
            if (title != null) ...[
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: highlightColor, // Use highlight color for sections
                ),
              ),
              SizedBox(height: 10),
            ],
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
