import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCollectPage extends StatefulWidget {
  final DocumentSnapshot document;

  EditCollectPage({required this.document});

  @override
  _EditCollectPageState createState() => _EditCollectPageState();
}

class _EditCollectPageState extends State<EditCollectPage> {
  final TextEditingController _collectorNameController =
      TextEditingController();
  final TextEditingController _orderStatusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _collectorNameController.text = widget.document['collectorName'];
    _orderStatusController.text = widget.document['orderStatus'];
  }

  void _updateCollect() {
    widget.document.reference.update({
      'collectorName': _collectorNameController.text,
      'orderStatus': _orderStatusController.text,
    }).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Collect information updated')));
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update collect: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Collect'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _collectorNameController,
              decoration: InputDecoration(labelText: 'Collector Name'),
            ),
            TextField(
              controller: _orderStatusController,
              decoration: InputDecoration(labelText: 'Order Status'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateCollect,
              child: Text('Update Collect'),
            ),
          ],
        ),
      ),
    );
  }
}
