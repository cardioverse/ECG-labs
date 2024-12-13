import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../medicine_repo/medicine.dart'; // Import the global Medicine class
import 'medicine_detail_screen.dart';
/// Repository to manage Medicine data with Firestore
class MedicineRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch medicines from Firestore
  Future<List<Medicine>> getMedicines() async {
    QuerySnapshot snapshot = await _firestore.collection('medicines').get();
    return snapshot.docs.map((doc) {
      return Medicine.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // Search medicines in Firestore
  Future<List<Medicine>> searchMedicines(String query) async {
    QuerySnapshot snapshot = await _firestore
        .collection('medicines')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    return snapshot.docs.map((doc) {
      return Medicine.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}

class MedicineListScreen extends StatefulWidget {
  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  final MedicineRepository _repository = MedicineRepository();
  List<Medicine> _medicines = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchMedicines(); // Fetch medicines from Firestore on init
  }

  // Fetch medicines from Firestore
  Future<void> _fetchMedicines() async {
    final medicines = await _repository.getMedicines();
    setState(() {
      _medicines = medicines;
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
