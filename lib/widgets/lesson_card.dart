import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'models/lesson.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart'; // import the new splash screen

void main() {
  runApp(const NuruLearnApp());
}

class NuruLearnApp extends StatelessWidget {
  const NuruLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NURU Learn',
      theme: ThemeData(
        primaryColor: const Color(0xFF0066CC),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0066CC),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0066CC),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: const SplashScreen(), // launch splash screen first
      debugShowCheckedModeBanner: false,
    );
  }
}
