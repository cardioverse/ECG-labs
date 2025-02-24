// post_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('forums').doc(postId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var post = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(post['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(post['content']),
              ),
              Divider(),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('forums').doc(postId).collection('comments').orderBy('timestamp', descending: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                    return ListView(
                      children: snapshot.data!.docs.map((doc) {
                        return ListTile(
                          title: Text(doc['content']),
                          subtitle: Text('By: ${doc['author']}'),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
