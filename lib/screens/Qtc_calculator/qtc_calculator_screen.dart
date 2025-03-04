import 'package:flutter/material.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class QTcCalculatorScreen extends StatefulWidget {
  const QTcCalculatorScreen({super.key});

  @override
  _QTcCalculatorScreenState createState() => _QTcCalculatorScreenState();
}

class _QTcCalculatorScreenState extends State<QTcCalculatorScreen> {
  double _qtValue = 400;
  double _rrValue = 1000;
  double _hrValue = 60;

  String? _selectedFormula = 'Bazett';
  String _selectedGender = 'Male';
  String? _result;

  final List<String> _formulas = [
    'Bazett',
    'Fridericia',
    'Hodges',
    'Framingham',
  ];

  final Map<String, String> _formulaDescriptions = {
    'Bazett': "Bazett's formula is commonly used but tends to overestimate QTc at high heart rates.",
    'Fridericia': "Fridericia's formula adjusts better for high heart rates and is often used in research.",
    'Hodges': "Hodges' formula provides a correction based on heart rate, useful for intermediate cases.",
    'Framingham': "Framingham’s formula is an alternative correction that accounts for RR interval changes."
  };

  int _currentFormulaIndex = 0;

  Color _sheetColor = Colors.white;

  bool _showWalkthrough = false;
  double _maxChildSize = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QTc Calculator'),
        actions: [
          DropdownButton<String>(
            value: _selectedGender,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.blue,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGender = newValue!;
                _calculateQTc();
              });
            },
            items: <String>['Male', 'Female']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Correction Formula',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 160,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentFormulaIndex = index;
                          _selectedFormula = _formulas[index];
                          _calculateQTc();
                        });
                      },
                    ),
                    items: _formulas.map((formula) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formula,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _formulaDescriptions[formula] ?? '',
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  _buildCard('QT Interval (ms)', 300, 500, _qtValue, (value) {
                    setState(() {
                      _qtValue = value;
                      _calculateQTc();
                    });
                  }),
                  _buildCard('RR Interval (ms)', 400, 2000, _rrValue, (value) {
                    setState(() {
                      _rrValue = value;
                      _calculateQTc();
                    });
                  }),
                  _buildCard('Heart Rate (bpm)', 30, 150, _hrValue, (value) {
                    setState(() {
                      _hrValue = value;
                      _calculateQTc();
                    });
                  }, optional: true),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.15,
              maxChildSize: _maxChildSize,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: _sheetColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'QTc - $_result ms',
                                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _selectedGender == 'Male'
                                    ? _buildNormalRangeCard('Normal Ranges - Male', [
                                  {'< 450 ms': 'Normal'},
                                  {'450 - 470 ms': 'Borderline'},
                                  {'> 470 ms': 'Prolonged'},
                                ])
                                    : _buildNormalRangeCard('Normal Ranges - Female', [
                                  {'< 460 ms': 'Normal'},
                                  {'460 - 480 ms': 'Borderline'},
                                  {'> 480 ms': 'Prolonged'},
                                ]),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showWalkthrough = !_showWalkthrough;
                                      _maxChildSize = _showWalkthrough ? 0.85 : 0.5;
                                    });
                                  },
                                  child: _buildWideInfoCard('Calculation Details', [
                                    _getCalculationDetails(),
                                  ]),
                                ),
                                if (_showWalkthrough)
                                  Column(
                                    children: [
                                      _buildWideInfoCard("Step 1", ["Take the RR Interval (in seconds): ${(_rrValue / 1000).toStringAsFixed(2)} s"]),
                                      _buildWideInfoCard("Step 2", ["Calculate the square root of RR: ${sqrt(_rrValue / 1000).toStringAsFixed(2)}"]),
                                      _buildWideInfoCard("Step 3", ["Divide QT by √RR: $_qtValue / ${sqrt(_rrValue / 1000).toStringAsFixed(2)}"]),
                                      _buildWideInfoCard("Result", ["QTc = $_result ms"]),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String label, double min, double max, double value, ValueChanged<double> onChanged, {bool optional = false}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CupertinoSlider(
                    value: value,
                    min: min,
                    max: max,
                    onChanged: onChanged,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: TextEditingController(text: value.toStringAsFixed(0)),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (input) {
                      final newValue = double.tryParse(input);
                      if (newValue != null && newValue >= min && newValue <= max) {
                        onChanged(newValue);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> content) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (String line in content)
              Text(
                line,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideInfoCard(String title, List<String> content) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              for (String line in content)
                Text(
                  line,
                  style: const TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNormalRangeCard(String title, List<Map<String, String>> content) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: content.map((range) {
                String key = range.keys.first;
                String value = range.values.first;
                return Column(
                  children: [
                    Text(
                      key,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(String stepTitle, String description) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stepTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateQTc() {
    final qt = _qtValue.toInt();
    final rr = _rrValue.toInt();
    final hr = _hrValue.toInt();

    double rrInterval = rr / 1000;
    double qtc;

    switch (_selectedFormula) {
      case 'Bazett':
        qtc = qt / sqrt(rrInterval);
        break;
      case 'Fridericia':
        qtc = qt / pow(rrInterval, 1 / 3);
        break;
      case 'Hodges':
        qtc = qt + 1.75 * (hr - 60);
        break;
      case 'Framingham':
        qtc = qt + 0.154 * (1 - rrInterval);
        break;
      default:
        qtc = qt / sqrt(rrInterval);
    }

    setState(() {
      _result = qtc.toStringAsFixed(0);
      if (qtc < 450) {
        _sheetColor = Colors.greenAccent;
      } else if (qtc >= 450 && qtc <= 470) {
        _sheetColor = Colors.yellowAccent;
      } else {
        _sheetColor = Colors.redAccent;
      }
    });
  }

  String _getCalculationDetails() {
    final qt = _qtValue.toInt();
    final rr = _rrValue.toInt();
    final hr = _hrValue.toInt();

    double rrInterval = rr / 1000;
    String details;

    switch (_selectedFormula) {
      case 'Bazett':
        details = "QTc = QT / √(RR)\nQTc = $qt / √($rrInterval)";
        break;
      case 'Fridericia':
        details = "QTc = QT / (RR^(1/3))\nQTc = $qt / ($rrInterval^(1/3))";
        break;
      case 'Hodges':
        details = "QTc = QT + 1.75 * (HR - 60)\nQTc = $qt + 1.75 * ($hr - 60)";
        break;
      case 'Framingham':
        details = "QTc = QT + 0.154 * (1 - RR)\nQTc = $qt + 0.154 * (1 - $rrInterval)";
        break;
      default:
        details = "QTc = QT / √(RR)\nQTc = $qt / √($rrInterval)";
    }

    return details;
  }
}
