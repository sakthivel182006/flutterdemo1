import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class About extends StatelessWidget {
  final VoidCallback onLogout;

  const About({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.business, size: 50, color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'About Sakthi Solutions',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Innovating Since 2010',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Story',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Founded in 2010, Sakthi Software Solutions has been at the forefront of digital transformation, '
                    'helping businesses leverage technology to achieve their goals. With over a decade of experience, '
                    'we have delivered innovative solutions to clients across various industries.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Our Mission',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'To empower businesses with cutting-edge software solutions that drive growth, improve efficiency, '
                    'and create sustainable competitive advantages in an increasingly digital world.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Our Values',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildValueItem(
                    Icons.security,
                    'Innovation',
                    'We constantly explore new technologies and methodologies to deliver forward-thinking solutions.',
                  ),
                  _buildValueItem(
                    Icons.people,
                    'Collaboration',
                    'We believe in working closely with our clients to understand their unique needs and challenges.',
                  ),
                  _buildValueItem(
                    Icons.home,
                    'Quality',
                    'We are committed to delivering software of the highest quality that exceeds expectations.',
                  ),
                  _buildValueItem(
                    Icons.security,
                    'Security',
                    'We prioritize the security and integrity of our clients data in all our solutions.',
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Our Expertise',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildListDelegate([
                _buildExpertiseCard(
                  'Web Development',
                  Icons.web,
                  'Responsive, modern web applications using latest technologies',
                ),
                _buildExpertiseCard(
                  'Mobile Apps',
                  Icons.phone_iphone,
                  'Native and cross-platform mobile applications for iOS and Android',
                ),
                _buildExpertiseCard(
                  'Cloud Solutions',
                  Icons.cloud,
                  'Scalable cloud infrastructure and migration services',
                ),
                _buildExpertiseCard(
                  'UI/UX Design',
                  Icons.design_services,
                  'User-centered designs that enhance experience and engagement',
                ),
                _buildExpertiseCard(
                  'DevOps',
                  Icons.settings,
                  'Automated deployment pipelines and infrastructure management',
                ),
                _buildExpertiseCard(
                  'Data Analytics',
                  Icons.analytics,
                  'Data-driven insights and business intelligence solutions',
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Our Achievements',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      _buildAchievement('250+', 'Projects Completed'),
                      _buildAchievement('100+', 'Happy Clients'),
                      _buildAchievement('12+', 'Years Experience'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildAchievement('50+', 'Team Members'),
                      _buildAchievement('15+', 'Awards Won'),
                      _buildAchievement('24/7', 'Support'),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: onLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0D47A1),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem(IconData icon, String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFF0D47A1), size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 16, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertiseCard(String title, IconData icon, String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3F2FD), Colors.white],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Color(0xFF0D47A1)),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievement(String value, String label) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF0D47A1).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
