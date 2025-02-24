import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecg_trainer/user_authentication/login_screen.dart';
import 'package:ecg_trainer/user_authentication/profile_screen.dart';
import 'package:ecg_trainer/settings_screen/FAQ.dart';
import 'package:ecg_trainer/settings_screen/reminder_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                SettingsCard(
                  icon: Icons.person_outline,
                  iconColor: Colors.white,
                  title: 'Profile',
                  subtitle: 'Manage your profile information',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
                SettingsCard(
                  icon: Icons.restart_alt_outlined,
                  iconColor: Colors.white,
                  title: 'Reset Data',
                  subtitle: 'Reset all app data',
                  onTap: () async {
                    bool confirmReset = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Reset'),
                          content: Text('Are you sure you want to reset all app data? This action cannot be undone.'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            TextButton(
                              child: Text('Reset'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmReset == true) {
                      // Reset user data in Firestore
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await FirebaseFirestore.instance
                            .collection('userProgress')
                            .doc(user.uid)
                            .delete();
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('All app data has been reset.'),
                        ),
                      );
                    }
                  },
                ),
                SettingsCard(
                  icon: Icons.notifications_active_outlined,
                  iconColor: Colors.white,
                  title: 'Reminder',
                  subtitle: 'Set up reminders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReminderSettingsScreen()),
                    );
                  },
                ),


                SettingsCard(
                  icon: Icons.help_outline,
                  iconColor: Colors.white,
                  title: 'Help & FAQ',
                  subtitle: 'Need help? Start here',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Card(
              color: Colors.deepPurple[900],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'ECG Labs',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Version : 1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Developed by Cardioverse to provide a comprehensive, user-friendly learning experience',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Cardioverse is committed to developing practical, user-friendly tools for cardiology education. Through ECG Labs, we aim to bridge the gap between theory and clinical practice, helping professionals hone their ECG interpretation skills.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.language, color: Colors.white),
                          onPressed: () {
                            // Add functionality to open website
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.alternate_email, color: Colors.white),
                          onPressed: () {
                            // Add functionality to open Twitter
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.code, color: Colors.white),
                          onPressed: () {
                            // Add functionality to open GitHub
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.business, color: Colors.white),
                          onPressed: () {
                            // Add functionality to open LinkedIn
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Licenses'),
                              content: SingleChildScrollView(
                                child: Text('This application is licensed under the GNU General Public License v3.0 (GPL-3.0).\n\nUnder this license, you are free to use, modify, and distribute this software, provided that any distribution is also licensed under GPL-3.0. This ensures that the application remains free and open-source.\n\nThe following open-source tools and libraries have been used in this application:\n\n1. Flutter - https://flutter.dev\n2. Firebase - https://firebase.google.com\n3. Additional third-party libraries, each governed by their respective licenses.\n\nFor more details about GPL-3.0, please visit: https://www.gnu.org/licenses/gpl-3.0.html.'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Licenses', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Privacy Policy'),
                              content: SingleChildScrollView(
                                child: Text('Privacy Policy:\n\nWe value your privacy. This application collects data to enhance your experience. None of your personal information will be shared with third parties without your explicit consent. For more details, please visit our official privacy policy page.'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Privacy policy', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  SettingsCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.deepPurple[900],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 7.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 32),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Flexible(
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
