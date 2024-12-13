import 'package:flutter/material.dart';
import '../medicine_repo/medicine.dart';

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
            Text('Dosage: ${medicine.dosage}'), // Dosage as String
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

