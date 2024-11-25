import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gyanavi_academy/views/auth/login_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name = '';
  String _email = '';
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Function to load user data from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('userName') ?? 'Emily Johnson'; // Default value
      _email = prefs.getString('userEmail') ?? 'emily.j@example.com'; // Default value
      _phoneNumber = prefs.getString('userPhone') ?? '123-456-7890'; // Default value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF6833FF),  // Primary color from theme
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // User Profile Section
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage("https://via.placeholder.com/150"),
              ),
              SizedBox(height: 8),
              Text(
                _name, // Display fetched name
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("@${_name.toLowerCase()}", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),

              // Username and Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
                ),
                initialValue: _name,
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                initialValue: _email, // Display fetched email
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                ),
                initialValue: _phoneNumber, // Display fetched phone number
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                ),
                obscureText: true,
                initialValue: "********",
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Change Password",
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),

              // Log Out Button
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                child: Text("Log Out"),
              ),

              // Delete Account Section
              TextButton(
                onPressed: () {
                  // Implement delete account functionality
                },
                child: Text(
                  "Delete Account",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the logout dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Do you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('token'); // Clear the token from SharedPreferences
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ); // Navigate to login screen
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
