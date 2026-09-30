import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../widgets/employee_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  List<Employee> _employees = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Load cached data when the app starts
    _loadCachedData();
  }

  // Phase 2: Load cached data from shared_preferences
  Future<void> _loadCachedData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final cachedEmployees = await _storageService.loadEmployees();
      setState(() {
        _employees = cachedEmployees;
      });
    } catch (e) {
      // Ignore cache errors, will fallback to API call if user taps fetch
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Phase 1 & 2: Fetch API data using Dio, with error handling and caching
  Future<void> _fetchEmployees() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final fetchedEmployees = await _apiService.fetchEmployees();

      setState(() {
        _employees = fetchedEmployees;
      });

      // Cache the newly fetched data
      await _storageService.saveEmployees(fetchedEmployees);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully updated data from API!')),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      // Show user-friendly error message via SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage ?? 'An error occurred'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Directory'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchEmployees,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: Column(
        children: [
          // Phase 1: Button to trigger API call
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.download),
                label: const Text('Fetch Employees'),
                onPressed: _isLoading ? null : _fetchEmployees,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // List View with Loading and Error states
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null && _employees.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '$_errorMessage\n\nTap the fetch button to try again.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _employees.isEmpty
                ? const Center(
                    child: Text(
                      'No employees found.\nTap "Fetch Employees" to start.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _employees.length,
                    itemBuilder: (context, index) {
                      final employee = _employees[index];
                      return EmployeeListTile(employee: employee);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
