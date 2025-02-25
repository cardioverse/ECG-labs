import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'post_detail_screen.dart';
import 'new_post_screen.dart';

class ForumHomeScreen extends StatelessWidget {
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "Unknown time";
    DateTime dateTime = timestamp.toDate();
    return DateFormat('MMM d, yyyy • h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Forum')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('forums')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.all(8),
            children: snapshot.data!.docs.map((doc) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    doc['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        doc['content'].toString().length > 50
                            ? doc['content'].toString().substring(0, 50) + '...'
                            : doc['content'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'By: ${doc['author']} • ${formatTimestamp(doc['timestamp'])}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailScreen(postId: doc.id),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewPostScreen()),
        ),
      ),
    );
  }
}
