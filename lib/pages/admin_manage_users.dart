// lib/pages/admin_manage_users.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/admin_edit_users.dart';
import '../widgets/custom_table.dart';
import '../widgets/search_bar.dart' as custom;
import '../services/search_service.dart';
import '../theme/colors.dart';

class AdminManageUsers extends StatefulWidget {
  final SearchService searchService;

  AdminManageUsers({required this.searchService});

  @override
  _AdminManageUsersState createState() => _AdminManageUsersState();
}

class _AdminManageUsersState extends State<AdminManageUsers> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  List<Map<String, dynamic>> _filteredData = [];
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    QuerySnapshot snapshot = await users.get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return {
        'irID': data['irID'],
        'irName': data['irName'],
        'email': data['email'],
        'userType': data['userType'],
        'name': data['name'],
        'password': data['password'],
        'profilePicture': data['profilePicture'],
        'id': doc.id,
      };
    }).toList();

    setState(() {
      _data = allData;
      _filteredData = allData;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredData = _data.where((user) {
        return user['irName'].toLowerCase().contains(query.toLowerCase()) ||
            user['email'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showDetailsDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('User Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('IR ID: ${user['irID']}',
                    style: TextStyle(color: textColor3)),
                Text('IR Name: ${user['irName']}',
                    style: TextStyle(color: textColor3)),
                Text('Email: ${user['email']}',
                    style: TextStyle(color: textColor3)),
                Text('User Type: ${user['userType']}',
                    style: TextStyle(color: textColor3)),
                Text('Name: ${user['name']}',
                    style: TextStyle(color: textColor3)),
                Text('Password: ${user['password']}',
                    style: TextStyle(color: textColor3)),
                user['profilePicture'] != null
                    ? Image.network(
                        user['profilePicture'],
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Image could not be loaded.',
                              style: TextStyle(color: Colors.red));
                        },
                      )
                    : Container(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditUser(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminEditUsers(
          user: user,
          onSave: _fetchData, // Refresh data after saving
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        custom.SearchBar(
          searchService: widget.searchService,
          onSearchChanged: _onSearchChanged,
          pageTitle: 'Manage Users',
        ),
        Expanded(
          child: CustomTable(
            columnTitles: ['IR ID', 'IR Name', 'Email', 'User Type', 'Actions'],
            data: _filteredData,
            fieldMapping: {
              'IR ID': 'irID',
              'IR Name': 'irName',
              'Email': 'email',
              'User Type': 'userType',
              'Actions': 'actions'
            },
            onAddPressed: () {
              // Implement add user functionality
            },
            onInfoPressed: (item) {
              _showDetailsDialog(item);
            },
            onEditPressed: (item) {
              _navigateToEditUser(item);
            },
            onDeletePressed: (item) {
              _showDeleteConfirmationDialog(context, item['id']);
            },
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                users.doc(docId).delete();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
