// lib/pages/admin_manage_products.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_table.dart';
import '../widgets/search_bar.dart' as custom;
import '../services/search_service.dart';
import 'admin_edit_products.dart';

class AdminManageProducts extends StatefulWidget {
  final SearchService searchService;

  AdminManageProducts({required this.searchService});

  @override
  _AdminManageProductsState createState() => _AdminManageProductsState();
}

class _AdminManageProductsState extends State<AdminManageProducts> {
  final CollectionReference watches =
      FirebaseFirestore.instance.collection('Watches');
  final CollectionReference wellness =
      FirebaseFirestore.instance.collection('Wellness');
  List<Map<String, dynamic>> _filteredWatches = [];
  List<Map<String, dynamic>> _filteredWellness = [];
  List<Map<String, dynamic>> _watchesData = [];
  List<Map<String, dynamic>> _wellnessData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    QuerySnapshot watchesSnapshot = await watches.get();
    QuerySnapshot wellnessSnapshot = await wellness.get();

    List<Map<String, dynamic>> watchesData = watchesSnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return {
        'productID': data['productID'],
        'productName': data['productName'],
        'irPrice': data['irPrice'],
        'quantity': data['quantity'],
        'id': doc.id,
        'bonusValue': data['bonusValue'],
        'category': data['category'],
        'description': data['description'],
        'gitURL': data['gitURL'],
        'imagePath': data['imagePath'],
        'retailPrice': data['retailPrice'],
        'salesPrice': data['salesPrice'],
      };
    }).toList();

    List<Map<String, dynamic>> wellnessData = wellnessSnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return {
        'productID': data['productID'],
        'productName': data['productName'],
        'irPrice': data['irPrice'],
        'quantity': data['quantity'],
        'id': doc.id,
        'bonusValue': data['bonusValue'],
        'category': data['category'],
        'description': data['description'],
        'gitURL': data['gitURL'],
        'imagePath': data['imagePath'],
        'retailPrice': data['retailPrice'],
        'salesPrice': data['salesPrice'],
      };
    }).toList();

    setState(() {
      _watchesData = watchesData;
      _filteredWatches = watchesData;
      _wellnessData = wellnessData;
      _filteredWellness = wellnessData;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredWatches = _watchesData.where((product) {
        return product['productName']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            product['productID'].toLowerCase().contains(query.toLowerCase());
      }).toList();
      _filteredWellness = _wellnessData.where((product) {
        return product['productName']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            product['productID'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showDetailsDialog(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Product Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Product ID: ${product['productID']}',
                    style: TextStyle(color: Colors.black)),
                Text('Product Name: ${product['productName']}',
                    style: TextStyle(color: Colors.black)),
                Text('IR Price: ${product['irPrice']}',
                    style: TextStyle(color: Colors.black)),
                Text('Quantity: ${product['quantity']}',
                    style: TextStyle(color: Colors.black)),
                Text('Bonus Value: ${product['bonusValue']}',
                    style: TextStyle(color: Colors.black)),
                Text('Category: ${product['category']}',
                    style: TextStyle(color: Colors.black)),
                Text('Description: ${product['description']}',
                    style: TextStyle(color: Colors.black)),
                Text('Git URL: ${product['gitURL']}',
                    style: TextStyle(color: Colors.black)),
                Text('Image Path: ${product['imagePath']}',
                    style: TextStyle(color: Colors.black)),
                Text('Retail Price: ${product['retailPrice']}',
                    style: TextStyle(color: Colors.black)),
                Text('Sales Price: ${product['salesPrice']}',
                    style: TextStyle(color: Colors.black)),
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

  void _navigateToEditPage(Map<String, dynamic> product, String category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AdminEditProducts(category: category, document: product),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
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
          pageTitle: 'Manage Products',
        ),
        Expanded(
          child: ListView(
            children: [
              Text("Watches",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              CustomTable(
                columnTitles: [
                  'Product ID',
                  'Product Name',
                  'IR Price',
                  'Quantity',
                  'Actions'
                ],
                data: _filteredWatches,
                fieldMapping: {
                  'Product ID': 'productID',
                  'Product Name': 'productName',
                  'IR Price': 'irPrice',
                  'Quantity': 'quantity',
                  'Actions': 'actions'
                },
                onAddPressed: () {
                  // Implement add product functionality
                },
                onInfoPressed: (item) {
                  _showDetailsDialog(item);
                },
                onEditPressed: (item) {
                  _navigateToEditPage(item, 'Watches');
                },
                onDeletePressed: (item) {
                  _showDeleteConfirmationDialog(context, item['id']);
                },
              ),
              Text("Wellness",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              CustomTable(
                columnTitles: [
                  'Product ID',
                  'Product Name',
                  'IR Price',
                  'Quantity',
                  'Actions'
                ],
                data: _filteredWellness,
                fieldMapping: {
                  'Product ID': 'productID',
                  'Product Name': 'productName',
                  'IR Price': 'irPrice',
                  'Quantity': 'quantity',
                  'Actions': 'actions'
                },
                onAddPressed: () {
                  // Implement add product functionality
                },
                onInfoPressed: (item) {
                  _showDetailsDialog(item);
                },
                onEditPressed: (item) {
                  _navigateToEditPage(item, 'Wellness');
                },
                onDeletePressed: (item) {
                  _showDeleteConfirmationDialog(context, item['id']);
                },
              ),
            ],
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
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                watches.doc(docId).delete();
                wellness.doc(docId).delete();
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
