import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _submitPost() async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      User? user = _auth.currentUser;

      if (user != null) {
        String authorName = 'Unknown User';

        // Fetch the full_name from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          authorName = userDoc['full_name'] ?? 'Unknown User';
        }

        String title = _titleController.text.trim();
        String content = _contentController.text.trim();

        // Check for duplicate post (same title & content)
        QuerySnapshot existingPosts = await FirebaseFirestore.instance
            .collection('forums')
            .where('title', isEqualTo: title)
            .where('content', isEqualTo: content)
            .get();

        if (existingPosts.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("A similar post already exists!"), backgroundColor: Colors.red),
          );
          return;
        }

        // Save the new post to Firestore
        await FirebaseFirestore.instance.collection('forums').add({
          'title': title,
          'content': content,
          'author': authorName,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Post submitted successfully!"), backgroundColor: Colors.green),
        );

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _titleController.clear();
                      _contentController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Clear', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}