import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecg_trainer/user_authentication/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.person_outline, color: Colors.blue),
                title: Text('Profile'),
                subtitle: Text('Manage your profile information'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.language_outlined, color: Colors.green),
                title: Text('Language'),
                subtitle: Text('Change app language'),
                onTap: () {
                  // Add functionality to change language
                },
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.info_outline, color: Colors.orange),
                title: Text('About'),
                subtitle: Text('Learn more about the app'),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'ECG Trainer',
                    applicationVersion: 'Version 1.0.0',
                    applicationIcon: Icon(Icons.favorite_outline, color: Colors.orange),
                    children: [
                      Text('ECG Trainer is designed to help users learn and understand electrocardiograms.'),
                      SizedBox(height: 10),
                      Text('Developer: Andy'),
                      SizedBox(height: 10),
                      Text('Acknowledgments: Special thanks to the medical community for their invaluable resources.'),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.privacy_tip_outlined, color: Colors.purple),
                title: Text('Privacy Policy'),
                subtitle: Text('View our privacy policy'),
                onTap: () {
                  // Add functionality to show privacy policy
                },
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.support_agent_outlined, color: Colors.red),
                title: Text('Help & Support'),
                subtitle: Text('Get help or contact support'),
                onTap: () {
                  // Add functionality for help & support
                },
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.restart_alt_outlined, color: Colors.teal),
                title: Text('Reset Data'),
                subtitle: Text('Reset all app data'),
                onTap: () {
                  // Add functionality to reset data
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String fullName = '';
  String email = '';
  String age = '';
  String profession = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        fullName = userDoc['full_name'] ?? '';
        email = userDoc['email'] ?? '';
        age = userDoc['age'] ?? '';
        profession = userDoc['profession'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $fullName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Age: $age', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Profession: $profession', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Log out and navigate to LoginScreen
                _auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
