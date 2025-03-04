import 'package:flutter/material.dart';

class SVTScreen extends StatefulWidget {
  const SVTScreen({super.key});

  @override
  _SVTScreenState createState() => _SVTScreenState();
}

class _SVTScreenState extends State<SVTScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Supraventricular Tachycardia (SVT)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated ECG Strip
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
                              'assets/images/Abnormalities/svt.png',
                              height: 150.0,
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/images/Abnormalities/svt.png',
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
              'Supraventricular Tachycardia (SVT) is a rapid heart rate that originates above the ventricles. It is characterized by a sudden onset and termination, with a heart rate often between 150-250 beats per minute.',
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
              'SVT is typically caused by reentrant circuits or increased automaticity in the atria or AV node. The most common types of SVT include Atrioventricular Nodal Reentrant Tachycardia (AVNRT), Atrioventricular Reentrant Tachycardia (AVRT), and Atrial Tachycardia.',
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
              'SVT can cause symptoms such as palpitations, dizziness, shortness of breath, and chest discomfort. In some cases, it may lead to syncope or heart failure if left untreated. SVT is generally not life-threatening but can significantly affect quality of life.',
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
            const BulletPoint(text: 'Narrow QRS Complex: The QRS complexes are typically narrow (< 120 ms), indicating that the origin is above the ventricles.'),
            const BulletPoint(text: 'Rapid Regular Rhythm: The heart rate is usually between 150-250 beats per minute, with a regular rhythm.'),
            const BulletPoint(text: 'P Waves: P waves may be hidden within the QRS complex or appear just before or after it, depending on the type of SVT.'),
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
            const BulletPoint(text: 'ECG Recognition: Practice identifying narrow QRS complexes with a rapid, regular rhythm.'),
            const BulletPoint(text: 'Types of SVT: Understand the differences between AVNRT, AVRT, and Atrial Tachycardia.'),
            const BulletPoint(text: 'Clinical Management: Vagal maneuvers, medications like adenosine, and catheter ablation are common treatments for SVT.'),
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
