import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaseView extends StatefulWidget {
  final String category;

  const CaseView({super.key, required this.category});

  @override
  _CaseViewState createState() => _CaseViewState();
}

class _CaseViewState extends State<CaseView> {
  Map<String, dynamic>? caseData;
  String? selectedAnswer;
  bool isAnswered = false;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchCase();
  }

  Future<void> fetchCase() async {
    setState(() {
      isLoading = true;
      isAnswered = false;
      selectedAnswer = null;
    });

    var querySnapshot = await FirebaseFirestore.instance
        .collection('cases')
        .where('category', isEqualTo: widget.category.toLowerCase())
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

    setState(() {
      isLoading = false;
    });
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
      appBar: AppBar(title: const Text('Case View')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (caseData == null || caseData!.isEmpty)
          ? const Center(child: Text('No cases available for this category.'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Case Details Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      caseData!['title'],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(caseData!['description']),
                    const SizedBox(height: 10),
                    const Text('ECG Findings:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(caseData!['ecg_findings']),
                    if (caseData!['echo'] != null) ...[
                      const SizedBox(height: 10),
                      const Text('Echo Findings:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(caseData!['echo']),
                    ],
                    if (caseData!['xray'] != null) ...[
                      const SizedBox(height: 10),
                      const Text('X-ray Findings:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(caseData!['xray']),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Question
            Text(
              'Question: ${caseData!['question']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Answer Options
            Column(
              children: List.generate(caseData!['options'].length, (index) {
                String option = caseData!['options'][index];
                bool isCorrect = option == caseData!['correct_answer'];
                bool isSelected = selectedAnswer == option;

                return Card(
                  child: ListTile(
                    title: Text(option),
                    tileColor: isAnswered
                        ? (isCorrect ? Colors.green : isSelected ? Colors.red : null)
                        : null,
                    onTap: isAnswered ? null : () => checkAnswer(option),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // Explanation and "Next Case" Button
            if (isAnswered)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explanation:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    caseData!['explanation'],
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: fetchCase,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text("Next Case", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
