import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color.fromARGB(255, 255, 255, 255);
  static final ThemeData ligthTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: primary,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
