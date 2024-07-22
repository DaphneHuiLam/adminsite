// lib/helpers/user_helper_functions.dart
// wf - 9 lines
// lib/helper/_helper_function.dart

import 'package:flutter/material.dart';

// display error message to user
void displayMessageToUser(String message, BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
