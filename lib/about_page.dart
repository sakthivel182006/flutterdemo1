import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final VoidCallback onLoginPressed;

  AboutPage({required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Us',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Learn more about our company and mission. We provide amazing services to our users.',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),

          SizedBox(height: 30),

          // Call to action
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF667eea).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Ready to join our community?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                ElevatedButton(
                  onPressed: onLoginPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF667eea),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Sign Up Now'),
                ),
              ],
            ),
          ),

          // Add more about content here
          // ...
        ],
      ),
    );
  }
}
