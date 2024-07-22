// lib/widgets/back_button.dart
// wf - 21 lines

import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true).pop(),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor1,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(Icons.arrow_back, color: secondaryColor2),
      ),
    );
  }
}
