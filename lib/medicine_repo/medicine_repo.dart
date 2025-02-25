import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'medicine_detail_screen.dart';  // Import the MedicineDetailScreen

class Medicine {
  final String name;
  final String description;
  final String dosage;
  final String half_life;
  final String indication;
  final String contraindication;
  final String onset_of_action;
  final String type;

  Medicine({required this.name, required this.description, required this.dosage, required this.half_life, required this.indication, required this.contraindication, required this.onset_of_action, required this.type});

  // Convert Firestore data to Medicine model
  factory Medicine.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Medicine(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      dosage: data['dosage'] ?? '',
      half_life: data['half_life'] ?? '',
      indication: data ['indication'] ?? '',
      contraindication: data['contraindication'] ?? '',
      onset_of_action: data['onset_of_action'] ?? '',
      type: data['type'] ?? '',
    );
  }
}

class MedicineRepositoryScreen extends StatefulWidget {
  @override
  _MedicineRepositoryScreenState createState() =>
      _MedicineRepositoryScreenState();
}

class _MedicineRepositoryScreenState extends State<MedicineRepositoryScreen> {
  TextEditingController searchController = TextEditingController();
  List<Medicine> medicines = [];
  List<Medicine> filteredMedicines = [];

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
  }

  // Fetch medicines from Firebase Firestore
  void _fetchMedicines() async {
    var snapshot = await FirebaseFirestore.instance.collection('medicines').get();
    setState(() {
      medicines = snapshot.docs
          .map((doc) => Medicine.fromFirestore(doc))
          .toList();
      filteredMedicines = medicines;
    });
  }

  // Filter medicines based on search
  void _filterMedicines() {
    setState(() {
      filteredMedicines = medicines.where((medicine) {
        return medicine.name.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Repository'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Medicines',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => _filterMedicines(),
            ),
            SizedBox(height: 10),

            // Display medicines in a GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, // Maximum width per card
                  mainAxisSpacing: 8.0, // Vertical space between cards
                  crossAxisSpacing: 8.0, // Horizontal space between cards
                ),
                itemCount: filteredMedicines.length,
                itemBuilder: (context, index) {
                  var medicine = filteredMedicines[index];
                  return Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        // Navigate to the MedicineDetailScreen on tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicineDetailScreen(medicine: {
                              'name': medicine.name,
                              'description': medicine.description,
                              'type': medicine.type,
                              'indication': medicine.indication, // You can modify this field accordingly
                              'contraindication': medicine.contraindication, // You can modify this field accordingly
                              'dosage': medicine.dosage, // Add dosage if available
                              'half_life': medicine.half_life, // Add half-life if available
                              'onset_of_action': medicine.onset_of_action, // Add onset_of_action if available
                            }),
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
                              FontAwesomeIcons.pills, // Pill icon from FontAwesome
                              size: 50,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 8),
                            Text(
                              medicine.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text(
                              medicine.type,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
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
    );
  }
}
