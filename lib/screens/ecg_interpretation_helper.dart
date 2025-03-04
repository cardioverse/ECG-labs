import 'package:flutter/material.dart';

class ECGInterpretationHelper extends StatefulWidget {
  const ECGInterpretationHelper({super.key});

  @override
  _ECGInterpretationHelperState createState() => _ECGInterpretationHelperState();
}

class _ECGInterpretationHelperState extends State<ECGInterpretationHelper> {
  // User selections
  String? selectedHeartRate;
  String? selectedHeartRhythm;
  String? selectedPWave;
  String? selectedPRInterval;
  String? selectedQRSComplex;
  String? selectedSTSegment;
  String? selectedTWave;
  String? selectedQTInterval;
  String? selectedRelationPQRS;
  String? selectedBundleBranch;

  // Possible values for each criterion
  final heartRateOptions = ['Normal', 'Tachycardia', 'Bradycardia'];
  final heartRhythmOptions = ['Regular', 'Irregular'];
  final pWaveOptions = ['Normal', 'Abnormal P Wave', 'No P Wave'];
  final prIntervalOptions = ['Normal', 'Short', 'Prolonged'];
  final qrsComplexOptions = ['Normal', 'Narrow', 'Wide'];
  final stSegmentOptions = ['Normal', 'Elevated', 'Depressed'];
  final tWaveOptions = ['Normal', 'Inverted', 'Peaked', 'Flat'];
  final qtIntervalOptions = ['Normal', 'Prolonged', 'Short'];
  final relationPQRSOptions = [
    '1:1 Normal',
    'Dropped QRS 2° AVB',
    '1:1 (Prolonged PR) 1° AVB',
    'Complete dissociation 3° AVB'
  ];
  final bundleBranchOptions = [
    'LAFB',
    'RBBB',
    'LBBB',
    'LPF',
    'Bifascicular block',
    'Trifascicular block'
  ];

