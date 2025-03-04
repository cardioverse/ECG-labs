import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _replyController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSubmitting = false; // To prevent duplicate replies

  void _submitReply() async {
    if (_replyController.text.isEmpty || _isSubmitting) return;

    setState(() {
      _isSubmitting = true; // Disable button
    });

    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      String authorName = userDoc.exists && userDoc.data() != null ? userDoc['full_name'] ?? 'Unknown User' : 'Unknown User';

      await FirebaseFirestore.instance.collection('forums').doc(widget.postId).collection('replies').add({
        'author': authorName,
        'content': _replyController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      _replyController.clear();
    }

    setState(() {
      _isSubmitting = false; // Re-enable button
    });
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "Unknown time";
    DateTime dateTime = timestamp.toDate();
    return DateFormat('MMM d, yyyy • h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('forums').doc(widget.postId).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                var post = snapshot.data!;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    post['title'],
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),

                                  // Post Content
                                  Text(
                                    post['content'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 12),

                                  // Author & Timestamp
                                  Text(
                                    'By: ${post['author']} • ${formatTimestamp(post['timestamp'])}',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                        const SizedBox(height: 20),

                        const Text("Replies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),

                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('forums')
                              .doc(widget.postId)
                              .collection('replies')
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                            if (snapshot.data!.docs.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No replies yet. Be the first to reply!", style: TextStyle(color: Colors.grey)),
                              );
                            }

                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs.map((doc) {
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: Icon(Icons.person, color: Colors.white),
                                    ),
                                    title: Text(doc['content']),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('By: ${doc['author']}', style: const TextStyle(fontWeight: FontWeight.w500)),
                                        const SizedBox(height: 4),
                                        Text(formatTimestamp(doc['timestamp']), style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Reply Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: 'Write a reply...',
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _isSubmitting ? null : _submitReply, // Disable tap when submitting
                  child: CircleAvatar(
                    backgroundColor: _isSubmitting ? Colors.grey : Colors.green, // Change color when disabled
                    radius: 22,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
