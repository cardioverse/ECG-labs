import 'package:cloud_firestore/cloud_firestore.dart';
import '../medicine_repo/medicine.dart';

class MedicineRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch medicines from Firestore
  Future<List<Medicine>> getMedicines() async {
    QuerySnapshot snapshot = await _firestore.collection('medicines').get();
    return snapshot.docs.map((doc) {
      return Medicine(
        id: doc.id,
        name: doc['name'],
        type: doc['type'],
        indication: doc['indication'],
        contraindication: doc['contraindication'],
        dosage: doc['dosage'],
      );
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
      return Medicine(
        id: doc.id,
        name: doc['name'],
        type: doc['type'],
        indication: doc['indication'],
        contraindication: doc['contraindication'],
        dosage: doc['dosage'],
      );
    }).toList();
  }
}
