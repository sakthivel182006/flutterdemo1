import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onLoginPressed;

  HomePage({required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sakthi Software Solutions',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? 42
                            : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Transform Your Digital Presence with Expert Solutions',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? 20
                            : 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        ElevatedButton(
                          onPressed: onLoginPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF667eea),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 5,
                          ),
                          child: Text('Get Started Today'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 60),

          // Services Section
          Center(
            child: Text(
              'Our Comprehensive Services',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 36 : 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'End-to-end digital solutions for your business growth',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),

          // Services Grid
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: MediaQuery.of(context).size.width > 600
                ? 0.9
                : 1.2,
            children: [
              _buildServiceCard(
                icon: Icons.language,
                title: 'Website Development',
                description:
                    'Responsive, modern websites with cutting-edge technology and SEO optimization',
                color: Colors.blue,
              ),
              _buildServiceCard(
                icon: Icons.phone_iphone,
                title: 'Mobile App Development',
                description:
                    'Native and cross-platform mobile applications for iOS and Android',
                color: Colors.green,
              ),
              _buildServiceCard(
                icon: Icons.cloud_upload,
                title: 'Deployment & Hosting',
                description:
                    'Seamless deployment, cloud hosting, and continuous integration services',
                color: Colors.orange,
              ),
              _buildServiceCard(
                icon: Icons.payment,
                title: 'Payment Integration',
                description:
                    'Secure payment gateways with multiple payment options integration',
                color: Colors.purple,
              ),
              _buildServiceCard(
                icon: Icons.security,
                title: 'Security Solutions',
                description:
                    'End-to-end security implementation and vulnerability assessment',
                color: Colors.red,
              ),
              _buildServiceCard(
                icon: Icons.people,
                title: 'User Flow Management',
                description:
                    'Optimized user experience with intuitive navigation and workflow design',
                color: Colors.teal,
              ),
            ],
          ),

          SizedBox(height: 60),

          // Why Choose Us Section
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why Choose Sakthi?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                SizedBox(height: 20),
                _buildFeatureRow(
                  icon: Icons.star,
                  title: 'Expert Team',
                  description: 'Experienced developers and designers',
                ),
                _buildFeatureRow(
                  icon: Icons.schedule,
                  title: 'Timely Delivery',
                  description: 'On-time project completion guarantee',
                ),
                _buildFeatureRow(
                  icon: Icons.support_agent,
                  title: '24/7 Support',
                  description: 'Round-the-clock technical support',
                ),
                _buildFeatureRow(
                  icon: Icons.currency_rupee,
                  title: 'Cost Effective',
                  description: 'Competitive pricing with quality assurance',
                ),
              ],
            ),
          ),

          SizedBox(height: 60),

          // Call to Action
          Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  'Ready to Transform Your Business?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  'Join hundreds of satisfied clients who trust Sakthi Software Solutions',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: onLoginPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF667eea),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                  ),
                  child: Text('Start Your Project Now'),
                ),
              ],
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFF667eea), size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
