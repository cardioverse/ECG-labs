class Medicine {
  final String id;
  final String name;
  final String type;
  final String indication;
  final String contraindication;
  final double dosage;

  Medicine({
    required this.id,
    required this.name,
    required this.type,
    required this.indication,
    required this.contraindication,
    required this.dosage,
  });

  factory Medicine.fromMap(Map<String, dynamic> data, String id) {
    return Medicine(
      id: id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      indication: data['indication'] ?? '',
      contraindication: data['contraindication'] ?? '',
      dosage: (data['dosage'] ?? 0).toDouble(),
    );
  }

  factory Medicine.fromFirestore(Map<String, dynamic> data) {
    return Medicine.fromMap(data, data['id'] ?? ''); // Assuming Firestore stores an `id` field or use document id
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'indication': indication,
      'contraindication': contraindication,
      'dosage': dosage,
    };
  }
}
