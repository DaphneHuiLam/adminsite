// lib/theme/theme.dart

import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor1,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor1,
    secondary: secondaryColor2,
    background: backgroundColor1,
    surface: backgroundColor1,
  ),
  scaffoldBackgroundColor: backgroundColor1,
  textTheme: const TextTheme(
    headlineLarge:
        TextStyle(color: textColor3, fontSize: 32, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: textColor3, fontSize: 20),
    titleMedium: TextStyle(color: textColor2, fontSize: 16),
    bodyLarge: TextStyle(color: textColor1),
    bodyMedium: TextStyle(color: secondaryColor1),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor1,
    iconTheme: IconThemeData(color: secondaryColor2),
    titleTextStyle: TextStyle(
      color: secondaryColor2,
      fontSize: 20,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor2,
      foregroundColor: Colors.white,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: secondaryColor2,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor2,
  ),
  cardTheme: CardTheme(
    color: backgroundColor1,
    shadowColor: secondaryColor2,
    margin: EdgeInsets.all(8.0),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: backgroundColor1,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: secondaryColor2),
    ),
  ),
);
