import 'package:flutter/material.dart';
import 'presentation/pages/dashboard_page.dart';

void main() {
  runApp(const FinTechApp());
}

class FinTechApp extends StatelessWidget {
  const FinTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senior FinTech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF0F0F12),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}
