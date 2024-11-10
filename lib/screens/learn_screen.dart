import 'package:ecg_trainer/screens/pr_segment_screen.dart';
import 'package:ecg_trainer/screens/r_wave_screen.dart';
import 'package:flutter/material.dart';
import 'p_wave_screen.dart';
import 'qrs_wave_screen.dart';
import 't_wave_screen.dart';
import 'pr_interval_screen.dart';
import 'st_segment_screen.dart';
import 'rate_screen.dart';  // New screen imports
import 'rhythm_screen.dart';
import 'grid_screen.dart';
import 'axis_calculation_screen.dart';
import 'lead_positioning_screen.dart';
import 'qt_interval_screen.dart'; // Added import for QT Interval
import 'q_wave_screen.dart';
import 's_wave_screen.dart';
import 'j_wave_screen.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Container(
            child: Image.asset(
              'assets/images/ecg.png', // Path to the ECG image
              fit: BoxFit.contain,
              height: 250,
            ),
          ),
          SizedBox(height: 20),

          // First Segment: Pure Basics
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Pure Basics'),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ElevatedButtonStyle(
                        label: 'Rate',
                        imagePath: 'assets/images/buttons/rate.png', // Placeholder image path
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RateScreen()), // Navigate to RateScreen
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'Rhythm',
                        imagePath: 'assets/images/buttons/rhythm.png', // Placeholder image path
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RhythmScreen()), // Navigate to RhythmScreen
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'Grid',
                        imagePath: 'assets/images/buttons/grid.png', // Placeholder image path
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GridScreen()), // Navigate to GridScreen
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'Axis Calculation',
                        imagePath: 'assets/images/buttons/axis.png', // Placeholder image path
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AxisCalculationScreen()), // Navigate to AxisCalculationScreen
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'Lead Positioning',
                        imagePath: 'assets/images/buttons/lead.png', // Placeholder image path
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LeadPositioningScreen()), // Navigate to LeadPositioningScreen
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Second Segment: Waves
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Waves'),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ElevatedButtonStyle(
                        label: 'P-Wave',
                        imagePath: 'assets/images/buttons/onlypwave.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PWaveScreen()),
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'QRS Complex',
                        imagePath: 'assets/images/buttons/onlyqrs.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QRSWaveScreen()),
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'T-Wave',
                        imagePath: 'assets/images/buttons/onlytwave.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TWaveScreen()),
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'R-Wave',  // New R-wave Button
                        imagePath: 'assets/images/buttons/onlyrwave.png',  // Placeholder for R-Wave button image
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RWaveScreen()),  // Navigate to RWaveScreen
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'Q-Wave',  // New Q-wave Button
                        imagePath: 'assets/images/buttons/onlyqwave.png',  // Placeholder for Q-Wave button image
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QWaveScreen()),  // Navigate to QWaveScreen
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'S-Wave',  // New S-wave Button
                        imagePath: 'assets/images/buttons/onlyswave.png',  // Placeholder for S-Wave button image
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SWaveScreen()),  // Navigate to SWaveScreen
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'J-Wave',
                        imagePath: 'assets/images/buttons/onlyjwave.png',  // Placeholder for J-Wave button image
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JWaveScreen()),  // Navigate to JWaveScreen
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Third Segment: Segments/Intervals
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Segments/Intervals'),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ElevatedButtonStyle(
                        label: 'PR Interval',
                        imagePath: 'assets/images/buttons/onlyprinterval.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PRIntervalScreen()),
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'ST Segment',
                        imagePath: 'assets/images/buttons/onlystsegment.png',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => STSegmentScreen()),
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'PR Segment',
                        imagePath: 'assets/images/buttons/onlyprsegment.png',  // Placeholder for PR Segment button image
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PRSegmentScreen()),
                          );
                        },
                      ),
                      ElevatedButtonStyle(
                        label: 'QT Interval',  // New QT Interval Button
                        imagePath: 'assets/images/buttons/onlyqtinterval.png',  // Placeholder for QT Interval button image
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QTIntervalScreen()),  // Navigate to QTIntervalScreen
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom section header widget for labeling sections
class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Custom button widget to apply consistent styling
class ElevatedButtonStyle extends StatelessWidget {
  final String label;
  final String? imagePath;
  final VoidCallback onPressed;

  ElevatedButtonStyle({
    required this.label,
    required this.onPressed,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null) ...[
            Image.asset(
              imagePath!,
              height: 80,
            ),
            SizedBox(height: 8),
          ],
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
