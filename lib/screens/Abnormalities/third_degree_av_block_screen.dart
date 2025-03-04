import 'package:flutter/material.dart';

class ThirdDegreeAVBlockScreen extends StatefulWidget {
  const ThirdDegreeAVBlockScreen({super.key});

  @override
  _ThirdDegreeAVBlockScreenState createState() => _ThirdDegreeAVBlockScreenState();
}

class _ThirdDegreeAVBlockScreenState extends State<ThirdDegreeAVBlockScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 6),
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
        title: const Text('Third-Degree AV Block (Complete Heart Block)'),
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
                        'assets/images/Abnormalities/third_degree_av_block.png',
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/Abnormalities/third_degree_av_block.png',
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
          'Third-Degree Atrioventricular (AV) Block, also known as Complete Heart Block, occurs when there is no conduction between the atria and ventricles. The atria and ventricles beat independently, leading to a lack of coordination in the hears electrical activity.',
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
    'Third-Degree AV Block is caused by a complete failure of conduction through the AV node or His-Purkinje system. As a result, the atria and ventricles beat independently, with the ventricles relying on an escape rhythm that is often slower than normal.',
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
    'Third-Degree AV Block is a medical emergency that can lead to syncope, heart failure, or sudden cardiac death if not treated promptly. Patients often require a permanent pacemaker to restore coordinated atrioventricular conduction.',
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
    const BulletPoint(text: 'Atrioventricular Dissociation: The P waves and QRS complexes occur independently, with no relationship between them.'),
    const BulletPoint(text: 'Escape Rhythm: The ventricular rate is typically slow, originating from an escape focus in the AV node or ventricles.'),
    const BulletPoint(text: 'Variable PR Intervals: Since there is no conduction, the PR interval is variable and lacks any consistent pattern.'),
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
    const BulletPoint(text: 'ECG Recognition: Practice identifying the complete lack of association between P waves and QRS complexes.'),
    const BulletPoint(text: 'Clinical Management: Understand that Third-Degree AV Block often requires immediate intervention, typically with a pacemaker.'),
    const BulletPoint(text: 'Causes: Be aware of potential causes such as ischemic heart disease, fibrosis of the conduction system, and certain medications.'),
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
