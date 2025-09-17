import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends StatelessWidget {
  final VoidCallback onLogout;
  final Map<String, dynamic>? userData;

  User({required this.onLogout, this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("User App - Logout"),
          onPressed: onLogout,
        ),
      ),
    );
  }
}
