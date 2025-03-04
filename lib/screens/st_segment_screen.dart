import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecg_trainer/screens/st_segment_types/anterior_mi_screen.dart';
import 'package:ecg_trainer/screens/st_segment_types/inferior_mi_screen.dart';
import 'package:ecg_trainer/screens/st_segment_types/lateral_mi_screen.dart';
import 'package:ecg_trainer/screens/st_segment_types/septal_mi_screen.dart';
import 'package:ecg_trainer/screens/st_segment_types/posterior_mi_screen.dart';
import 'package:ecg_trainer/topics_completion_tracker/st_segment_quiz_screen.dart';

class STSegmentScreen extends StatefulWidget {
  const STSegmentScreen({super.key});

  @override
  _STSegmentScreenState createState() => _STSegmentScreenState();
}

class _STSegmentScreenState extends State<STSegmentScreen> {
  final PageController _pageController1 = PageController();
  final PageController _pageController2 = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ST Segment'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ST Segment Example Image
              _buildImageWithDescriptionSection(
                context,
                'assets/images/st_segment_example.png',
                'The ST segment represents the interval between the end of ventricular depolarization and the beginning of repolarization. '
                    'It is usually isoelectric (flat) and occurs after the QRS complex and before the T wave. '
                    'Deviations from the isoelectric line can indicate serious cardiac conditions.',
              ),
              const SizedBox(height: 24),

              // Section for Types of ST Elevation MI
              _buildTypesOfSTElevationMICarousel(context),

              // Morphology of the Elevated ST Segment
              _buildCardSection(
                'Morphology of the Elevated ST Segment',
                'Acute STEMI may produce ST elevation with either concave, convex, or obliquely straight morphology.',
                Colors.blue,
                _pageController1,
                [
                  'assets/images/st_elevation_1.png',
                  'assets/images/st_elevation_2.png',
                  'assets/images/st_elevation_3.png',
                  'assets/images/st_elevation_4.png',
                  'assets/images/st_elevation_5.png',
                ],
              ),
              const SizedBox(height: 24),

              // ST Segment Morphology in Other Conditions
              _buildCardSection(
                'ST Segment Morphology in Other Conditions',
                'Different conditions can produce distinct ST segment morphology, which is crucial for diagnosis.',
                Colors.orange,
                _pageController2,
                [
                  'assets/images/st_pericarditis.png',
                  'assets/images/st_ber.png',
                  'assets/images/st_lbbb.png',
                  'assets/images/st_lv_aneurysm.png',
                  'assets/images/st_brugada.png',
                ],
              ),
              const SizedBox(height: 16),

              // Finished Topic button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const STSegmentQuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Finished Topic'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for an Image with Description
  Widget _buildImageWithDescriptionSection(BuildContext context, String imagePath, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(imagePath, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  // Helper Widget to build Sections with Important Info in Cards
  Widget _buildCardSection(String title, String additionalInfo, Color highlightColor, PageController pageController, List<String> imagePaths) {
    return Card(
      elevation: 4,
      color: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: highlightColor,
              ),
            ),
            const SizedBox(height: 10),
            if (additionalInfo.isNotEmpty)
              Text(
                additionalInfo,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            const SizedBox(height: 10),
            SizedBox(height: 350,
              child: PageView.builder(
                controller: pageController,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0), // Optional padding for spacing
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.contain, // Ensures the image is fully visible
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: imagePaths.length,
                effect: const ScrollingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section for Types of ST Elevation MI - Carousel Version
  Widget _buildTypesOfSTElevationMICarousel(BuildContext context) {
    final miTypes = [
      {'label': 'Anterior MI', 'screen': const AnteriorMIScreen()},
      {'label': 'Inferior MI', 'screen': const InferiorMIScreen()},
      {'label': 'Lateral MI', 'screen': const LateralMIScreen()},
      {'label': 'Septal MI', 'screen': const SeptalMIScreen()},
      {'label': 'Posterior MI', 'screen': const PosteriorMIScreen()},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Types of ST Elevation MI',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 16),
        CarouselSlider(
          items: miTypes.map((mi) => _buildCardNavigationButton(
            context,
            mi['label'] as String,
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => mi['screen'] as Widget)),
          )).toList(),
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 0.8,
          ),
        ),
      ],
    );
  }

  // Helper Widget to Build a Card-like Navigation Button
  Widget _buildCardNavigationButton(BuildContext context, String label, VoidCallback onPressed) {
    return Card(
      elevation: 4,
      color: Colors.green, // Updated button color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            children: [

              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
