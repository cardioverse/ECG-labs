import 'package:flutter/material.dart';

/// Data Model for Medicine
class Medicine {
  final String id;
  final String name;
  final String type; // e.g., Tablet, Syrup, Injection
  final String indication; // What it's used for
  final String contraindication; // What it shouldn't be used for
  final int dosage; // Dosage in mg

  Medicine({
    required this.id,
    required this.name,
    required this.type,
    required this.indication,
    required this.contraindication,
    required this.dosage,
  });
}

/// Repository to manage Medicine data
class MedicineRepository {
  final List<Medicine> _medicines = [
    Medicine(
      id: '1',
      name: 'Aspirin',
      type: 'Tablet',
      indication: 'Pain relief, cardiovascular conditions',
      contraindication: 'Stomach ulcers, bleeding disorders',
      dosage: 75,
    ),
    Medicine(
      id: '2',
      name: 'Metoprolol',
      type: 'Tablet',
      indication: 'Hypertension, arrhythmia',
      contraindication: 'Severe bradycardia, hypotension',
      dosage: 50,
    ),
    Medicine(
      id: '3',
      name: 'Amiodarone',
      type: 'Injection',
      indication: 'Ventricular arrhythmias',
      contraindication: 'Thyroid dysfunction, pregnancy',
      dosage: 150,
    ),
  ];

  List<Medicine> getMedicines() {
    return _medicines;
  }

  List<Medicine> searchMedicines(String query) {
    return _medicines.where((medicine) {
      return medicine.name.toLowerCase().contains(query.toLowerCase()) ||
          medicine.indication.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

/// Main List Screen for Medicines
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
    _medicines = _repository.getMedicines();
  }

  void _searchMedicines(String query) {
    setState(() {
      _searchQuery = query;
      _medicines = _repository.searchMedicines(query);
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
            child: ListView.builder(
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
            ),
          ),
        ],
      ),
    );
  }
}

/// Detail Screen for a single Medicine
class MedicineDetailScreen extends StatelessWidget {
  final Medicine medicine;

  MedicineDetailScreen({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${medicine.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Type: ${medicine.type}'),
            SizedBox(height: 8),
            Text('Dosage: ${medicine.dosage} mg'),
            SizedBox(height: 8),
            Text('Indication: ${medicine.indication}'),
            SizedBox(height: 8),
            Text('Contraindication: ${medicine.contraindication}'),
          ],
        ),
      ),
    );
  }
}
