import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firestore dependency
import '../medicine_repo/medicine.dart';
import 'medicine_detail_screen.dart';

class MedicineListScreen extends StatefulWidget {
  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Medicine> _medicines = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
  }

  // Fetch medicines from Firestore
  Future<void> _fetchMedicines() async {
    final snapshot = await _firestore.collection('medicines').get();
    setState(() {
      _medicines = snapshot.docs.map((doc) {
        return Medicine.fromFirestore(doc.data());
      }).toList();
    });
  }

  // Search for medicines
  void _searchMedicines(String query) {
    setState(() {
      _searchQuery = query;
      _medicines = _medicines
          .where((medicine) => medicine.name
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Repository'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchMedicines,
              decoration: InputDecoration(
                hintText: 'Search medicines...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchMedicines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!_medicines.isEmpty) {
                  return ListView.builder(
                    itemCount: _medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = _medicines[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: ListTile(
                          title: Text(medicine.name),
                          subtitle: Text(medicine.indication),
                          trailing: Text('${medicine.dosage} mg'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MedicineDetailScreen(medicine: medicine),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No medicines found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
