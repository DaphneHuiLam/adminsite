// lib/pages/admin_manage_orders.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_table.dart';
import '../widgets/search_bar.dart' as custom;
import '../services/search_service.dart';
import '../theme/colors.dart';
import 'admin_edit_orders.dart'; // Import AdminEditOrders

class AdminManageOrders extends StatefulWidget {
  final SearchService searchService;

  AdminManageOrders({required this.searchService});

  @override
  _AdminManageOrdersState createState() => _AdminManageOrdersState();
}

class _AdminManageOrdersState extends State<AdminManageOrders> {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('Orders');
  List<Map<String, dynamic>> _filteredData = [];
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    QuerySnapshot snapshot = await orders.get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return {
        'orderID': data['orderID'],
        'irName': data['irName'],
        'orderStatus': data['orderStatus'],
        'purchaseDate': (data['purchaseDate'] as Timestamp?)
            ?.toDate()
            .toString()
            .split(' ')[0],
        'id': doc.id,
        'assignStatus': data['assignStatus'],
        'irID': data['irID'],
        'orderReceived': data['orderReceived'],
        'orders': data['orders'],
        'order1': data['order1'],
        'order2': data['order2'],
      };
    }).toList();

    setState(() {
      _data = allData;
      _filteredData = allData;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredData = _data.where((order) {
        return order['irName']?.toLowerCase()?.contains(query.toLowerCase()) ??
            false ||
                order['orderID']
                    ?.toLowerCase()
                    ?.contains(query.toLowerCase()) ??
            false;
      }).toList();
    });
  }

  void _showDetailsDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // show detail button
          title: Text('Order Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Order ID: ${order['orderID']}',
                    style: TextStyle(color: textColor3)),
                Text('IR Name: ${order['irName']}',
                    style: TextStyle(color: textColor3)),
                Text('Order Status: ${order['orderStatus']}',
                    style: TextStyle(color: textColor3)),
                Text('Purchase Date: ${order['purchaseDate']}',
                    style: TextStyle(color: textColor3)),
                Text('Assign Status: ${order['assignStatus']}',
                    style: TextStyle(color: textColor3)),
                Text('IR ID: ${order['irID']}',
                    style: TextStyle(color: textColor3)),
                Text('Order Received: ${order['orderReceived']}',
                    style: TextStyle(color: textColor3)),
                if (order['orders'] != null)
                  ...order['orders']
                      .entries
                      .map((e) => Text('${e.key}: ${e.value}')),
                if (order['order1'] != null)
                  ...order['order1']
                      .entries
                      .map((e) => Text('${e.key}: ${e.value}')),
                if (order['order2'] != null)
                  ...order['order2']
                      .entries
                      .map((e) => Text('${e.key}: ${e.value}')),
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

  void _navigateToEditOrder(Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminEditOrders(
          order: order,
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
          pageTitle: 'Manage Orders',
        ),
        Expanded(
          child: CustomTable(
            columnTitles: [
              'Order ID',
              'IR Name',
              'Order Status',
              'Purchase Date',
              'Actions'
            ],
            data: _filteredData,
            fieldMapping: {
              'Order ID': 'orderID',
              'IR Name': 'irName',
              'Order Status': 'orderStatus',
              'Purchase Date': 'purchaseDate',
              'Actions': 'actions'
            },
            onAddPressed: () {
              // Implement add order functionality
            },
            onInfoPressed: (item) {
              _showDetailsDialog(item);
            },
            onEditPressed: (item) {
              _navigateToEditOrder(item);
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
          title: Text('Delete Order'),
          content: Text('Are you sure you want to delete this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                orders.doc(docId).delete();
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
