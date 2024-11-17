import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FAQItem(
              question: 'What is ECG Labs?',
              answer:
              'ECG Labs is an app developed by Cardioverse to provide a comprehensive and user-friendly platform for learning ECG interpretation skills.',
            ),
            FAQItem(
              question: 'How do I reset my app data?',
              answer:
              'To reset your app data, go to the Settings screen and click on the "Reset Data" button. This action will delete all user progress and cannot be undone.',
            ),
            FAQItem(
              question: 'Can I toggle notifications in the app?',
              answer:
              'Yes, you can toggle notifications in the Settings screen by clicking on the "Notification" button.',
            ),
            FAQItem(
              question: 'How do I update my profile information?',
              answer:
              'To update your profile information, go to the Settings screen and click on the "Profile" button. You will be redirected to the Profile screen where you can make changes.',
            ),
            FAQItem(
              question: 'How can I contact Cardioverse?',
              answer:
              'You can contact Cardioverse via our social media channels or visit our website. Links are available in the About section of the Settings screen.',
            ),
            FAQItem(
              question: 'Is ECG Labs free to use?',
              answer:
              'Yes, ECG Labs offers a free version with core features. However, there may be premium content available for purchase.',
            ),
            FAQItem(
              question: 'How do I report a bug or issue?',
              answer:
              'To report a bug or issue, please go to the About section in the Settings screen and click on "Report a Problem". You can also contact us through our social media channels.',
            ),
            FAQItem(
              question: 'Can I use ECG Labs offline?',
              answer:
              'Some features of ECG Labs are available offline, but for the best experience, we recommend using the app with an active internet connection.',
            ),
            FAQItem(
              question: 'How do I delete my account?',
              answer:
              'To delete your account, go to the Settings screen and click on the "Delete Account" button. Please note that this action is irreversible.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
