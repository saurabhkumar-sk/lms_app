import 'package:flutter/material.dart';
import 'package:gyanavi_academy/views/auth/login_page.dart';
import 'package:gyanavi_academy/views/payment_gateway/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Implement back navigation if needed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            Text(
              "Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text("Profile"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profile(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text("Email"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to email settings screen (optional)
              },
            ),
            SizedBox(height: 20),

            // Preferences Section
            Text(
              "Preferences",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.notifications_outlined),
              title: Text("Notifications"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("On"),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {
                // Navigate to notification settings screen (optional)
              },
            ),
            SizedBox(height: 20),

            // About Section
            Text(
              "About",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("App Version"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("1.0.0"),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {
                // Navigate to app version details if needed
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Index for "Settings"
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}