class Employee {
  final int id;
  final String employeeName;
  final int employeeSalary;
  final int employeeAge;
  final String profileImage;

  Employee({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });

  // Factory constructor for JSON parsing
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      employeeName: json['employee_name'] ?? 'Unknown',
      employeeSalary: json['employee_salary'] ?? 0,
      employeeAge: json['employee_age'] ?? 0,
      profileImage: json['profile_image'] ?? '',
    );
  }

  // Convert to JSON map for local caching
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_name': employeeName,
      'employee_salary': employeeSalary,
      'employee_age': employeeAge,
      'profile_image': profileImage,
    };
  }
}
