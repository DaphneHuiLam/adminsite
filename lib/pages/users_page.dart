// lib/pages/users_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'user_details_dialog.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 20),
                _buildSearchBar(),
                SizedBox(height: 20),
                _buildUserTable(constraints),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "User Management",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search users",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value.trim().toLowerCase();
        });
      },
    );
  }

  Widget _buildUserTable(BoxConstraints constraints) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: StreamBuilder<QuerySnapshot>(
              stream: usersCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No users found'));
                }

                final users = snapshot.data!.docs.where((doc) {
                  final name = doc['name']?.toString().toLowerCase() ?? '';
                  final email = doc['email']?.toString().toLowerCase() ?? '';
                  final company =
                      doc['company']?.toString().toLowerCase() ?? '';
                  final myKadNumber =
                      doc['myKadNumber']?.toString().toLowerCase() ?? '';

                  return name.contains(_searchQuery) ||
                      email.contains(_searchQuery) ||
                      company.contains(_searchQuery) ||
                      myKadNumber.contains(_searchQuery);
                }).toList();

                return DataTable(
                  columns: _buildColumns(),
                  rows: _buildRows(users),
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey[100]!),
                  dataRowColor: MaterialStateColor.resolveWith((states) {
                    return states.contains(MaterialState.hovered)
                        ? Colors.grey[50]!
                        : Colors.white;
                  }),
                  columnSpacing: 24,
                  dividerThickness: 0.5,
                  headingTextStyle: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                  dataTextStyle: TextStyle(color: Colors.grey[800]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return const <DataColumn>[
      DataColumn(label: Text('#')), // Row number column
      DataColumn(label: Text('Full Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Company')),
      DataColumn(label: Text('MyKad Number')),
      DataColumn(label: Text('Position')),
    ];
  }

  List<DataRow> _buildRows(List<QueryDocumentSnapshot> users) {
    return users.asMap().entries.map((entry) {
      final index = entry.key + 1; // Row number
      final user = entry.value;
      return DataRow(
        cells: <DataCell>[
          DataCell(Text('$index')), // Row number cell
          DataCell(Text(user['name'] ?? '')),
          DataCell(Text(user['email'] ?? '')),
          DataCell(Text(user['company'] ?? '')),
          DataCell(Text(user['myKadNumber'] ?? '')),
          DataCell(Text(user['position'] ?? '')),
        ],
        onSelectChanged: (selected) {
          if (selected ?? false) {
            _showUserDetailsDialog(context, user);
          }
        },
      );
    }).toList();
  }

  void _showUserDetailsDialog(
      BuildContext context, QueryDocumentSnapshot user) {
    showDialog(
      context: context,
      builder: (context) => UserDetailsDialog(user: user),
    );
  }
}
