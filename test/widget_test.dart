// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:employee_directory_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const EmployeeDirectoryApp());

    // Verify that the title 'Employee Directory' is on the screen.
    expect(find.text('Employee Directory'), findsOneWidget);

    // Verify that the 'Fetch Employees' button is present.
    expect(find.byIcon(Icons.download), findsOneWidget);
    expect(find.text('Fetch Employees'), findsOneWidget);
  });
}
