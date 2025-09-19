import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends StatelessWidget {
  final VoidCallback onLogout;

  const Services({super.key, required this.onLogout});

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
                      Icon(Icons.code, size: 50, color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Our Services',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Comprehensive Software Solutions',
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
              child: Text(
                'We offer end-to-end software development services using cutting-edge technologies. '
                'Our team of experts delivers high-quality solutions tailored to your business needs.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.8,
              ),
              delegate: SliverChildListDelegate([
                _buildServiceCard(
                  'Android Studio Apps',
                  'Native Android applications developed with Java/Kotlin using Android Studio. '
                      'We create responsive, high-performance mobile apps with Material Design guidelines.',
                  Icons.android,
                  Colors.green,
                ),
                _buildServiceCard(
                  'React Applications',
                  'Modern web applications built with React.js. We develop dynamic, single-page applications '
                      'with responsive designs and seamless user experiences.',
                  Icons.web,
                  Colors.blue,
                ),
                _buildServiceCard(
                  'Single Page Applications',
                  'Fast, interactive SPAs using Angular, React, or Vue.js. Our SPAs provide app-like experiences '
                      'with smooth navigation and minimal loading times.',
                  Icons.dashboard,
                  Colors.purple,
                ),
                _buildServiceCard(
                  'Security Advanced Solutions',
                  'Enterprise-grade security solutions including penetration testing, vulnerability assessment, '
                      'and secure coding practices to protect your applications from threats.',
                  Icons.security,
                  Colors.red,
                ),
                _buildServiceCard(
                  'Spring Boot Development',
                  'Robust backend services and RESTful APIs developed with Spring Boot. We create scalable, '
                      'maintainable server-side applications with microservices architecture.',
                  Icons.storage,
                  Colors.green[700]!,
                ),
                _buildServiceCard(
                  'MERN Stack Projects',
                  'Full-stack applications using MongoDB, Express.js, React, and Node.js. We deliver complete '
                      'solutions from database design to frontend implementation.',
                  Icons.stacked_bar_chart,
                  Colors.amber[700]!,
                ),
                _buildServiceCard(
                  'Cloud Deployment',
                  'AWS, Azure, and Google Cloud deployment services. We help you migrate, deploy, and scale '
                      'your applications in the cloud with best practices.',
                  Icons.cloud,
                  Colors.blue[300]!,
                ),
                _buildServiceCard(
                  'UI/UX Design',
                  'User-centered design services creating intuitive, beautiful interfaces. We focus on '
                      'usability, accessibility, and creating engaging user experiences.',
                  Icons.design_services,
                  Colors.pink,
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Why Choose Our Services?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildFeatureItem(Icons.verified, 'Quality Assurance'),
                  _buildFeatureItem(Icons.schedule, 'On-Time Delivery'),
                  _buildFeatureItem(Icons.support_agent, '24/7 Support'),
                  _buildFeatureItem(Icons.update, 'Regular Updates'),
                  _buildFeatureItem(Icons.security, 'Secure Development'),
                  _buildFeatureItem(Icons.thumb_up, 'Client Satisfaction'),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF0D47A1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Ready to start your project?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Contact us today for a free consultation and project estimate.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0D47A1),
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            'Get Started',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: onLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text("Logout", style: TextStyle(fontSize: 16)),
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

  Widget _buildServiceCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF0D47A1)),
          SizedBox(width: 16),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
