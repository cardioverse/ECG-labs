import 'package:flutter/material.dart';

class QRSComplexNamingScreen extends StatelessWidget {
  final List<Map<String, String>> qrsComplexes = [
    {"name": "R", "image": "assets/images/qrs_r.png"},
    {"name": "Rs", "image": "assets/images/qrs_rs.png"},
    {"name": "rS", "image": "assets/images/qrs_rs_small.png"},
    {"name": "qRs", "image": "assets/images/qrs_qrs.png"},
    {"name": "QR", "image": "assets/images/qrs_qr.png"},
    {"name": "QS", "image": "assets/images/qrs_qs.png"},
    {"name": "Qr", "image": "assets/images/qrs_qr_small.png"},
    {"name": "rsR'", "image": "assets/images/qrs_rsr_prime.png"},
    {"name": "qR", "image": "assets/images/qrs_qr_big.png"},
    {"name": "rR'", "image": "assets/images/qrs_rr_prime.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRS Complex Naming Convention'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: qrsComplexes.length,
        itemBuilder: (context, index) {
          final complex = qrsComplexes[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complex["name"]!,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    complex["image"]!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
