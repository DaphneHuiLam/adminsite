// assign_collector_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignCollectorPage extends StatefulWidget {
  final DocumentSnapshot document;

  AssignCollectorPage({required this.document});

  @override
  _AssignCollectorPageState createState() => _AssignCollectorPageState();
}

class _AssignCollectorPageState extends State<AssignCollectorPage> {
  final TextEditingController _collectorIRIDController =
      TextEditingController();
  final TextEditingController _collectorNameController =
      TextEditingController();

  void _assignCollector() {
    widget.document.reference.update({
      'collectorIRID': _collectorIRIDController.text,
      'collectorName': _collectorNameController.text,
    }).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Collector assigned')));
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to assign collector: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Collector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _collectorIRIDController,
              decoration: InputDecoration(labelText: 'Collector IRID'),
            ),
            TextField(
              controller: _collectorNameController,
              decoration: InputDecoration(labelText: 'Collector Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _assignCollector,
              child: Text('Assign Collector'),
            ),
          ],
        ),
      ),
    );
  }
}
