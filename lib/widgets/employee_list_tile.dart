import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../screens/details_screen.dart';

class EmployeeListTile extends StatelessWidget {
  final Employee employee;

  const EmployeeListTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(
          employee.employeeName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Salary: \$${employee.employeeSalary}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigate to details screen passing the selected employee data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(employee: employee),
            ),
          );
        },
      ),
    );
  }
}
