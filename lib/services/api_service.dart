import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/employee.dart';

class ApiService {
  final Dio _dio = Dio();
  static const String _url =
      'https://dummy.restapiexample.com/api/v1/employees';

  // Fetch data using Dio
  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        // Some APIs return string instead of parsed JSON, so we handle both
        final Map<String, dynamic> responseData = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        // Check if the API returned a success status
        if (responseData['status'] == 'success') {
          final List<dynamic> data = responseData['data'];
          // Parse the JSON objects into Employee objects
          return data.map((json) => Employee.fromJson(json)).toList();
        } else {
          throw Exception(
            responseData['message'] ?? 'Failed to load data from API.',
          );
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Dio specific error handling
      if (e.response?.statusCode == 429) {
        throw Exception(
          'Too Many Requests: The server is busy, please try again later.',
        );
      } else if (e.response != null) {
        throw Exception(
          'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
      } else {
        throw Exception(
          'Network Error: Please check your internet connection.',
        );
      }
    } catch (e) {
      // Clean up the exception string if necessary
      final errorMsg = e.toString();
      if (errorMsg.startsWith('Exception: ')) {
        throw Exception(errorMsg.substring(11));
      }
      throw Exception('Unexpected Error: $e');
    }
  }
}
