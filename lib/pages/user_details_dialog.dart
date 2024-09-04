// lib/pages/user_details_dialog.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsDialog extends StatelessWidget {
  final QueryDocumentSnapshot user;

  UserDetailsDialog({required this.user});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildDetailRow("Full Name:", user['name']),
              _buildDetailRow("Email:", user['email']),
              _buildDetailRow("Company:", user['company']),
              _buildDetailRow("MyKad Number:", user['myKadNumber']),
              _buildDetailRow("Position:", user['position']),
              _buildDetailRow("Date of Birth:", user['dateOfBirth']),
              _buildImageRow("MyKad Image:", user['myKadImageUrl']),
              _buildImageRow("Selfie Image:", user['selfieUrl']),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 243, 204,
                          204), // Button background color matching the design
                      foregroundColor:
                          Colors.black, // Text color for the button
                    ),
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 204, 204),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(value ?? 'N/A'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageRow(String title, String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          if (imageUrl != null && imageUrl.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              clipBehavior: Clip.hardEdge,
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain, // Ensure the image is fully visible
                  height: 100, // Smaller height for better fit
                  width: 150, // Restrict width for smaller display
                  errorBuilder: (context, error, stackTrace) =>
                      Text('Failed to load image'),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('No image available'),
            ),
        ],
      ),
    );
  }
}
