// lib/pages/companies_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class CompaniesPage extends StatefulWidget {
  @override
  _CompaniesPageState createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  final FirestoreService _firestoreService = FirestoreService();
  String _searchQuery = "";

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
                _buildCompanyTable(constraints),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "Company Management",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search companies",
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
      cursorColor: Colors.blue,
      selectionControls: MaterialTextSelectionControls(),
      onChanged: (value) {
        setState(() {
          _searchQuery = value.trim().toLowerCase();
        });
      },
    );
  }

  Widget _buildCompanyTable(BoxConstraints constraints) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.companiesCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No companies found'));
                }

                final companies = snapshot.data!.docs.where((doc) {
                  final companyName =
                      doc['name']?.toString().toLowerCase() ?? '';
                  return companyName.contains(_searchQuery);
                }).toList();

                return DataTable(
                  columns: _buildColumns(),
                  rows: _buildRows(companies),
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey[200]!),
                  dataRowColor: MaterialStateColor.resolveWith((states) {
                    return states.contains(MaterialState.hovered)
                        ? Colors.grey[100]!
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
      DataColumn(label: Text('Company ID')),
      DataColumn(label: Text('Company Name')),
      DataColumn(label: Text('Attendee Count')),
      DataColumn(label: Text('Users')),
    ];
  }

  List<DataRow> _buildRows(List<QueryDocumentSnapshot> companies) {
    return companies.asMap().entries.map((entry) {
      final index = entry.key + 1; // Row number
      final company = entry.value;

      return DataRow(
        cells: <DataCell>[
          DataCell(Text('$index')), // Row number cell
          DataCell(Text(company.id)), // Company ID
          DataCell(Text(company['name'] ?? '')), // Company Name
          DataCell(FutureBuilder<int>(
            future: _updateAndGetAttendeeCount(company.id, company['name']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error');
              }
              return Text(snapshot.data.toString());
            },
          )), // Attendee Count
          DataCell(FutureBuilder<List<String>>(
            future: _getUserNamesForCompany(company['name']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error');
              }
              final users = snapshot.data ?? [];
              return Text(users.join(", "));
            },
          )), // Users List
        ],
      );
    }).toList();
  }

  Future<int> _updateAndGetAttendeeCount(
      String companyId, String companyName) async {
    // Get the list of users where the company field is similar to the companyName
    final usersSnapshot =
        await _firestoreService.getUsersForSimilarCompany(companyName);
    final attendeeCount =
        usersSnapshot.length; // Correctly access the length of the list

    // Update the attendee count in the companies collection
    await _firestoreService.updateAttendeeCount(companyId, attendeeCount);

    return attendeeCount;
  }

  Future<List<String>> _getUserNamesForCompany(String companyName) async {
    // Get the list of users where the company field is similar to the companyName
    final usersSnapshot =
        await _firestoreService.getUsersForSimilarCompany(companyName);
    // Extract and return the full names of the users
    return usersSnapshot
        .map((doc) => doc['name'] as String)
        .toList(); // Correctly map the list
  }
}
