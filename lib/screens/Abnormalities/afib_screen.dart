import 'package:flutter/material.dart';

class AfibScreen extends StatefulWidget {
  @override
  _AfibScreenState createState() => _AfibScreenState();
}

class _AfibScreenState extends State<AfibScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(); // Makes the animation loop

    _animation = Tween<double>(begin: 0, end: -400).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
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
        title: Text('Atrial Fibrillation (AFib)'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image with Animation
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(_animation.value, 0),
                        child: Image.asset(
                          'assets/images/Abnormalities/Afib.png',
                          height: 150.0,
                          width: 800.0,
                          fit: BoxFit.none,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(_animation.value + 370, 0),
                        child: Image.asset(
                          'assets/images/Abnormalities/Afib.png',
                          height: 150.0,
                          width: 800.0,
                          fit: BoxFit.none,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),

            // Overview Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Atrial Fibrillation (AFib) is characterized by rapid, disorganized electrical activity in the atria, leading to an irregularly irregular ventricular response. In AFib, the P waves are absent and are replaced by fibrillatory waves.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Pathophysiology Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pathophysiology',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'AFib occurs due to the chaotic firing of multiple reentrant circuits in the atria. This results in the lack of effective atrial contraction and an irregular ventricular rate, which can significantly impact cardiac output.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Clinical Significance Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clinical Significance',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'AFib increases the risk of stroke, heart failure, and other heart-related complications. It is important to identify and manage AFib promptly to prevent adverse outcomes.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // ECG Features Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ECG Features',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    BulletPoint(text: 'Irregular Rhythm: No consistent pattern in R-R intervals.'),
                    BulletPoint(text: 'Absent P Waves: No discernible P waves; replaced by irregular fibrillatory waves.'),
                    BulletPoint(text: 'Ventricular Rate: The rate is often rapid but irregular.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Study Pointers Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pointers for Study',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    BulletPoint(text: 'ECG Recognition: Practice identifying irregular R-R intervals and the absence of P waves.'),
                    BulletPoint(text: 'Key Differentiators: Unlike atrial flutter, AFib does not have the classic sawtooth pattern.'),
                    BulletPoint(text: 'Clinical Tips: Consider anticoagulation in patients with AFib to reduce the risk of thromboembolic events.'),
                    BulletPoint(text: 'Management: Look for rate control versus rhythm control strategies.'),
                  ],
                ),
              ),
            ),
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
