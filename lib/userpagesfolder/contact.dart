import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact extends StatelessWidget {
  final VoidCallback onLogout;

  const Contact({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: onLogout,
          child: Text("Agent App - Logout"),
        ),
      ),
    );
  }
}
