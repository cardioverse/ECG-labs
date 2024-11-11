import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecg_trainer/progress_card/progress_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  String userName = "";

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
        // Fetch user progress
        DocumentSnapshot userDoc = await _firestore.collection('userProgress').doc(uid).get();
        // Fetch user's full name from Firestore
        DocumentSnapshot userInfo = await _firestore.collection('users').doc(uid).get();
        setState(() {
          if (userDoc.exists) {
            userProgress = userDoc.data() as Map<String, dynamic>? ?? {};
          } else {
            userProgress = {};
          }
          // Get user's full name
          if (userInfo.exists && userInfo['full_name'] != null) {
            userName = userInfo['full_name'];
          } else {
            userName = "User";
          }
          isLoading = false;
        });
      } catch (e) {
        print('Error fetching user progress or user info: $e');
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $userName',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Welcome to ECG Labs',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
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
