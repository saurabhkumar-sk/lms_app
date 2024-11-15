import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gyanavi_academy/views/Classes/class_content.dart';
import 'package:gyanavi_academy/views/Classes/myclasses.dart';
import 'package:gyanavi_academy/views/compo/helpchat.dart';
import 'package:gyanavi_academy/views/course/my_courses_screen.dart';
import 'package:gyanavi_academy/views/drawerscreens/bookmarks.dart';
import 'package:gyanavi_academy/views/drawerscreens/settings.dart';
import 'package:gyanavi_academy/views/home/home_screen.dart';
import 'package:gyanavi_academy/views/payment_gateway/profile.dart';
import '../../core/constants/app_icons.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';




import 'components/app_navigation_bar.dart';

/// This page will contain all the bottom navigation tabs
class EntryPointUI extends StatefulWidget {
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  /// Current Page
  int currentIndex = 0;

  /// On labelLarge navigation tap
  void onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  /// All the pages
  List<Widget> pages = [
     HomeScreen(),
     ContentScreen(),
    SettingsScreen(),
    HelpScreen(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.scaffoldBackground,
            child: child,
          );
        },
        duration: AppDefaults.duration,
        child: pages[currentIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onNavTap: onBottomNavigationTap,
      ),
    );
  }
}

