import 'package:flutter/material.dart';
import 'package:read_json_data/pages/employees_list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: EmployeesListPage()),
    );
  }
}
