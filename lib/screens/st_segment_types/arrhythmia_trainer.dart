import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ArrhythmiaTrainer extends StatefulWidget {
  const ArrhythmiaTrainer({super.key});

  @override
  _ArrhythmiaTrainerState createState() => _ArrhythmiaTrainerState();
}

class _ArrhythmiaTrainerState extends State<ArrhythmiaTrainer> {
  final List<String> ecgImages = [
    'assets/images/arrhythmia_quiz/WPWTypeA.png',
    'assets/images/arrhythmia_quiz/Sinusbradycardiasecondarytoanorexianervosa.png',
    'assets/images/arrhythmia_quiz/MonomorphicVT.png',
    'assets/images/arrhythmia_quiz/CompleteheartblockwithaventricularescaperhythmSinusrhythmwith3rddegreeAVblock.png'
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arrhythmia Trainer"),
      ),
      body: Column(
        children: [
          // ECG Image displayed fully across the screen width without any blank space
          GestureDetector(
            onTap: () {
              // On tap, open the zoomable fullscreen ECG viewer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenEcgViewer(
                    images: ecgImages,
                    initialIndex: currentIndex,
                  ),
                ),
              );
            },
            child: AspectRatio(
              aspectRatio: 1.7, // Adjust the aspect ratio to fit the screen better
              child: Image.asset(
                ecgImages[currentIndex],
                fit: BoxFit.cover, // Ensures the image covers the full width without white space
              ),
            ),
          ),
          const SizedBox(height: 16.0), // Adds space between the image and quiz

          // Quiz question text
          const Text(
            'Identify this ECG',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),

          // Quiz options grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2, // Two options per row
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: getQuizOptions(), // Display quiz options as square buttons
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getQuizOptions() {
    List<String> options = [
      'WPW Type A',
      'Sinus Bradycardia',
      'Monomorphic VT',
      'Complete Heart Block'
    ];

    // Randomize the options for each ECG, ensure the correct one is included
    options.shuffle();

    return options.map((option) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0), // Adds consistent padding
          backgroundColor: Colors.blueAccent, // Sets button background color
          foregroundColor: Colors.white, // Sets text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Slightly rounded square
          ),
          elevation: 8.0, // Adds some elevation for a 3D effect
        ),
        onPressed: () {
          String correctAnswer = getCorrectAnswer(currentIndex);
          bool isCorrect = option == correctAnswer;
          showResultPopup(isCorrect, option);
        },
        child: Text(
          option,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    }).toList();
  }

  String getCorrectAnswer(int index) {
    switch (index) {
      case 0:
        return 'WPW Type A';
      case 1:
        return 'Sinus Bradycardia';
      case 2:
        return 'Monomorphic VT';
      case 3:
        return 'Complete Heart Block';
      default:
        return '';
    }
  }

  void showResultPopup(bool isCorrect, String selectedOption) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
          content: Text('You selected: $selectedOption'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isCorrect) {
                  setState(() {
                    // Show the next ECG after correct answer
                    currentIndex = (currentIndex + 1) % ecgImages.length;
                  });
                }
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }
}

// Full-screen viewer for zooming ECG images
class FullScreenEcgViewer extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenEcgViewer({super.key, required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        pageController: PageController(initialPage: initialIndex),
        backgroundDecoration: const BoxDecoration(color: Colors.black), // Set background to black for better contrast
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
      ),
    );
  }
}
