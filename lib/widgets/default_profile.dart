// lib/widgets/default_profile.dart

import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DefaultProfile {
  static Widget getDefaultProfileImage({double size = 100.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200], // light grey bg
      ),
      child: Icon(
        Icons.person,
        size: size * 0.6,
        color: primaryColor2, // primaryColor2
      ),
    );
  }
}
