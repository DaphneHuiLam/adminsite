// lib/widgets/switch_button.dart

import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  SwitchButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}
