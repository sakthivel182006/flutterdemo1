import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_user.dart';
import 'user.dart';
import 'admin.dart';
import 'agent.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Main());
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  bool loggedIn = false;
  String? role;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('loggedInEmail');
    final storedRole = prefs.getString('role');
    final userDataString = prefs.getString('userData');

    if (email != null && storedRole != null && userDataString != null) {
      setState(() {
        loggedIn = true;
        role = storedRole.toUpperCase();
        userData = jsonDecode(userDataString);
      });
    }
  }

  void handleLoginSuccess(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInEmail', user['email']);
    await prefs.setString('role', user['role']);
    await prefs.setString('userData', jsonEncode(user));

    setState(() {
      loggedIn = true;
      role = user['role'].toUpperCase();
      userData = user;
    });
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInEmail');
    await prefs.remove('role');
    await prefs.remove('userData');
    await prefs.remove('userId');
    await prefs.remove('userName');
    await prefs.remove('createdAt');

    setState(() {
      loggedIn = false;
      role = null;
      userData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loggedIn) {
      return AuthUser(onLoginSuccess: handleLoginSuccess);
    }

    if (role == 'USER') {
      return User(onLogout: logout, userData: userData);
    } else if (role == 'ADMIN') {
      return Admin(onLogout: logout);
    } else if (role == 'AGENT') {
      return Agent(onLogout: logout);
    } else {
      return User(onLogout: logout, userData: userData);
    }
  }
}
