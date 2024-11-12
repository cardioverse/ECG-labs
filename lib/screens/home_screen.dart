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

class _HomeContentState extends State<HomeContent> with AutomaticKeepAliveClientMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  String userName = "";
  String userId = "";

  // Local cache to store user data
  static String? cachedUserName;
  static String? cachedUserId;

  @override
  void initState() {
    super.initState();
    _fetchUserProgress();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _fetchUserProgress() async {
    // Check if data is already cached
    if (cachedUserName != null && cachedUserId != null) {
      setState(() {
        userName = cachedUserName!;
        userId = cachedUserId!;
        isLoading = false;
      });
      return;
    }

    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      try {
        // Fetch user's full name from Firestore
        DocumentSnapshot userInfo = await _firestore.collection('users').doc(uid).get();
        setState(() {
          userId = uid;
          // Get user's full name
          if (userInfo.exists && userInfo['full_name'] != null) {
            userName = userInfo['full_name'];
          } else {
            userName = "User";
          }
          // Cache the data
          cachedUserName = userName;
          cachedUserId = userId;
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
    super.build(context);
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
            userId: userId,
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
            userId: userId,
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
            userId: userId,
          ),
        ],
      ),
    );
  }
}
