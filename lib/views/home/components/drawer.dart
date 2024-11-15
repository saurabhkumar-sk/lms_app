import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; // New import for URL launcher

import '../../../core/constants/app_colors.dart';
import '../../drawerscreens/assignments.dart';
import '../../drawerscreens/bookmarks.dart';
import '../../drawerscreens/certificates.dart';
import '../../drawerscreens/study_material/study_material_intro.dart';
import '../../drawerscreens/workshops.dart';
import '../../payment_gateway/profile.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userName = "User";
  String email = "user@example.com";

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'User';
      email = prefs.getString('UserEmail') ?? 'user@example.com';
    });
  }

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to dial a phone number
  Future<void> _dialPhoneNumber(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not dial $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.scaffoldBackground,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              accountName: Text('Welcome, $userName'),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColors.placeholder,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.assignment,
              text: 'Assignments',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AssignmentScreen()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.school,
              text: 'Certificates',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CertificatesScreen()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.bookmark,
              text: 'Bookmark',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarksScreen()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.work,
              text: 'Workshops',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkshopScreen()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.book,
              text: 'Study Material',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoursesMaterialScreen()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              ),
            ),
            Spacer(),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  _dialPhoneNumber('912269719938'); // Replace with your contact number
                },
                icon: Icon(Icons.contact_mail, color: AppColors.primary),
                label: Text(
                  'Contact Us',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    color: Colors.black,
                    onPressed: () {
                      _launchURL('https://www.facebook.com'); // Replace with your Facebook URL
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.xTwitter),
                    color: Colors.black,
                    onPressed: () {
                      _launchURL('https://openai.com/index/chatgpt/'); // Replace with your Twitter URL
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    color: Colors.black,
                    onPressed: () {
                      _launchURL('https://www.instagram.com/yourprofile'); // Replace with your Instagram URL
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.youtube),
                    color: Colors.black,
                    onPressed: () {
                      _launchURL('https://www.youtube.com/yourchannel'); // Replace with your YouTube URL
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Text(
        text ?? '',
        style: TextStyle(color: AppColors.placeholder),
      ),
      leading: Icon(icon, color: AppColors.primary),
      onTap: onTap,
    );
  }
}
