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
  double userProgress = 0; // To track user progress as a percentage

  // Local cache to store user data
  static String? cachedUserName;
  static String? cachedUserId;

  @override
  void initState() {
    super.initState();

    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _fetchUserData(user.uid); // Fetch data when user logs in
      } else {
        setState(() {
          userName = ""; // Reset on logout
          userId = "";
          userProgress = 0;
          cachedUserName = null; // Clear cached data
          cachedUserId = null;
          isLoading = false;
        });
      }
    });
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      // Fetch user's full name and progress from Firestore
      DocumentSnapshot userInfo = await _firestore.collection('users').doc(uid).get();
      DocumentSnapshot progressInfo = await _firestore.collection('userProgress').doc(uid).get();

      setState(() {
        userId = uid;
        if (userInfo.exists && userInfo['full_name'] != null) {
          userName = userInfo['full_name'];
        } else {
          userName = "User";
        }

        // Calculate user's progress based on the number of completed topics
        if (progressInfo.exists) {
          Map<String, dynamic> progressData = progressInfo.data() as Map<String, dynamic>;
          int completedTopics = progressData.values.where((completed) => completed == true).length;
          int totalTopics = progressData.length;
          userProgress = completedTopics / totalTopics;
        } else {
          userProgress = 0;
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
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Padding(
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
                          userName.isEmpty ? 'Hello, Guest' : 'Hello, $userName', // Update greeting
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
              // Learning Progress Overview Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Learning Progress Overview',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),  // Added space for separation

              // Expansion Cards Section
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
        ),
        // "Ready to learn?" floating message
        if (userProgress == 0)
          Positioned(
            bottom: 80, // Adjust based on the position above the nav bar
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Ready to learn? Visit the Learn section!',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
