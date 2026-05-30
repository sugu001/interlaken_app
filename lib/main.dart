import 'package:flutter/material.dart';

import 'utils/app_colors.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const InterlakenApp());
}

class InterlakenApp extends StatelessWidget {
  const InterlakenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interlaken Attractions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
