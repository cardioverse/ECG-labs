import 'package:flutter/material.dart';

class HowToMeasureQTIntervalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Measure the QT Interval'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [


            // Instruction Text
            Text(
              'The QT interval is usually measured in either lead II or V5-6, however, the lead with the longest measurement should be used.\n\n'
                  'Several successive beats should be measured, with the maximum interval taken.\n\n'
                  'Large U waves (> 1mm) that are fused to the T wave should be included in the measurement. Smaller U waves and those that are separate from the T wave should be excluded.\n\n'
                  'The maximum slope intercept method is used to define the end of the T wave. The QT interval is defined from the beginning of the QRS complex to the end of the T wave. '
                  'The maximum slope intercept method defines the end of the T wave as the intercept between the isoelectric line with the tangent drawn through the maximum down slope of the T wave (left).\n\n'
                  'When notched T waves are present (right), the QT interval is measured from the beginning of the QRS complex to the intersection point between the isoelectric line and the tangent drawn from the maximum down slope of the second notch.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Swipeable PNGs
            SizedBox(
              height: 350, // Adjust height according to your image size
              child: PageView(
                children: [
                  Image.asset('assets/images/qt_interval_m1.png'),
                  Image.asset('assets/images/qt_interval_m2.png'),
                  Image.asset('assets/images/qt_interval_m3.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
