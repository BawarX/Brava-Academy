import 'package:brava/screen/Home/bookmarked_course.dart';
import 'package:brava/screen/Home/home_page.dart';
import 'package:brava/screen/Home/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int navBarIndex = 0;
  List navBody = [
    const HomePage(),
    const BookMark(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navBody[navBarIndex],
      bottomNavigationBar: SizedBox(
        child: GNav(
          backgroundColor: Theme.of(context).primaryColor,
          activeColor: Colors.white,
          iconSize: 24,
          textSize: 10,
          tabBackgroundColor: Colors.black,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.home,
              text: 'BookMark',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: navBarIndex,
          onTabChange: (index) {
            setState(() {
              navBarIndex = index;
            });
          },
        ),
      ),
    );
  }
}
