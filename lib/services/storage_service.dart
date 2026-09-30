import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/employee.dart';

class StorageService {
  static const String _cacheKey = 'cached_employees_v1';

  // Save the list of employees to SharedPreferences as a JSON string
  Future<void> saveEmployees(List<Employee> employees) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(
      employees.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_cacheKey, jsonString);
  }

  // Load the list of employees from SharedPreferences
  Future<List<Employee>> loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_cacheKey);

    if (jsonString != null && jsonString.isNotEmpty) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Employee.fromJson(json)).toList();
    }
    return [];
  }
}
