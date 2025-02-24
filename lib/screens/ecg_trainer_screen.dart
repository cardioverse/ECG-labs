import 'package:flutter/material.dart';
import 'cardiac_axis_trainer.dart';
import 'ecg_interpretation_helper.dart';
import 'qrs_complex_quiz_screen.dart';
import 'arrythmia trainer/arrhythmia_trainer.dart';
import 'ecg_animation.dart';
import 'ecg repo/ecg_repository_screen.dart';
import 'package:ecg_trainer/screens/Abnormalities/abnormalities_screen.dart';
import 'Qtc_calculator/qtc_calculator_screen.dart';

import 'package:ecg_trainer/medicine_repo/medicine_list_screen.dart'; // Import the new MedicineListScreen
import 'package:ecg_trainer/forum/forum_home_screen.dart';

class ECGTrainerScreen extends StatelessWidget {
  final List<_ECGTrainerItem> abnormalitiesItem = [
    _ECGTrainerItem(
      title: 'Abnormalities',
      color: Colors.deepPurple[900]!,
      destination: () => AbnormalitiesScreen(),
      icon: Icons.warning, // Replace with an appropriate icon
    ),
  ];

  final List<_ECGTrainerItem> items = [
    _ECGTrainerItem(
      title: 'Cardiac Axis Trainer',
      color: Colors.deepPurple[900]!,
      destination: () => CardiacAxisTrainer(),
      icon: Icons.trending_up, // Updated icon for Cardiac Axis Trainer
    ),
    _ECGTrainerItem(
      title: 'QRS Complex Quiz',
      color: Colors.deepPurple[900]!,
      destination: () => QRSComplexQuizScreen(),
      icon: Icons.quiz, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'STEMI Spotter',
      color: Colors.deepPurple[900]!,
      destination: () => ArrhythmiaTrainer(),
      icon: Icons.show_chart, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'ECG Repository',
      color: Colors.deepPurple[900]!,
      destination: () => ECGRepositoryScreen(),
      icon: Icons.folder, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'QTc Calculator',
      color: Colors.deepPurple[900]!,
      destination: () => QTcCalculatorScreen(),
      icon: Icons.calculate, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'Medicine Repository', // New item for Medicine Repository
      color: Colors.deepPurple[300]!,
      destination: () => MedicineListScreen(), // Destination to the Medicine Repository
      icon: Icons.medical_services, // Icon representing medicines
    ),
    _ECGTrainerItem(
      title: 'Forum',
      color: Colors.blue, // Choose a color that fits the theme
      destination: () => ForumHomeScreen(), // Navigate to Forum screen
      icon: Icons.forum, // Forum-related icon
    ),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: abnormalitiesItem.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Single column for abnormalities
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 5 / 2, // Further decrease height
                ),
                itemBuilder: (context, index) {
                  final item = abnormalitiesItem[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: item.color,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => item.destination()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              item.image != null
                                  ? Image(image: item.image!, height: 48, width: 48)
                                  : Icon(
                                item.icon,
                                size: 48,
                                color: Colors.white,
                              ),
                              SizedBox(height: 12),
                              Text(
                                item.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns for better layout
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 2, // Adjust aspect ratio as needed
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: item.color,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => item.destination()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                item.image != null
                                    ? Image(image: item.image!, height: 48, width: 48)
                                    : Icon(
                                  item.icon,
                                  size: 48,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ECGTrainerItem {
  final String title;
  final Color color;
  final Widget Function() destination;
  final IconData? icon;
  final ImageProvider? image;

  _ECGTrainerItem({
    required this.title,
    required this.color,
    required this.destination,
    this.icon,
    this.image,
  });
}
