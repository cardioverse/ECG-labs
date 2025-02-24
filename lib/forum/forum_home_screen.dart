// forum_home_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_detail_screen.dart';
import 'new_post_screen.dart';

class ForumHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Forum')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('forums').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['title']),
                subtitle: Text('By: ${doc['author']}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostDetailScreen(postId: doc.id)),
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
