import 'package:aa/view/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../view/add_cat.dart';
import '../../view/profile.dart';
import '../Constant.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 2;
  final List<Widget> _widgetOptions = [
    Profile(),
    AddCatUser(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor,
              color: Colors.black,
              tabs: [
                GButton(
                  leading: _selectedIndex==0?Icon(Icons.person,color: Colors.white,):Icon(Icons.person_outline),
                  icon: Icons.verified_user,
                  text: 'حسابي',
                ),
                GButton(
                  leading: _selectedIndex==1?Icon(Icons.add_circle_outline_rounded,color: Colors.white,):Icon(Icons.add_circle_outline_rounded),
                  icon: Icons.verified_user,
                  text: 'اعلن هنا',
                ),
                GButton(
                  leading: _selectedIndex==2?FaIcon(FontAwesomeIcons.house,color: Colors.white, size: 20):FaIcon(FontAwesomeIcons.house, size: 20),
                  text: 'الرئيسية',
                  icon: Icons.home,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}