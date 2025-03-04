import 'package:ecg_trainer/medicine_repo/medicine_REPO.dart';
import 'package:flutter/material.dart';
import 'cardiac_axis_trainer.dart';
import 'qrs_complex_quiz_screen.dart';
import 'arrythmia trainer/arrhythmia_trainer.dart';
import 'ecg repo/ecg_repository_screen.dart';
import 'package:ecg_trainer/screens/Abnormalities/abnormalities_screen.dart';
import 'Qtc_calculator/qtc_calculator_screen.dart';
import 'package:ecg_trainer/forum/forum_home_screen.dart';
// Import the new MedicineListScreen
import 'package:ecg_trainer/case_simulator/case_simulator.dart';
class ECGTrainerScreen extends StatelessWidget {
  final List<_ECGTrainerItem> abnormalitiesItem = [
    _ECGTrainerItem(
      title: 'Abnormalities',
      color: Colors.deepPurple[900]!,
      destination: () =>  AbnormalitiesScreen(),
      icon: Icons.warning, // Replace with an appropriate icon
    ),
  ];

  final List<_ECGTrainerItem> items = [
    _ECGTrainerItem(
      title: 'Cardiac Axis Trainer',
      color: Colors.deepPurple[900]!,
      destination: () => const CardiacAxisTrainer(),
      icon: Icons.trending_up, // Updated icon for Cardiac Axis Trainer
    ),
    _ECGTrainerItem(
      title: 'QRS Complex Quiz',
      color: Colors.deepPurple[900]!,
      destination: () => const QRSComplexQuizScreen(),
      icon: Icons.quiz, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'STEMI Spotter',
      color: Colors.deepPurple[900]!,
      destination: () => const ArrhythmiaTrainer(),
      icon: Icons.show_chart, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'ECG Repository',
      color: Colors.deepPurple[900]!,
      destination: () => const ECGRepositoryScreen(),
      icon: Icons.folder, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'QTc Calculator',
      color: Colors.deepPurple[900]!,
      destination: () => const QTcCalculatorScreen(),
      icon: Icons.calculate, // Replace with an appropriate icon
    ),
    _ECGTrainerItem(
      title: 'Medicine Repository', // New item for Medicine Repository
      color: Colors.deepPurple[900]!,
      destination: () => MedicineRepositoryScreen(), // Destination to the Medicine Repository
      icon: Icons.medical_services, // Icon representing medicines
    ),
    _ECGTrainerItem(
      title: 'Forums', // new item for forum
      color: Colors.deepPurple[900]!,
      destination: () => ForumHomeScreen(), // Destination to the Medicine Repository
      icon: Icons.chat_rounded, // Icon representing medicines
    ),
    _ECGTrainerItem(
      title: 'Case Simulator', // new item for forum
      color: Colors.deepPurple[900]!,
      destination: () => const CaseSimulator(), // Destination to the Medicine Repository
      icon: Icons.view_compact, // Icon representing medicines
    ),

  ];

   ECGTrainerScreen({super.key});

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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: abnormalitiesItem.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              const SizedBox(height: 12),
                              Text(
                                item.title,
                                style: const TextStyle(
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
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                const SizedBox(height: 12),
                                Text(
                                  item.title,
                                  style: const TextStyle(
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
