// case_view.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaseView extends StatefulWidget {
  final String category;

  const CaseView({Key? key, required this.category}) : super(key: key);

  @override
  _CaseViewState createState() => _CaseViewState();
}

class _CaseViewState extends State<CaseView> {
  Map<String, dynamic>? caseData;
  String? selectedAnswer;
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    fetchCase();
  }

  Future<void> fetchCase() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('cases')
        .where('category', isEqualTo: widget.category.toLowerCase()) // Ensure case consistency
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        caseData = querySnapshot.docs.first.data();
      });
    } else {
      setState(() {
        caseData = {}; // Indicate no cases found
      });
    }
  }


  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isAnswered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Case View')),
      body: caseData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(caseData!['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(caseData!['description']),
                    SizedBox(height: 10),
                    Text('ECG Findings: ${caseData!['ecg_findings']}'),
                    if (caseData!['echo'] != null) ...[
                      SizedBox(height: 10),
                      Text('Echo Findings: ${caseData!['echo']}'),
                    ],
                    if (caseData!['xray'] != null) ...[
                      SizedBox(height: 10),
                      Text('X-ray Findings: ${caseData!['xray']}'),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Question: ${caseData!['question']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...List.generate(caseData!['options'].length, (index) {
              String option = caseData!['options'][index];
              bool isCorrect = option == caseData!['correct_answer'];
              return Card(
                child: ListTile(
                  title: Text(option),
                  tileColor: selectedAnswer == option
                      ? (isCorrect ? Colors.green : Colors.red)
                      : null,
                  onTap: isAnswered ? null : () => checkAnswer(option),
                ),
              );
            }),
            if (isAnswered)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (selectedAnswer != caseData!['correct_answer']) ...[
                      Text('Correct Answer: ${caseData!['correct_answer']}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Explanation: ${caseData!['explanation']}'),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
