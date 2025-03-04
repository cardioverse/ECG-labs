import 'package:flutter/material.dart';

class PACScreen extends StatefulWidget {
  const PACScreen({super.key});

  @override
  _PACScreenState createState() => _PACScreenState();
}

class _PACScreenState extends State<PACScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Premature Atrial Contractions (PACs)'),
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
                                'assets/images/Abnormalities/pac.png',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/Abnormalities/pac.png',
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
              'Premature Atrial Contractions (PACs) are early heartbeats originating in the atria. They are common and usually benign, but frequent PACs can be associated with underlying heart disease or may precede more significant arrhythmias.',
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
              'PACs occur when an ectopic focus in the atria fires before the next sinus impulse is due, resulting in an early atrial depolarization. This can be caused by stress, caffeine, alcohol, or electrolyte imbalances, and is often seen in otherwise healthy individuals.',
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
              'PACs are typically benign and asymptomatic, though they can cause palpitations or an irregular heartbeat sensation. In rare cases, frequent PACs may lead to atrial fibrillation or other sustained arrhythmias, particularly in patients with structural heart disease.',
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
            const BulletPoint(text: 'Premature P Wave: The P wave occurs earlier than expected, often with a different morphology compared to sinus P waves.'),
            const BulletPoint(text: 'Normal QRS Complex: The QRS complex is usually narrow, indicating that conduction through the ventricles is normal.'),
            const BulletPoint(text: 'Compensatory Pause: A pause may follow the PAC as the sinus node resets.'),
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
            const BulletPoint(text: 'ECG Recognition: Practice identifying premature P waves and distinguishing them from sinus P waves.'),
            const BulletPoint(text: 'Triggers: Be aware of common triggers such as caffeine, alcohol, and stress.'),
            const BulletPoint(text: 'Clinical Relevance: Understand that while PACs are often benign, frequent occurrences may warrant further evaluation.'),
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
