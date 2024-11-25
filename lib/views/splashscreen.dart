import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission handler
import '../core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissionsAndToken();
  }

  Future<void> _checkPermissionsAndToken() async {
    // Check location permission
    PermissionStatus locationPermission = await Permission.location.request();

    if (locationPermission.isGranted) {
      // If permission is granted, proceed to check token
      _checkToken();
    } else {
      // Show a message if permission is denied
      _showPermissionDeniedDialog();
    }
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // Simulate a short delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    if (token != null && token.isNotEmpty) {
      // Navigate to home if token exists
      Navigator.of(context).pushReplacementNamed(AppRoutes.entryPoint);
    } else {
      // Navigate to login if no token
      Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text('Location permission is required to proceed.'),
          actions: [
            TextButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                _checkPermissionsAndToken(); // Retry permission check
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the app or return to previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/JPEG-1222.jpg', // Your asset icon
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}
