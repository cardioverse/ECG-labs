import 'package:flutter/material.dart';

class PVCScreen extends StatefulWidget {
  @override
  _PVCScreenState createState() => _PVCScreenState();
}

class _PVCScreenState extends State<PVCScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 6),
      )..repeat();

      _animation = Tween<double>(begin: 0, end: -MediaQuery.of(context).size.width / 1.5).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        ),
      );
      setState(() {}); // Trigger a rebuild to initialize the animation
    });
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
        title: Text('Premature Ventricular Contractions (PVCs)'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated ECG Strip
            if (_controller.isAnimating)
              SizedBox(
                height: 150.0,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Positioned(
                          left: _animation.value,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/Abnormalities/pvc.png',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/Abnormalities/pvc.png',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ],
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
              'Premature Ventricular Contractions (PVCs) are early heartbeats originating in the ventricles. They are common and usually benign but can be associated with increased risk of arrhythmias in patients with structural heart disease.',
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
              'PVCs occur when an ectopic focus in the ventricles fires before the next sinus impulse, resulting in an early ventricular depolarization. PVCs can be caused by electrolyte imbalances, ischemia, increased sympathetic tone, or structural heart disease.',
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
              'PVCs are usually benign, especially in healthy individuals. However, frequent PVCs or PVCs in patients with structural heart disease can increase the risk of developing more serious arrhythmias, such as ventricular tachycardia or fibrillation.',
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
            BulletPoint(text: 'Wide QRS Complex: The QRS complexes are typically wide (> 120 ms) and have an abnormal morphology.'),
            BulletPoint(text: 'No Preceding P Wave: PVCs are not preceded by a P wave, indicating they originate outside the normal conduction pathway.'),
            BulletPoint(text: 'Compensatory Pause: A pause often follows the PVC as the hearts normal rhythm resets.'),
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
            BulletPoint(text: 'ECG Recognition: Practice identifying wide, abnormal QRS complexes with no preceding P wave.'),
            BulletPoint(text: 'Clinical Relevance: Understand that isolated PVCs are often benign, but frequent PVCs may require further evaluation.'),
            BulletPoint(text: 'Management: In symptomatic patients or those with structural heart disease, management may include beta-blockers or other antiarrhythmic drugs.'),
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