  // Rules for diagnoses
  final diagnosisRules = [
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'P Wave': 'Normal',
        'PR Interval': 'Normal',
        'QRS Complex': 'Normal'
      },
      'diagnosis': 'Normal Sinus Rhythm',
    },
    {
      'criteria': {
        'Heart Rate': 'Tachycardia',
        'P Wave': 'Normal',
        'PR Interval': 'Normal',
        'QRS Complex': 'Narrow'
      },
      'diagnosis': 'Sinus Tachycardia',
    },
    {
      'criteria': {
        'Heart Rate': 'Bradycardia',
        'P Wave': 'Normal',
        'PR Interval': 'Prolonged'
      },
      'diagnosis': 'First-Degree AV Block',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'P Wave': 'Abnormal P Wave',
        'QRS Complex': 'Normal'
      },
      'diagnosis': 'Atrial Enlargement (Right or Left)',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'P Wave': 'No P Wave',
        'Heart Rhythm': 'Irregular',
        'QRS Complex': 'Narrow'
      },
      'diagnosis': 'Atrial Fibrillation',
    },
    {
      'criteria': {
        'Heart Rate': 'Tachycardia',
        'P Wave': 'Abnormal P Wave',
        'QRS Complex': 'Narrow',
        'PR Interval': 'Normal'
      },
      'diagnosis': 'Atrial Tachycardia',
    },
    {
      'criteria': {
        'Heart Rate': 'Tachycardia',
        'P Wave': 'Normal',
        'QRS Complex': 'Wide',
        'Bundle Branch': 'RBBB'
      },
      'diagnosis': 'Sinus Tachycardia with Right Bundle Branch Block',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'PR Interval': 'Short',
        'QRS Complex': 'Wide'
      },
      'diagnosis': 'Wolff-Parkinson-White Syndrome',
    },
    {
      'criteria': {
        'Heart Rhythm': 'Regular',
        'P Wave': 'Normal',
        'QT Interval': 'Prolonged'
      },
      'diagnosis': 'Long QT Syndrome',
    },
    {
      'criteria': {
        'Heart Rate': 'Bradycardia',
        'Relation P-QRS': 'Dropped QRS 2° AVB',
        'PR Interval': 'Prolonged'
      },
      'diagnosis': 'Second-Degree AV Block (Mobitz Type I or II)',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'Relation P-QRS': 'Complete dissociation 3° AVB',
        'Bundle Branch': 'RBBB'
      },
      'diagnosis': 'Third-Degree AV Block with Right Bundle Branch Block',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'ST Segment': 'Elevated',
        'T Wave': 'Peaked'
      },
      'diagnosis': 'Myocardial Infarction (STEMI)',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'QT Interval': 'Short',
        'T Wave': 'Peaked'
      },
      'diagnosis': 'Hypercalcemia',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'ST Segment': 'Depressed',
        'T Wave': 'Inverted'
      },
      'diagnosis': 'Myocardial Ischemia',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'P Wave': 'Normal',
        'PR Interval': 'Normal',
        'QRS Complex': 'Wide',
        'Bundle Branch': 'LBBB'
      },
      'diagnosis': 'Normal Sinus Rhythm with Left Bundle Branch Block',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'Bundle Branch': 'Trifascicular block'
      },
      'diagnosis': 'Trifascicular Block',
    },
    {
      'criteria': {
        'Heart Rate': 'Tachycardia',
        'Relation P-QRS': 'Complete dissociation 3° AVB',
        'QRS Complex': 'Wide'
      },
      'diagnosis': 'Ventricular Tachycardia with Complete AV Dissociation',
    },
    {
      'criteria': {
        'Heart Rate': 'Normal',
        'T Wave': 'Flat',
        'QT Interval': 'Prolonged'
      },
      'diagnosis': 'Hypokalemia',
    },
    {
      'criteria': {
        'Heart Rate': 'Tachycardia',
        'P Wave': 'No P Wave',
        'QRS Complex': 'Wide'
      },
      'diagnosis': 'Ventricular Tachycardia',
    },
  ];

  // Function to determine possible diagnoses
  List<String> getPossibleDiagnoses() {
    List<String> possibleDiagnoses = [];

    for (var rule in diagnosisRules) {
      bool match = true;
      (rule['criteria'] as Map<String, String>).forEach((key, value) {
        if ((key == 'Heart Rate' && value != selectedHeartRate) ||
            (key == 'Heart Rhythm' && value != selectedHeartRhythm) ||
            (key == 'P Wave' && value != selectedPWave) ||
            (key == 'PR Interval' && value != selectedPRInterval) ||
            (key == 'QRS Complex' && value != selectedQRSComplex) ||
            (key == 'ST Segment' && value != selectedSTSegment) ||
            (key == 'T Wave' && value != selectedTWave) ||
            (key == 'QT Interval' && value != selectedQTInterval) ||
            (key == 'Relation P-QRS' && value != selectedRelationPQRS) ||
            (key == 'Bundle Branch' && value != selectedBundleBranch)) {
          match = false;
        }
      });

      if (match) {
        possibleDiagnoses.add(rule['diagnosis'] as String);
      }
    }

    return possibleDiagnoses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ECG Interpretation Helper'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildButtonGroup('Heart Rate', heartRateOptions, selectedHeartRate,
                    (value) => setState(() {
                  selectedHeartRate = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('Heart Rhythm', heartRhythmOptions, selectedHeartRhythm,
                    (value) => setState(() {
                  selectedHeartRhythm = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('P Wave', pWaveOptions, selectedPWave,
                    (value) => setState(() {
                  selectedPWave = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('PR Interval', prIntervalOptions, selectedPRInterval,
                    (value) => setState(() {
                  selectedPRInterval = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('QRS Complex', qrsComplexOptions, selectedQRSComplex,
                    (value) => setState(() {
                  selectedQRSComplex = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('ST Segment', stSegmentOptions, selectedSTSegment,
                    (value) => setState(() {
                  selectedSTSegment = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('T Wave', tWaveOptions, selectedTWave,
                    (value) => setState(() {
                  selectedTWave = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('QT Interval', qtIntervalOptions, selectedQTInterval,
                    (value) => setState(() {
                  selectedQTInterval = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('Relation P-QRS', relationPQRSOptions, selectedRelationPQRS,
                    (value) => setState(() {
                  selectedRelationPQRS = value;
                  getPossibleDiagnoses();
                })),
            buildButtonGroup('Bundle Branch', bundleBranchOptions, selectedBundleBranch,
                    (value) => setState(() {
                  selectedBundleBranch = value;
                  getPossibleDiagnoses();
                })),
            const SizedBox(height: 20),
            const Text(
              'Possible Diagnoses:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              getPossibleDiagnoses().isNotEmpty
                  ? getPossibleDiagnoses().join(', ')
                  : 'No matching diagnosis found',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonGroup(String label, List<String> options, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedValue == option,
              onSelected: (isSelected) {
                if (isSelected) {
                  onChanged(option);
                }
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
