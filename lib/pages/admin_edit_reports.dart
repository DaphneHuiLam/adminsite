// lib/pages/admin_edit_reports.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/colors.dart';
import '../widgets/admin_edit_form.dart'; // Import AdminEditForm

class AdminEditReports extends StatefulWidget {
  final Map<String, dynamic> report;
  final Function onSave;

  AdminEditReports({required this.report, required this.onSave});

  @override
  _AdminEditReportsState createState() => _AdminEditReportsState();
}

class _AdminEditReportsState extends State<AdminEditReports> {
  final CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('Reports');
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _reportIDController;
  late TextEditingController _reportNameController;
  late TextEditingController _reportStatusController;
  late TextEditingController _reportDateController;
  late TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _reportIDController =
        TextEditingController(text: widget.report['reportID']);
    _reportNameController =
        TextEditingController(text: widget.report['reportName']);
    _reportStatusController =
        TextEditingController(text: widget.report['reportStatus']);
    _reportDateController =
        TextEditingController(text: widget.report['reportDate']);
    _detailsController = TextEditingController(text: widget.report['details']);
  }

  Future<void> _saveReport() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedReport = {
        'reportID': _reportIDController.text,
        'reportName': _reportNameController.text,
        'reportStatus': _reportStatusController.text,
        'reportDate': _reportDateController.text,
        'details': _detailsController.text,
      };

      await reportsCollection.doc(widget.report['id']).update(updatedReport);
      widget.onSave();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminEditForm(
      title: 'Edit Report',
      formKey: _formKey,
      formFields: [
        TextFormField(
          controller: _reportIDController,
          decoration: InputDecoration(
            labelText: 'Report ID',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Report ID';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _reportNameController,
          decoration: InputDecoration(
            labelText: 'Report Name',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Report Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _reportStatusController,
          decoration: InputDecoration(
            labelText: 'Report Status',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Report Status';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _reportDateController,
          decoration: InputDecoration(
            labelText: 'Report Date',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Report Date';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _detailsController,
          decoration: InputDecoration(
            labelText: 'Details',
            labelStyle: TextStyle(color: textColor3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Details';
            }
            return null;
          },
        ),
      ],
      onSave: _saveReport,
    );
  }
}
