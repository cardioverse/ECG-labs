// case_simulator.dart

import 'package:flutter/material.dart';
import 'case_view.dart';

class CaseSimulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Case Simulator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOption(context, 'Basic', Colors.blue),
            _buildOption(context, 'Intermediate', Colors.orange),
            _buildOption(context, 'Advanced', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CaseView()),
          );
        },
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

