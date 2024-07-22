// lib/pages/admin_page_notifications.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPageNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Notifications').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title'] ?? 'No title'),
                subtitle: Text(data['message'] ?? 'No message'),
                trailing: Text(data['timestamp'] != null
                    ? (data['timestamp'] as Timestamp).toDate().toString()
                    : 'No date'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
