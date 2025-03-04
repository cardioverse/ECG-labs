import 'package:flutter/material.dart';

class MobitzType2Screen extends StatefulWidget {
  const MobitzType2Screen({super.key});

  @override
  _MobitzType2ScreenState createState() => _MobitzType2ScreenState();
}

class _MobitzType2ScreenState extends State<MobitzType2Screen> with SingleTickerProviderStateMixin {
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
        title: const Text('Second-Degree AV Block Type II (Mobitz II)'),
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
                                'assets/images/Abnormalities/mobitz_type_2.png',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/Abnormalities/mobitz_type_2.png',
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
              'Second-Degree Atrioventricular (AV) Block Type II, also known as Mobitz II, is characterized by sudden, unpredictable dropped QRS complexes without progressive PR interval prolongation. This type of block can be more serious and often indicates underlying conduction system disease.',
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
              'Mobitz Type II occurs due to a block within the His-Purkinje system, which causes some atrial impulses to fail to conduct to the ventricles. This results in intermittent dropped QRS complexes without the progressive PR interval prolongation seen in Mobitz Type I.',
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
              'Mobitz Type II is more concerning than Mobitz Type I because it often progresses to complete heart block and is associated with a higher risk of sudden cardiac arrest. Patients may experience symptoms such as syncope or dizziness, and a pacemaker is often required for management.',
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
            const BulletPoint(text: 'Sudden Dropped QRS Complexes: QRS complexes are dropped without prior progressive PR interval prolongation.'),
            const BulletPoint(text: 'Constant PR Interval: The PR interval remains constant for conducted beats.'),
            const BulletPoint(text: 'Irregular Ventricular Rhythm: Due to the unpredictable dropped beats, the ventricular rhythm is irregular.'),
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
            const BulletPoint(text: 'ECG Recognition: Practice identifying sudden, unpredictable dropped QRS complexes with a constant PR interval.'),
            const BulletPoint(text: 'Clinical Relevance: Understand the importance of Mobitz Type II as a potential precursor to complete heart block, often requiring a pacemaker.'),
            const BulletPoint(text: 'Management: Be aware that Mobitz Type II generally requires close monitoring and often a permanent pacemaker for long-term management.'),
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
