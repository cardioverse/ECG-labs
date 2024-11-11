import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          SectionProgressTracker(
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
          SectionProgressTracker(
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
          SectionProgressTracker(
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

class SectionProgressTracker extends StatefulWidget {
  final String sectionTitle;
  final List<String> topics;
  final Map<String, dynamic> userProgress;

  SectionProgressTracker({required this.sectionTitle, required this.topics, required this.userProgress});

  @override
  _SectionProgressTrackerState createState() => _SectionProgressTrackerState();
}

class _SectionProgressTrackerState extends State<SectionProgressTracker> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    int completedCount = widget.topics.where((topic) {
      String topicKey;
      if (topic == 'Lead Positioning') {
        topicKey = 'completedTopics.leadPositioning';
      } else if (topic == 'Axis Calculation') {
        topicKey = 'completedTopics.axisCalculation';
      } else if (topic == 'QRS Complex') {
        topicKey = 'completedTopics.qrsComplex';
      } else if (topic == 'T-wave') {
        topicKey = 'completedTopics.tWave';
      } else if (topic == 'P-wave') {
        topicKey = 'completedTopics.pWave';
      } else if (topic == 'R-wave') {
        topicKey = 'completedTopics.rWave';
      } else if (topic == 'Q-wave') {
        topicKey = 'completedTopics.qWave';
      } else if (topic == 'S-wave') {
        topicKey = 'completedTopics.sWave';
      } else if (topic == 'J-wave') {
        topicKey = 'completedTopics.jWave';
      } else if (topic == 'PR interval') {
        topicKey = 'completedTopics.prInterval';
      } else if (topic == 'ST segment') {
        topicKey = 'completedTopics.stSegment';
      } else if (topic == 'PR segment') {
        topicKey = 'completedTopics.prSegment';
      } else if (topic == 'QT interval') {
        topicKey = 'completedTopics.qtInterval';
      } else {
        topicKey = 'completedTopics.${topic.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '')}';
      }
      return widget.userProgress[topicKey] == true;
    }).length;

    return Card(
      color: Colors.grey[900],
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.sectionTitle,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[700],
                    child: Text(
                      '$completedCount/${widget.topics.length}',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              if (_isExpanded)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: widget.topics.map((topic) {
                      String topicKey;
                      if (topic == 'Lead Positioning') {
                        topicKey = 'completedTopics.leadPositioning';
                      } else if (topic == 'Axis Calculation') {
                        topicKey = 'completedTopics.axisCalculation';
                      } else if (topic == 'QRS Complex') {
                        topicKey = 'completedTopics.qrsComplex';
                      } else if (topic == 'T-wave') {
                        topicKey = 'completedTopics.tWave';
                      } else if (topic == 'P-wave') {
                        topicKey = 'completedTopics.pWave';
                      } else if (topic == 'R-wave') {
                        topicKey = 'completedTopics.rWave';
                      } else if (topic == 'Q-wave') {
                        topicKey = 'completedTopics.qWave';
                      } else if (topic == 'S-wave') {
                        topicKey = 'completedTopics.sWave';
                      } else if (topic == 'J-wave') {
                        topicKey = 'completedTopics.jWave';
                      } else if (topic == 'PR interval') {
                        topicKey = 'completedTopics.prInterval';
                      } else if (topic == 'ST segment') {
                        topicKey = 'completedTopics.stSegment';
                      } else if (topic == 'PR segment') {
                        topicKey = 'completedTopics.prSegment';
                      } else if (topic == 'QT interval') {
                        topicKey = 'completedTopics.qtInterval';
                      } else {
                        topicKey = 'completedTopics.${topic.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '')}';
                      }
                      bool isCompleted = widget.userProgress[topicKey] ?? false;
                      return ListTile(
                        title: Text(topic, style: TextStyle(color: Colors.white)),
                        trailing: Icon(
                          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: isCompleted ? Colors.green : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
