import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The Profile widget is a stateful widget because it needs to manage
// the state of various user profile data fetched from SharedPreferences.
class Profile extends StatefulWidget {
  // A callback function to be executed when the user taps the logout button.
  final VoidCallback onLogout;

  // The constructor requires the onLogout callback.
  const Profile({super.key, required this.onLogout});

  @override
  State<Profile> createState() => _ProfileState();
}

// The State class for the Profile widget.
class _ProfileState extends State<Profile> {
  // State variables to hold the user's profile information.
  // Initialized with placeholder values that will be replaced
  // once the data is loaded from local storage.
  String _userName = 'Loading...';
  String _loggedInEmail = 'Loading...';
  String _userId = 'Loading...';
  String _fullName = 'Loading...';
  String _phoneNumber = 'Loading...';
  String _location = 'Loading...';

  // State variables for user settings.
  bool _isPushNotificationsEnabled = true;
  bool _isEmailNotificationsEnabled = true;
  bool _isDarkModeEnabled = false;

  // This method is called once when the stateful widget is inserted into the widget tree.
  // It's the perfect place to initiate data loading.
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // An asynchronous method to fetch all user data from SharedPreferences.
  Future<void> _loadProfileData() async {
    // Get an instance of SharedPreferences.
    final prefs = await SharedPreferences.getInstance();

    // Use setState to update the UI with the fetched data.
    setState(() {
      // Fetch each piece of data, using a default value if the key is not found.
      _userName = prefs.getString('userName') ?? 'Agent User';
      _loggedInEmail = prefs.getString('loggedInEmail') ?? 'agent@example.com';
      _userId = prefs.getString('userId') ?? 'User ID not found';
      _fullName = prefs.getString('fullName') ?? 'Agent Max';
      _phoneNumber = prefs.getString('phoneNumber') ?? '+1 (555) 123-4567';
      _location = prefs.getString('location') ?? 'New York, USA';

      _isPushNotificationsEnabled = prefs.getBool('pushNotifications') ?? true;
      _isEmailNotificationsEnabled =
          prefs.getBool('emailNotifications') ?? true;
      _isDarkModeEnabled = prefs.getBool('darkMode') ?? false;
    });
  }

  // Method to handle updating the push notifications setting.
  void _togglePushNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPushNotificationsEnabled = value;
      prefs.setBool('pushNotifications', value);
    });
  }

  // Method to handle updating the email notifications setting.
  void _toggleEmailNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isEmailNotificationsEnabled = value;
      prefs.setBool('emailNotifications', value);
    });
  }

  // Method to handle updating the dark mode setting.
  void _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkModeEnabled = value;
      prefs.setBool('darkMode', value);
      // In a real app, you would also update the app's theme here.
    });
  }

  // The main build method for the widget's UI.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar for the profile screen.
      appBar: AppBar(
        title: Text(
          'Agent Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      // The body uses a ListView to allow the content to be scrollable.
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // A section at the top for the profile picture and welcome message.
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.blue.shade200,
              child: Icon(Icons.person_rounded, size: 90, color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Hello, $_userName!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Center(
            child: Text(
              'Welcome to your profile dashboard.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          SizedBox(height: 30),

          // A Card widget for the "Account Details" section.
          _buildProfileSection(
            title: 'Account Details',
            children: [
              _buildProfileItem(
                icon: Icons.person_outline,
                label: 'User Name',
                value: _userName,
              ),
              _buildProfileItem(
                icon: Icons.email_outlined,
                label: 'Email',
                value: _loggedInEmail,
              ),
              _buildProfileItem(
                icon: Icons.fingerprint,
                label: 'User ID',
                value: _userId,
              ),
            ],
          ),

          SizedBox(height: 20),

          // A Card widget for the "Personal Details" section.
          _buildProfileSection(
            title: 'Personal Details',
            children: [
              _buildProfileItem(
                icon: Icons.badge_outlined,
                label: 'Full Name',
                value: _fullName,
              ),
              _buildProfileItem(
                icon: Icons.phone_outlined,
                label: 'Phone Number',
                value: _phoneNumber,
              ),
              _buildProfileItem(
                icon: Icons.location_on_outlined,
                label: 'Location',
                value: _location,
              ),
            ],
          ),

          SizedBox(height: 20),

          // A Card widget for the "App Settings" section with switch toggles.
          _buildProfileSection(
            title: 'App Settings',
            children: [
              SwitchListTile(
                title: Text('Push Notifications'),
                secondary: Icon(
                  Icons.notifications_outlined,
                  color: Colors.blueAccent,
                ),
                value: _isPushNotificationsEnabled,
                onChanged: _togglePushNotifications,
              ),
              SwitchListTile(
                title: Text('Email Notifications'),
                secondary: Icon(Icons.email_outlined, color: Colors.blueAccent),
                value: _isEmailNotificationsEnabled,
                onChanged: _toggleEmailNotifications,
              ),
              SwitchListTile(
                title: Text('Dark Mode'),
                secondary: Icon(
                  Icons.brightness_2_outlined,
                  color: Colors.blueAccent,
                ),
                value: _isDarkModeEnabled,
                onChanged: _toggleDarkMode,
              ),
            ],
          ),

          SizedBox(height: 20),

          // A Card widget for "Achievements" or "Badges".
          _buildProfileSection(
            title: 'Achievements',
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAchievementBadge(
                      icon: Icons.star,
                      text: 'Top Performer',
                    ),
                    _buildAchievementBadge(
                      icon: Icons.leaderboard,
                      text: 'Team Leader',
                    ),
                    _buildAchievementBadge(
                      icon: Icons.verified_user,
                      text: 'Verified Agent',
                    ),
                    _buildAchievementBadge(
                      icon: Icons.emoji_events,
                      text: 'Milestone Achieved',
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 40),

          // The Logout button at the bottom of the screen.
          ElevatedButton(
            onPressed: widget.onLogout,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: Text(
              "Agent App - Logout",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // A helper method to create a reusable section with a title and a Card.
  Widget _buildProfileSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Divider(
              height: 25,
              thickness: 1.5,
              color: Colors.blueAccent.withOpacity(0.3),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  // A helper method to create a reusable profile item (label and value).
  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // A helper method to create a reusable achievement badge.
  Widget _buildAchievementBadge({
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.amber),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
