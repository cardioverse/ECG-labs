import 'package:flutter/material.dart';
import 'afib_screen.dart';
import 'atrial_flutter_screen.dart';
import 'svt_screen.dart';
import 'vt_screen.dart';
import 'vfib_screen.dart';
import 'torsades_screen.dart';
import 'pac_screen.dart';
import 'pvc_screen.dart';
import 'first_degree_av_block_screen.dart';
import 'mobitz_type_1_screen.dart';
import 'mobitz_type_2_screen.dart';
import 'third_degree_av_block_screen.dart';
import 'wpw_screen.dart';
import 'lgl_screen.dart';
import 'long_qt_screen.dart';
import 'hyperkalemia_screen.dart';
import 'hypokalemia_screen.dart';
import 'brugada_syndrome_screen.dart';
import 'digitalis_toxicity_screen.dart';
import 'wellens_syndrome_screen.dart';
import 'pe_screen.dart';

class AbnormalitiesScreen extends StatelessWidget {
  final List<Abnormality> abnormalities = [
    Abnormality(
      title: 'Atrial Fibrillation (AFib)',
      severityColor: Colors.redAccent, // High Risk
      screen: AfibScreen(),
    ),
    Abnormality(
      title: 'Atrial Flutter',
      severityColor: Colors.orange, // Moderate Risk
      screen: AtrialFlutterScreen(),
    ),
    Abnormality(
      title: 'Supraventricular Tachycardia (SVT)',
      severityColor: Colors.redAccent, // High Risk
      screen: SVTScreen(),
    ),
    Abnormality(
      title: 'Ventricular Tachycardia (VT)',
      severityColor: Colors.red, // High Risk
      screen: VTScreen(),
    ),
    Abnormality(
      title: 'Ventricular Fibrillation (VFib)',
      severityColor: Colors.red, // High Risk
      screen: VFibScreen(),
    ),
    Abnormality(
      title: 'Torsades de Pointes',
      severityColor: Colors.red, // High Risk
      screen: TorsadesScreen(),
    ),
    Abnormality(
      title: 'Premature Atrial Contraction (PAC)',
      severityColor: Colors.green, // Mild Risk
      screen: PACScreen(),
    ),
    Abnormality(
      title: 'Premature Ventricular Contraction (PVC)',
      severityColor: Colors.green, // Mild Risk
      screen: PVCScreen(),
    ),
    Abnormality(
      title: 'First Degree AV Block',
      severityColor: Colors.green, // Mild Risk
      screen: FirstDegreeAVBlockScreen(),
    ),
    Abnormality(
      title: 'Mobitz Type I (Wenckebach)',
      severityColor: Colors.yellow, // Moderate Risk
      screen: MobitzType1Screen(),
    ),
    Abnormality(
      title: 'Mobitz Type II',
      severityColor: Colors.orange, // Moderate Risk
      screen: MobitzType2Screen(),
    ),
    Abnormality(
      title: 'Third Degree AV Block',
      severityColor: Colors.orange, // Moderate Risk
      screen: ThirdDegreeAVBlockScreen(),
    ),
    Abnormality(
      title: 'Wolff-Parkinson-White Syndrome (WPW)',
      severityColor: Colors.yellow, // Moderate Risk
      screen: WPWScreen(),
    ),
    Abnormality(
      title: 'Lown-Ganong-Levine Syndrome (LGL)',
      severityColor: Colors.yellow, // Moderate Risk
      screen: LGLScreen(),
    ),
    Abnormality(
      title: 'Long QT Syndrome',
      severityColor: Colors.orange, // Moderate Risk
      screen: LongQTScreen(),
    ),
    Abnormality(
      title: 'Hyperkalemia',
      severityColor: Colors.orange, // Moderate Risk
      screen: HyperkalemiaScreen(),
    ),
    Abnormality(
      title: 'Hypokalemia',
      severityColor: Colors.orange, // Moderate Risk
      screen: HypokalemiaScreen(),
    ),
    Abnormality(
      title: 'Brugada Syndrome',
      severityColor: Colors.redAccent, // High Risk
      screen: BrugadaSyndromeScreen(),
    ),
    Abnormality(
      title: 'Digitalis Toxicity',
      severityColor: Colors.orange, // Moderate Risk
      screen: DigitalisToxicityScreen(),
    ),
    Abnormality(
      title: 'Wellens Syndrome',
      severityColor: Colors.red, // High Risk
      screen: WellensSyndromeScreen(),
    ),
    Abnormality(
      title: 'Pulmonary Embolism (PE)',
      severityColor: Colors.orange, // Moderate Risk
      screen: PEScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abnormalities'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Severity: ', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                SizedBox(width: 8.0),
                _buildSeverityIndicator('Mild', color: Colors.green),
                SizedBox(width: 16.0),
                _buildSeverityIndicator('Moderate', color: Colors.yellow),
                SizedBox(width: 16.0),
                _buildSeverityIndicator('High', color: Colors.red),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: abnormalities.length,
                itemBuilder: (context, index) {
                  return _buildAbnormalityCard(context, abnormalities[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeverityIndicator(String label, {Color color = Colors.green}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: color,
        ),
        SizedBox(width: 8.0),
        Text(label, style: TextStyle(fontSize: 14.0)),
      ],
    );
  }

  Widget _buildAbnormalityCard(BuildContext context, Abnormality abnormality) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: abnormality.severityColor,
        ),
        title: Text(
          abnormality.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => abnormality.screen,
            ),
          );
        },
      ),
    );
  }
}

class Abnormality {
  final String title;
  final Color severityColor;
  final Widget screen;

  Abnormality({
    required this.title,
    required this.severityColor,
    required this.screen,
  });
}
