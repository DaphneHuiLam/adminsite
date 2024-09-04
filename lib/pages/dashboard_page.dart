// lib/pages/dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardPage extends StatelessWidget {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference companiesCollection =
      FirebaseFirestore.instance.collection('companies');

  DashboardPage({Key? key}) : super(key: key);

  // Assume these numbers are predefined for the planned participants
  final int plannedCompanies = 35;
  final int plannedRepresentatives = 120;

  // Function to fetch total companies recorded in the database
  Future<int> _fetchTotalCompaniesRecorded() async {
    final querySnapshot = await companiesCollection.get();
    return querySnapshot.docs.length;
  }

  // Function to fetch total users recorded in the database
  Future<int> _fetchTotalUsersRecorded() async {
    final querySnapshot = await usersCollection.get();
    return querySnapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDashboardCard(
                title: 'Total Representatives',
                icon: Icons.people_outline,
                future: _fetchTotalUsersRecorded(),
                unit: 'Users',
                backgroundColor: Colors.white,
              ),
              SizedBox(width: 20),
              _buildDashboardCard(
                title: 'Total Companies',
                icon: Icons.business_outlined,
                future: _fetchTotalCompaniesRecorded(),
                unit: 'Companies',
                backgroundColor: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 20),

          // Summary Section
          FutureBuilder<List<int>>(
            future: Future.wait([
              _fetchTotalCompaniesRecorded(),
              _fetchTotalUsersRecorded(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available');
              } else {
                final totalCompaniesRecorded = snapshot.data![0];
                final totalUsersRecorded = snapshot.data![1];

                String companiesStatus = '';
                String representativesStatus = '';

                if (totalCompaniesRecorded == plannedCompanies) {
                  companiesStatus =
                      'All planned companies have successfully registered.';
                } else {
                  companiesStatus =
                      '$totalCompaniesRecorded out of $plannedCompanies planned companies have registered.';
                }

                if (totalUsersRecorded == plannedRepresentatives) {
                  representativesStatus =
                      'All planned representatives have successfully registered.';
                } else {
                  representativesStatus =
                      '$totalUsersRecorded out of $plannedRepresentatives planned representatives have registered.';
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary of 2024',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    _buildSummaryRow(
                      label: 'Planned Companies:',
                      value: '$plannedCompanies',
                    ),
                    SizedBox(height: 10),
                    _buildSummaryRow(
                      label: 'Planned Representatives:',
                      value: '$plannedRepresentatives',
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    _buildSummaryRow(
                      label: 'Total Companies in Database:',
                      value: '$totalCompaniesRecorded',
                    ),
                    SizedBox(height: 10),
                    _buildSummaryRow(
                      label: 'Total Users in Database:',
                      value: '$totalUsersRecorded',
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      companiesStatus,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      representativesStatus,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Widget to build each statistics card
  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Future<int> future,
    required String unit,
    required Color backgroundColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: FutureBuilder<int>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildCardContent(
                icon: icon,
                title: title,
                content: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return _buildCardContent(
                icon: icon,
                title: title,
                content: Text('Error: ${snapshot.error}'),
              );
            } else {
              final count = snapshot.data!;
              return _buildCardContent(
                icon: icon,
                title: title,
                content: Text(
                  '$count $unit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCardContent({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 48, color: Color(0xFF1A73E8)),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 10),
        content,
      ],
    );
  }

  // Widget to build each summary row
  Widget _buildSummaryRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
