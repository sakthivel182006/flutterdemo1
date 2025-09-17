import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/main.dart'; // Replace with your actual app name

void main() {
  testWidgets('Auth screen is shown when not logged in', (
    WidgetTester tester,
  ) async {
    // Mock SharedPreferences to return no user data
    SharedPreferences.setMockInitialValues({});

    // Build our app
    await tester.pumpWidget(MainApp());

    // Verify that the auth screen is shown
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('Login form has email and password fields', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(MainApp());

    expect(
      find.byType(TextFormField),
      findsNWidgets(2),
    ); // Email and password fields
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Register form has name, email and password fields', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(MainApp());

    // Tap the register button to switch to register form
    await tester.tap(find.text('Don\'t have an account? Register'));
    await tester.pump();

    expect(
      find.byType(TextFormField),
      findsNWidgets(3),
    ); // Name, email and password fields
    expect(find.text('Register'), findsOneWidget);
  });
}
