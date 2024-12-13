import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all medicines from Firestore
  Future<List<Map<String, dynamic>>> getMedicines() async {
    try {
      // Access the 'medicines' collection in Firestore
      QuerySnapshot querySnapshot = await _firestore.collection('medicines').get();

      // Map the documents to a list of maps
      List<Map<String, dynamic>> medicines = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return medicines;
    } catch (e) {
      print("Error fetching medicines: $e");
      return [];
    }
  }
}
