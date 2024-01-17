import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/global_variables.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StudentHomeScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: StudenthomeScreenItems,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: mobileBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: const Color.fromARGB(255, 200, 200, 200).withOpacity(.4),
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GNav(
          gap: 2,
          activeColor: primaryColor,
          tabBackgroundColor: secondMobileBackgroundColor,
          padding: EdgeInsets.all(10),
          onTabChange: (index) {
            setState(() {
              _page = index;
            });
            pageController.jumpToPage(index);
          },
          iconSize: 24,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Explore',
            ),
            GButton(
              icon: Icons.chat,
              text: 'Chat',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
