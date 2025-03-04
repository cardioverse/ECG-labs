import 'package:flutter/material.dart';

class ECGAnimation extends StatefulWidget {
  const ECGAnimation({super.key});

  @override
  _ECGAnimationState createState() => _ECGAnimationState();
}

class _ECGAnimationState extends State<ECGAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10), // Adjust speed here for desired effect
      vsync: this,
    )..repeat(); // Loop the animation continuously

    // Define animation from left to right across the screen
    _animation = Tween<double>(
      begin: 0.0, // Start from left of the screen
      end: 1.0,   // End at the right of the screen
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Moving ECG strip with offset for dynamic effect
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Positioned(
              left: -MediaQuery.of(context).size.width * _animation.value * 2, // Adjusted for continuous looping effect
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/ecg_animation/animation_test.png',
                    fit: BoxFit.fill, // Changed to fill to avoid blank space
                    width: MediaQuery.of(context).size.width, // Image width matches screen width
                  ),
                  Image.asset(
                    'assets/images/ecg_animation/animation_test.png',
                    fit: BoxFit.fill, // Changed to fill to avoid blank space
                    width: MediaQuery.of(context).size.width, // Duplicate image for seamless looping
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// Example usage of the ECGAnimation widget
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black, // Set background color to enhance the ECG effect
      body: Center(
        child: ECGAnimation(),
      ),
    ),
  ));
}