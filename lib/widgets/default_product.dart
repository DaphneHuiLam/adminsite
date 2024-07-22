// lib/widgets/default_product.dart

import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DefaultProduct {
  static Widget getDefaultProductImage({double size = 100.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[200],
      ),
      child: Icon(
        Icons.photo,
        size: size * 0.6,
        color: primaryColor2,
      ),
    );
  }
}
