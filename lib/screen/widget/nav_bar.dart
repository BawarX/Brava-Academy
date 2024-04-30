import 'package:brava/screen/bookmark/bookmarked_course.dart';
import 'package:brava/screen/Home/home_page.dart';
import 'package:brava/screen/profile/profile.dart';
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
      bottomNavigationBar: GNav(
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.white,
        color: Colors.grey,
        hoverColor: Theme.of(context).primaryColor,
        activeColor: Colors.white,
        iconSize: 24,
        tabMargin: const EdgeInsets.all(5),
        // tabActiveBorder: Border.all(color: Colors.red),
        textSize: 10,
        rippleColor: Theme.of(context).primaryColor,
        tabBackgroundGradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Colors.white,
        ]),
        tabs: const [
          GButton(
            gap: 10,
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            gap: 10,
            icon: Icons.bookmark,
            text: 'BookMark',
          ),
          GButton(
            gap: 10,
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
    );
  }
}
