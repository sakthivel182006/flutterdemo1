import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userpagesfolder/about.dart';
import 'userpagesfolder/contact.dart';
import 'userpagesfolder/services.dart';
import 'userpagesfolder/payments.dart';
import 'userpagesfolder/profile.dart';

class User extends StatefulWidget {
  final VoidCallback onLogout;
  final Map<String, dynamic>? userData;

  const User({super.key, required this.onLogout, this.userData});

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final List<Widget> _pages = [
    HomePage(),
    About(onLogout: () {}),
    Services(onLogout: () {}),
    Contact(onLogout: () {}),
    Payments(onLogout: () {}),
    Profile(onLogout: () {}),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToProfile() {
    setState(() {
      _selectedIndex = 5;
    });
  }

  void _simulateLoading() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width <= 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: isMobile
            ? Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 11),
                  ),
                ),
              )
            : Row(
                children: [
                  Image.asset('assets/logo.png', height: 30),
                  SizedBox(width: 10),
                  Text(
                    'Sakthi Software Solutions',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
        backgroundColor: Color(0xFF0D47A1),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: isMobile
            ? IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              )
            : null,
        actions: [
          if (!isMobile)
            Container(
              width: 250,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 11),
                ),
              ),
            ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: _navigateToProfile,
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  widget.userData?['avatar'] ??
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: isMobile ? _buildMobileDrawer() : null,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Row(
              children: [
                if (!isMobile) _buildDesktopSidebar(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFE3F2FD), Color(0xFFF5F5F5)],
                      ),
                    ),
                    child: _pages[_selectedIndex],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: isMobile ? _buildMobileNavBar() : null,
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
          ),
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                widget.userData?['name'] ?? 'User Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(
                widget.userData?['email'] ?? 'user@example.com',
                style: TextStyle(fontSize: 14),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  widget.userData?['avatar'] ??
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF0D47A1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(Icons.home, 'Dashboard', 0),
                  _buildDrawerItem(Icons.info, 'About Company', 1),
                  _buildDrawerItem(Icons.design_services, 'Our Services', 2),
                  _buildDrawerItem(Icons.contact_page, 'Contact Us', 3),
                  _buildDrawerItem(Icons.payment, 'Payments & Billing', 4),
                  _buildDrawerItem(Icons.person, 'My Profile', 5),
                  _buildDrawerItem(Icons.work, 'Projects', 6),
                  _buildDrawerItem(Icons.people, 'Team', 7),
                  _buildDrawerItem(Icons.bar_chart, 'Reports', 8),
                  _buildDrawerItem(Icons.settings, 'Settings', 9),
                  Divider(color: Colors.white54, height: 32),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white70),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      _simulateLoading();
                      widget.onLogout();
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Sakthi Software Solutions Pvt Ltd\nv1.2.0',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF0D47A1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    widget.userData?['avatar'] ??
                        'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  widget.userData?['name'] ?? 'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.userData?['email'] ?? 'user@example.com',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Text(
                  'Premium Member',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(Icons.dashboard, 'Dashboard', 0),
                _buildNavItem(Icons.business, 'About Company', 1),
                _buildNavItem(Icons.code, 'Our Services', 2),
                _buildNavItem(Icons.contact_mail, 'Contact Us', 3),
                _buildNavItem(Icons.payment, 'Payments & Billing', 4),
                _buildNavItem(Icons.person, 'My Profile', 5),
                _buildNavItem(Icons.work, 'Projects', 6),
                _buildNavItem(Icons.people, 'Team', 7),
                _buildNavItem(Icons.analytics, 'Reports', 8),
                _buildNavItem(Icons.settings, 'Settings', 9),
                Divider(color: Colors.white54, height: 32),
                _buildNavItem(Icons.logout, 'Logout', 10, isLogout: true),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Sakthi Software Solutions Pvt Ltd',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'v1.2.0 • © 2023',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String title,
    int index, {
    bool isLogout = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _selectedIndex == index
            ? Colors.white.withOpacity(0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout
              ? Colors.red[300]
              : _selectedIndex == index
              ? Colors.white
              : Colors.white70,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout
                ? Colors.red[300]
                : _selectedIndex == index
                ? Colors.white
                : Colors.white70,
            fontWeight: _selectedIndex == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (isLogout) {
            _simulateLoading();
            widget.onLogout();
          } else {
            setState(() => _selectedIndex = index);
          }
        },
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: () {
        _simulateLoading();
        setState(() {
          _selectedIndex = index;
          Navigator.pop(context);
        });
      },
    );
  }

  Widget _buildMobileNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        BottomNavigationBarItem(
          icon: Icon(Icons.design_services),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_page),
          label: 'Contact',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
      ],
      currentIndex: _selectedIndex < 5 ? _selectedIndex : 0,
      selectedItemColor: Color(0xFF0D47A1),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        _simulateLoading();
        _onItemTapped(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
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
                      Text(
                        'Welcome to Sakthi Solutions',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Enterprise Software Solutions',
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
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Access',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildListDelegate([
                _buildFeatureCard(
                  Icons.payment,
                  'Make Payment',
                  Colors.green[700]!,
                ),
                _buildFeatureCard(
                  Icons.history,
                  'Transaction History',
                  Colors.orange[700]!,
                ),
                _buildFeatureCard(
                  Icons.support,
                  'Support',
                  Colors.purple[700]!,
                ),
                _buildFeatureCard(
                  Icons.settings,
                  'Settings',
                  Colors.blue[700]!,
                ),
                _buildFeatureCard(Icons.shield, 'Security', Colors.red[700]!),
                _buildFeatureCard(Icons.receipt, 'Bills', Colors.teal[700]!),
                _buildFeatureCard(
                  Icons.help,
                  'Help Center',
                  Colors.indigo[700]!,
                ),
                _buildFeatureCard(Icons.star, 'Rewards', Colors.amber[700]!),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.all(16), child: Divider()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recent Projects',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildProjectItem(context, index),
              childCount: 5,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.all(16), child: Divider()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Team Members',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => _buildTeamMember(index),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.8), color],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 32, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectItem(BuildContext context, int index) {
    List<String> projects = [
      'E-Commerce Platform',
      'Healthcare Management System',
      'School ERP Solution',
      'Inventory Management',
      'CRM Implementation',
    ];
    List<String> statuses = [
      'Completed',
      'In Progress',
      'Planning',
      'Completed',
      'In Progress',
    ];
    List<Color> statusColors = [
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.orange,
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.work, color: Colors.blue[700]),
        ),
        title: Text(
          projects[index],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Deadline: June ${30 - index}, 2023'),
        trailing: Chip(
          label: Text(
            statuses[index],
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          backgroundColor: statusColors[index],
        ),
      ),
    );
  }

  Widget _buildTeamMember(int index) {
    List<String> names = [
      'John Doe',
      'Jane Smith',
      'Robert Johnson',
      'Sarah Williams',
      'Michael Brown',
      'Emily Davis',
      'David Wilson',
      'Lisa Miller',
    ];
    List<String> roles = [
      'Lead Developer',
      'UI/UX Designer',
      'Project Manager',
      'QA Engineer',
      'Backend Developer',
      'Frontend Developer',
      'DevOps Engineer',
      'Business Analyst',
    ];

    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=${index + 1}',
            ),
          ),
          SizedBox(height: 8),
          Text(
            names[index],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            roles[index],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
