import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const EmployeeDirectoryApp());
}

class EmployeeDirectoryApp extends StatelessWidget {
  const EmployeeDirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Directory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
