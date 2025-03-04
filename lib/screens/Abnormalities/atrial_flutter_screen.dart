import 'package:flutter/material.dart';

class AtrialFlutterScreen extends StatefulWidget {
  const AtrialFlutterScreen({super.key});

  @override
  _AtrialFlutterScreenState createState() => _AtrialFlutterScreenState();
}

class _AtrialFlutterScreenState extends State<AtrialFlutterScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animation = Tween<double>(begin: 0, end: -MediaQuery.of(context).size.width).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.linear,
          ),
        );
      });
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
        title: const Text('Atrial Flutter'),
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
                              'assets/images/Abnormalities/atrial_flutter.png',
                              height: 150.0,
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/images/Abnormalities/atrial_flutter.png',
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
              'Atrial Flutter is characterized by rapid, regular atrial contractions, often described as a "sawtooth" pattern. The atrial rate is typically around 250-350 beats per minute, with a consistent conduction to the ventricles.',
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
              'Atrial Flutter is usually caused by a large reentrant circuit within the atria, leading to continuous atrial depolarization. Unlike Atrial Fibrillation, Atrial Flutter maintains a regular rhythm, but still leads to inefficient atrial contractions.',
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
              'Atrial Flutter, like AFib, increases the risk of stroke due to the potential for thrombus formation. It is commonly seen in patients with cardiovascular conditions such as heart failure, valvular disease, or chronic obstructive pulmonary disease (COPD).',
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
            const BulletPoint(text: 'Sawtooth Pattern: The hallmark of Atrial Flutter is the characteristic sawtooth flutter waves, usually best seen in leads II, III, and aVF.'),
            const BulletPoint(text: 'Regular Atrial Rate: The atrial rate ranges from 250-350 beats per minute.'),
            const BulletPoint(text: 'Fixed Conduction Ratio: Often a 2:1, 3:1, or 4:1 conduction ratio between the atrial and ventricular rates.'),
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
            const BulletPoint(text: 'ECG Recognition: Practice identifying the sawtooth pattern, which differentiates Atrial Flutter from other atrial tachyarrhythmias.'),
            const BulletPoint(text: 'Key Differentiators: Note that unlike AFib, the rhythm in Atrial Flutter is regular unless there is variable conduction.'),
            const BulletPoint(text: 'Clinical Tips: Rate control, rhythm control, and anticoagulation should all be considered in management. Ablation therapy can often be curative.'),
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
