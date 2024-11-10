import 'package:flutter/material.dart';

class TorsadesScreen extends StatefulWidget {
  @override
  _TorsadesScreenState createState() => _TorsadesScreenState();
}

class _TorsadesScreenState extends State<TorsadesScreen> with SingleTickerProviderStateMixin {
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
        title: Text('Torsades de Pointes'),
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
                                'assets/images/Abnormalities/torsades.png',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/Abnormalities/torsades.png',
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
              'Torsades de Pointes is a specific type of polymorphic ventricular tachycardia that is associated with a prolonged QT interval. It is characterized by a twisting of the QRS complexes around the isoelectric line and can lead to ventricular fibrillation if not treated promptly.',
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
              'Torsades de Pointes occurs in the setting of a prolonged QT interval, which may be congenital or acquired. It is often triggered by early afterdepolarizations, which can lead to a reentrant arrhythmia. Common causes include electrolyte imbalances (such as hypokalemia or hypomagnesemia), medications that prolong the QT interval, and congenital long QT syndrome.',
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
              'Torsades de Pointes can cause symptoms such as palpitations, dizziness, syncope, or even sudden cardiac arrest. Immediate intervention is required, especially if the arrhythmia is sustained, to prevent progression to ventricular fibrillation and sudden death.',
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
            BulletPoint(text: 'Prolonged QT Interval: The QT interval is typically prolonged prior to the onset of Torsades de Pointes.'),
            BulletPoint(text: 'Twisting QRS Complexes: The QRS complexes appear to twist around the isoelectric line, giving it a characteristic appearance.'),
            BulletPoint(text: 'Polymorphic Appearance: The QRS morphology changes from beat to beat.'),
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
            BulletPoint(text: 'ECG Recognition: Practice identifying the twisting pattern of QRS complexes and the prolonged QT interval.'),
            BulletPoint(text: 'Risk Factors: Understand the causes of prolonged QT, including medications, electrolyte disturbances, and congenital syndromes.'),
            BulletPoint(text: 'Management: Immediate management may include magnesium sulfate, correcting electrolyte imbalances, and defibrillation if the patient is unstable.'),
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
