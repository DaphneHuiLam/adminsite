// lib/pages/admin_manage_third_party_collects.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_table.dart';
import '../widgets/search_bar.dart' as custom;
import '../services/search_service.dart';
import '../theme/colors.dart';
import 'admin_edit_third_party_collects.dart'; // Import AdminEditThirdPartyCollects

class AdminManageThirdPartyCollects extends StatefulWidget {
  final SearchService searchService;

  AdminManageThirdPartyCollects({required this.searchService});

  @override
  _AdminManageThirdPartyCollectsState createState() =>
      _AdminManageThirdPartyCollectsState();
}

class _AdminManageThirdPartyCollectsState
    extends State<AdminManageThirdPartyCollects> {
  final CollectionReference thirdPartyCollects =
      FirebaseFirestore.instance.collection('ThirdPartyCollect');
  List<Map<String, dynamic>> _filteredData = [];
  List<Map<String, dynamic>> _data = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      QuerySnapshot snapshot = await thirdPartyCollects.get();
      List<Map<String, dynamic>> allData = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        var orders = data['orders'] as List<dynamic>? ?? [];
        var orderData =
            orders.isNotEmpty ? orders[0] as Map<String, dynamic> : {};
        return {
          'orderID': orderData['orderID'],
          'purchaserName': data['purchaserName'],
          'collectorName': data['collectorName'],
          'authorizationStatus': data['authorizationStatus'],
          'orderStatus': data['orderStatus'],
          'purchaseDate': (data['purchaseDate'] as Timestamp?)
              ?.toDate()
              .toString()
              .split(' ')[0],
          'authorizeTimestamp': (data['authorizeTimestamp'] as Timestamp?)
              ?.toDate()
              .toString()
              .split(' ')[0],
          'id': doc.id,
          'collectorIRID': data['collectorIRID'],
          'purchaserIRID': data['purchaserIRID'],
          'orders': data['orders'],
        };
      }).toList();

      setState(() {
        _data = allData;
        _filteredData = allData;
        _loading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredData = _data.where((collect) {
        return collect['purchaserName']
                ?.toLowerCase()
                ?.contains(query.toLowerCase()) ??
            false ||
                collect['orderID']
                    ?.toLowerCase()
                    ?.contains(query.toLowerCase()) ??
            false;
      }).toList();
    });
  }

  void _showDetailsDialog(Map<String, dynamic> collect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Third Party Collect Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Order ID: ${collect['orderID']}',
                    style: TextStyle(color: textColor3)),
                Text('Purchaser Name: ${collect['purchaserName']}',
                    style: TextStyle(color: textColor3)),
                Text('Collector Name: ${collect['collectorName']}',
                    style: TextStyle(color: textColor3)),
                Text('Authorization Status: ${collect['authorizationStatus']}',
                    style: TextStyle(color: textColor3)),
                Text('Order Status: ${collect['orderStatus']}',
                    style: TextStyle(color: textColor3)),
                Text('Purchase Date: ${collect['purchaseDate']}',
                    style: TextStyle(color: textColor3)),
                Text('Authorize Timestamp: ${collect['authorizeTimestamp']}',
                    style: TextStyle(color: textColor3)),
                Text('Collector IRID: ${collect['collectorIRID']}',
                    style: TextStyle(color: textColor3)),
                Text('Purchaser IRID: ${collect['purchaserIRID']}',
                    style: TextStyle(color: textColor3)),
                ...?collect['orders']?.asMap().entries.map((entry) {
                  int index = entry.key;
                  var order = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ${index + 1}:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor3)),
                      Text('Order ID: ${order['orderID']}',
                          style: TextStyle(color: textColor3)),
                      Text('Products:', style: TextStyle(color: textColor3)),
                      ...?order['products']
                          ?.asMap()
                          .entries
                          .map((productEntry) {
                        int productIndex = productEntry.key;
                        var product = productEntry.value;
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product ${productIndex + 1}:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor3),
                              ),
                              Text(
                                'Product ID: ${product['productID']}',
                                style: TextStyle(color: textColor3),
                              ),
                              Text(
                                'Product Name: ${product['productName']}',
                                style: TextStyle(color: textColor3),
                              ),
                              Text(
                                'Quantity: ${product['quantity']}',
                                style: TextStyle(color: textColor3),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                }),
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

  void _navigateToEditCollect(Map<String, dynamic> collect) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminEditThirdPartyCollects(
          collect: collect,
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
          pageTitle: 'Manage Third Party Collects',
        ),
        Expanded(
          child: _loading
              ? Center(child: CircularProgressIndicator())
              : CustomTable(
                  columnTitles: [
                    'Order ID',
                    'Purchaser Name',
                    'Collector Name',
                    'Authorization Status',
                    'Order Status',
                    'Purchase Date',
                    'Authorize Timestamp',
                    'Actions'
                  ],
                  data: _filteredData,
                  fieldMapping: {
                    'Order ID': 'orderID',
                    'Purchaser Name': 'purchaserName',
                    'Collector Name': 'collectorName',
                    'Authorization Status': 'authorizationStatus',
                    'Order Status': 'orderStatus',
                    'Purchase Date': 'purchaseDate',
                    'Authorize Timestamp': 'authorizeTimestamp',
                    'Actions': 'actions'
                  },
                  onAddPressed: () {
                    // Implement add third party collect functionality
                  },
                  onInfoPressed: (item) {
                    _showDetailsDialog(item);
                  },
                  onEditPressed: (item) {
                    _navigateToEditCollect(item);
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
          title: Text('Delete Third Party Collect'),
          content:
              Text('Are you sure you want to delete this third party collect?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                thirdPartyCollects.doc(docId).delete();
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
