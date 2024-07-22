// lib/widgets/admin_edit_form.dart

import 'package:flutter/material.dart';

class AdminEditForm extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final List<Widget> formFields;
  final VoidCallback onSave;

  AdminEditForm({
    required this.title,
    required this.formKey,
    required this.formFields,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // You can change the color here
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              ...formFields,
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onSave,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // You can change the color here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
