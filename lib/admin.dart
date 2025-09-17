import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin extends StatelessWidget {
  final VoidCallback onLogout;

  Admin({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Agent App - Logout"),
          onPressed: onLogout,
        ),
      ),
    );
  }
}
