import 'package:flutter/material.dart';

import '../models/employee.dart';

class DetailsScreen extends StatelessWidget {
  final Employee employee;

  const DetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image (using a placeholder since API returns empty string)
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  employee.employeeName.isNotEmpty
                      ? employee.employeeName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Name
            const Text(
              'Name',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              employee.employeeName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),

            // Position/Age
            const Text(
              'Position / Age',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '${employee.employeeAge} years old',
              style: const TextStyle(fontSize: 18),
            ),
            const Divider(height: 32),

            // Salary
            const Text(
              'Salary',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '\$${employee.employeeSalary}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
