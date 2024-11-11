import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecg_trainer/progress_card/progress_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECG Trainer'),
      ),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userProgress = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProgress();
  }

  Future<void> _fetchUserProgress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      try {
        DocumentSnapshot userDoc = await _firestore.collection('userProgress').doc(uid).get();
        setState(() {
          if (userDoc.exists) {
            userProgress = userDoc.data() as Map<String, dynamic>? ?? {};
          } else {
            userProgress = {};
          }
          isLoading = false;
        });
      } catch (e) {
        print('Error fetching user progress: $e');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          CustomExpansionCard(
            sectionTitle: 'Pure Basics',
            topics: [
              'Rate',
              'Rhythm',
              'Grid',
              'Axis Calculation',
              'Lead Positioning',
            ],
            userProgress: userProgress,
          ),
          SizedBox(height: 20),
          CustomExpansionCard(
            sectionTitle: 'Waves',
            topics: [
              'P-wave',
              'QRS Complex',
              'T-wave',
              'R-wave',
              'Q-wave',
              'S-wave',
              'J-wave',
            ],
            userProgress: userProgress,
          ),
          SizedBox(height: 20),
          CustomExpansionCard(
            sectionTitle: 'Segments/Intervals',
            topics: [
              'PR interval',
              'ST segment',
              'PR segment',
              'QT interval',
            ],
            userProgress: userProgress,
          ),
        ],
      ),
    );
  }
}
