// lib/pages/admin_page_profile.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPageProfile extends StatelessWidget {
  final String adminId = 'admin_id'; // Replace with actual admin ID
  final String defaultProfilePictureUrl =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fletsenhance.io%2F&psig=AOvVaw3k0Iw8aRHrdE_GzgqeJZQK&ust=1721448846424000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCKDLq-qesocDFQAAAAAdAAAAABAE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('Admins').doc(adminId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Admin profile not found'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final profilePictureUrl =
              data['profilePicture'] ?? defaultProfilePictureUrl;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilePictureUrl),
                  onBackgroundImageError: (_, __) => Icon(Icons.error),
                ),
                SizedBox(height: 10),
                Text('Name: ${data['name'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18)),
                Text('Email: ${data['email'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18)),
                Text('Role: ${data['role'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Edit profile functionality
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
