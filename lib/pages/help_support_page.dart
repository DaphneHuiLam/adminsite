// lib/pages/help_support_page.dart

import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        // Added to prevent overflow issues
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            Text(
              'For any project-related support or inquiries, please contact the relevant team member below:',
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
            ),
            SizedBox(height: 20),
            _buildContactSupportSection(),
            SizedBox(height: 40),
            Divider(thickness: 1, color: Colors.grey[300]),
            SizedBox(height: 32),
            _buildTeamIntroductionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "Help & Support",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildContactSupportSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildContactCard(
            role: 'Developer - Mobile App',
            name: 'Leow Hong Zheng',
            contact: 'hongzheng.leow@qiu.edu.my',
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: _buildContactCard(
            role: 'Developer - Admin Site',
            name: 'Daphne Cheong Hui Lam',
            contact: 'daphne.cheong@qiu.edu.my',
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(
      {required String role, required String name, required String contact}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            role,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8), // Space between role and name
          Text(
            name,
            style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
          ),
          SizedBox(height: 4),
          Divider(
              thickness: 1,
              color: Colors.grey[300]), // Divider between name and contact
          SizedBox(height: 4),
          Text(
            contact,
            style: TextStyle(fontSize: 14.0, color: Colors.blue[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamIntroductionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Introduction',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Meet the dedicated team behind FCE Tech Squad \'24:',
          style: TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
        SizedBox(height: 24),
        _buildTeamMember(name: 'Ms. Leong Ying Mei', role: 'Supervisor'),
        SizedBox(height: 14),
        _buildTeamMember(
            name: 'Daphne Cheong Hui Lam', role: 'Developer - Admin Site'),
        SizedBox(height: 14),
        _buildTeamMember(
            name: 'Leow Hong Zheng', role: 'Developer - Mobile App'),
      ],
    );
  }

  Widget _buildTeamMember({required String name, required String role}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          role,
          style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
        ),
      ],
    );
  }
}
