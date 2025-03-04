import 'package:flutter/material.dart';

class VTScreen extends StatefulWidget {
  const VTScreen({super.key});

  @override
  _VTScreenState createState() => _VTScreenState();
}

class _VTScreenState extends State<VTScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
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
        title: const Text('Ventricular Tachycardia (VT)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                                'assets/images/Abnormalities/vt.png',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/Abnormalities/vt.png',
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
            const SizedBox(height: 16.0),

            // Overview Section
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Ventricular Tachycardia (VT) is a rapid heart rate originating from the ventricles. It is characterized by a heart rate of over 100 beats per minute with at least three consecutive irregular ventricular beats.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Pathophysiology Section
            const Text(
              'Pathophysiology',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'VT is usually caused by abnormal automaticity, triggered activity, or reentry circuits within the ventricular myocardium. It is often seen in patients with structural heart disease, such as myocardial infarction or cardiomyopathy.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Clinical Significance Section
            const Text(
              'Clinical Significance',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'VT can lead to symptoms such as palpitations, dizziness, syncope, and even cardiac arrest. Sustained VT is a medical emergency requiring immediate intervention to prevent hemodynamic collapse or sudden cardiac death.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // ECG Features Section
            const Text(
              'ECG Features',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const BulletPoint(text: 'Wide QRS Complex: The QRS complexes are typically wide (> 120 ms), indicating a ventricular origin.'),
            const BulletPoint(text: 'Rapid Ventricular Rate: The heart rate is usually over 100 beats per minute.'),
            const BulletPoint(text: 'AV Dissociation: P waves may be present but are not related to the QRS complexes, indicating atrioventricular dissociation.'),
            const SizedBox(height: 16.0),

            // Study Pointers Section
            const Text(
              'Pointers for Study',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const BulletPoint(text: 'ECG Recognition: Practice identifying wide QRS complexes with a rapid ventricular rate.'),
            const BulletPoint(text: 'Types of VT: Understand the difference between monomorphic and polymorphic VT.'),
            const BulletPoint(text: "Clinical Management: Immediate treatment may include antiarrhythmic drugs, cardioversion, or defibrillation depending on the patient's stability."),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
