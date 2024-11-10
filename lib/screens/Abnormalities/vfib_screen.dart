import 'package:flutter/material.dart';

class VFibScreen extends StatefulWidget {
  @override
  _VFibScreenState createState() => _VFibScreenState();
}

class _VFibScreenState extends State<VFibScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 10),
      )..repeat();

      _animation = Tween<double>(begin: 0, end: -MediaQuery.of(context).size.width).animate(
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
        title: Text('Ventricular Fibrillation (VFib)'),
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
                                'assets/images/Abnormalities/vfib.png',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/Abnormalities/vfib.png',
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
              'Ventricular Fibrillation (VFib) is a life-threatening arrhythmia characterized by chaotic and ineffective electrical activity in the ventricles, leading to a lack of cardiac output. VFib requires immediate intervention to prevent sudden cardiac death.',
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
              'VFib is caused by multiple, disorganized reentrant circuits within the ventricles. It results in ineffective contraction of the ventricles, causing immediate loss of cardiac output and, if untreated, leads to death within minutes.',
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
              'VFib is a medical emergency that requires immediate defibrillation. Without rapid intervention, the lack of effective cardiac output leads to organ failure and death. VFib is often preceded by Ventricular Tachycardia and can be seen in patients with myocardial infarction, cardiomyopathy, or electrolyte imbalances.',
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
            BulletPoint(text: 'Chaotic Electrical Activity: No discernible QRS complexes, P waves, or T waves.'),
            BulletPoint(text: 'Irregular Amplitude and Frequency: The waveform is completely disorganized, with varying amplitudes and frequencies.'),
            BulletPoint(text: 'Rapid Rate: The ventricular rate is extremely rapid and irregular.'),
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
            BulletPoint(text: 'ECG Recognition: Practice identifying chaotic, disorganized electrical activity with no recognizable QRS complexes.'),
            BulletPoint(text: 'Immediate Management: Understand the importance of early defibrillation and CPR in patients with VFib.'),
            BulletPoint(text: 'Prevention: Identify risk factors such as ischemic heart disease and electrolyte imbalances that can lead to VFib.'),
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