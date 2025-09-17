import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser extends StatefulWidget {
  final Function(Map<String, dynamic>) onLoginSuccess;
  AuthUser({required this.onLoginSuccess});
  @override
  _AuthUserState createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String name = "", email = "", password = "";
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool rememberMe = false;
  bool agreeToTerms = false;

  // Hover states for interactive elements
  bool _isLoginHovered = false;
  bool _isSignupHovered = false;
  bool _isLearnMoreHovered = false;
  bool _isWatchDemoHovered = false;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> handleAuth() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    // Replace URLs for your backend endpoints
    final url = isLogin
        ? "http://localhost:5000/api/users/login"
        : "https://gameappbackend-i8zv.onrender.com/api/auth/register";
    final body = isLogin
        ? {"email": email, "password": password}
        : {"name": name, "email": email, "password": password};
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['user'] != null) {
          await _storeUserData(data['user']);
          widget.onLoginSuccess(data['user']);
        } else {
          _showSnackBar("Auth failed: User data not found");
        }
      } else {
        _showSnackBar("Auth failed: ${response.body}");
      }
    } catch (e) {
      _showSnackBar("Network error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _storeUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInEmail', user['email']);
    await prefs.setString('role', user['role'] ?? "");
    await prefs.setString('userData', jsonEncode(user));
    if (user['_id'] != null) {
      await prefs.setString('userId', user['_id']);
    }
    if (user['name'] != null) {
      await prefs.setString('userName', user['name']);
    }
    if (user['createdAt'] != null) {
      await prefs.setString('createdAt', user['createdAt']);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
      ),
      child: Row(
        children: [
          // Left Panel - Welcome Section
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin ? "Welcome Back!" : "Create Account",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    isLogin
                        ? "Sign in to continue your journey with us and access all the amazing features."
                        : "Join our community and start your journey with us today.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      _buildActionButton(
                        "Learn More",
                        Icons.auto_awesome,
                        () {},
                        _isLearnMoreHovered,
                        (value) {
                          setState(() {
                            _isLearnMoreHovered = value;
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      _buildActionButton(
                        "Watch Demo",
                        Icons.play_circle_filled,
                        () {},
                        _isWatchDemoHovered,
                        (value) {
                          setState(() {
                            _isWatchDemoHovered = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    "© 2025 Company. All rights reserved",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Panel - Form Section
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: _buildForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    VoidCallback onTap,
    bool isHovered,
    Function(bool) onHover,
  ) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.white.withOpacity(0.25)
                : Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.rocket_launch,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    isLogin ? "Welcome Back!" : "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    isLogin ? "Sign in to continue" : "Join our community",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            // Form Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: _buildForm(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF667eea).withOpacity(0.3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.rocket_launch,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "SAKTHI",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF667eea),
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      isLogin ? "Welcome to Company" : "Welcome to Company",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      isLogin ? "Sign in to continue" : "Create your account",
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),

              // Form Fields
              if (!isLogin) ...[
                _buildInputField(
                  label: "Full Name",
                  icon: Icons.person_outline,
                  onSaved: (val) => name = val ?? "",
                  validator: (val) => val == null || val.isEmpty
                      ? "Please enter your name"
                      : null,
                ),
                SizedBox(height: 20),
              ],

              _buildInputField(
                label: "Email Address",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onSaved: (val) => email = val ?? "",
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return "Please enter your email";
                  if (!val.contains('@')) return "Please enter a valid email";
                  return null;
                },
              ),
              SizedBox(height: 20),

              _buildInputField(
                label: "Password",
                icon: Icons.lock_outline,
                obscureText: true,
                onSaved: (val) => password = val ?? "",
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return "Please enter your password";
                  if (val.length < 6)
                    return "Password must be at least 6 characters";
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Remember Me / Terms Checkbox
              if (isLogin)
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (val) =>
                          setState(() => rememberMe = val ?? false),
                      activeColor: Color(0xFF667eea),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text("Remember me", style: TextStyle(fontSize: 14)),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF667eea),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (val) =>
                          setState(() => agreeToTerms = val ?? false),
                      activeColor: Color(0xFF667eea),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                color: Color(0xFF667eea),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 30),

              // Action Buttons
              MouseRegion(
                onEnter: (_) => setState(() => _isLoginHovered = true),
                onExit: (_) => setState(() => _isLoginHovered = false),
                child: _buildGradientButton(
                  text: isLogin ? "Login" : "Create Account",
                  onPressed: isLoading ? null : handleAuth,
                  isHovered: _isLoginHovered,
                ),
              ),

              SizedBox(height: 20),

              if (!isLogin)
                MouseRegion(
                  onEnter: (_) => setState(() => _isSignupHovered = true),
                  onExit: (_) => setState(() => _isSignupHovered = false),
                  child: _buildOutlineButton(
                    text: "Sign In",
                    onPressed: () => setState(() => isLogin = true),
                    isHovered: _isSignupHovered,
                  ),
                )
              else
                Center(
                  child: TextButton(
                    onPressed: () => setState(() => isLogin = false),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.grey[600]),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Color(0xFF667eea),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required Function(String?) onSaved,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Color(0xFF667eea)),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF667eea), width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback? onPressed,
    required bool isHovered,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHovered
              ? [Color(0xFF5a6fd8), Color(0xFF6a4190)]
              : [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: Color(0xFF667eea).withOpacity(0.5),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Color(0xFF667eea).withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required String text,
    required VoidCallback onPressed,
    required bool isHovered,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF667eea),
          width: isHovered ? 2 : 1.5,
        ),
        color: isHovered
            ? Color(0xFF667eea).withOpacity(0.1)
            : Colors.transparent,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isHovered ? Color(0xFF667eea) : Color(0xFF667eea),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }
}
