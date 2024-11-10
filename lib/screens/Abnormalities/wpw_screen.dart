import 'package:flutter/material.dart';

class WPWScreen extends StatefulWidget {
  @override
  _WPWScreenState createState() => _WPWScreenState();
}

class _WPWScreenState extends State<WPWScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20), // Adjust the duration as needed for smooth scrolling
    )..repeat();

    _animation = Tween<double>(begin: 0, end: -2519).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wolff-Parkinson-White Syndrome (WPW)'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated ECG Strip
            SizedBox(
              height: 150.0,
              width: double.infinity,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/Abnormalities/wpw.png',
                          height: 150.0,
                          width: 4883,
                          fit: BoxFit.contain, // Ensure the whole image is shown without cropping
                        ),
                        Image.asset(
                          'assets/images/Abnormalities/wpw.png',
                            height: 150.0,
                          width: 4883,
                          fit: BoxFit.contain, // Ensure the whole image is shown without cropping
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),

            // Overview Section
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Wolff-Parkinson-White (WPW) Syndrome is a condition characterized by the presence of an accessory pathway, known as the Bundle of Kent, which can cause episodes of supraventricular tachycardia (SVT). This accessory pathway allows electrical impulses to bypass the AV node, leading to early ventricular activation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Pathophysiology Section
            Text(
              'Pathophysiology',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'In WPW Syndrome, an accessory pathway connects the atria and ventricles, bypassing the normal delay at the AV node. This can lead to pre-excitation of the ventricles, seen as a delta wave on the ECG. The accessory pathway can also participate in reentrant circuits, leading to episodes of SVT.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Clinical Significance Section
            Text(
              'Clinical Significance',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'WPW Syndrome can lead to palpitations, dizziness, or syncope due to episodes of SVT. In rare cases, it can degenerate into ventricular fibrillation, which is life-threatening. Treatment may include medications or catheter ablation of the accessory pathway.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // ECG Features Section
            Text(
              'ECG Features',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            BulletPoint(text: 'Delta Wave: A slurred upstroke in the QRS complex, indicating early ventricular activation.'),
            BulletPoint(text: 'Short PR Interval: The PR interval is shorter than normal due to the bypassing of the AV node.'),
            BulletPoint(text: 'Wide QRS Complex: The QRS complex is often wider due to the abnormal conduction pathway.'),
            SizedBox(height: 16.0),

            // Study Pointers Section
            Text(
              'Pointers for Study',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            BulletPoint(text: 'ECG Recognition: Practice identifying the characteristic delta wave and short PR interval.'),
            BulletPoint(text: 'Clinical Management: Understand that WPW can be treated with catheter ablation, especially in symptomatic patients.'),
            BulletPoint(text: 'Complications: Be aware that WPW can lead to life-threatening arrhythmias like ventricular fibrillation.'),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
