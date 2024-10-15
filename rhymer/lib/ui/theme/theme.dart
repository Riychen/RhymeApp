import 'package:flutter/material.dart';

const primaryColor = Color(0xFFF82B10);
final themeData = ThemeData(
  dividerTheme: DividerThemeData(color: Colors.grey.withOpacity(0.1)),
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: const Color(0xffeff1f3),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: TextStyle(fontSize: 28,
    fontWeight: FontWeight.w600)
  )
);