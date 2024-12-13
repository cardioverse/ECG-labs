import 'package:flutter/material.dart';
import 'medicine_repository.dart'; // Import the medicine repository
import 'medicine_detail_screen.dart';// Import the MedicineDetailScreen
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class MedicineListScreen extends StatelessWidget {
  final MedicineRepository _medicineRepository = MedicineRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Repository'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _medicineRepository.getMedicines(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No medicines found.'));
            } else {
              List<Map<String, dynamic>> medicines = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, // Maximum width per card
                    mainAxisSpacing: 8.0, // Vertical space between cards
                    crossAxisSpacing: 8.0, // Horizontal space between cards
                  ),
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    return Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          // Navigate to the MedicineDetailScreen on tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MedicineDetailScreen(medicine: medicine),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Allow dynamic height
                            children: [
                              Icon(
                                FontAwesomeIcons.pills,  // Pill icon from FontAwesome
                                size: 50,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 8),
                              Text(
                                medicine['name'] ?? 'No name',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                medicine['type'] ?? 'No type', // Show 'type' text
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
