import 'package:academise_front/screens/login_screen.dart';
import 'package:academise_front/userPreference/current_user.dart';
import 'package:academise_front/userPreference/user_preference.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/widgets/text_in_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late CurrentUser _currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentUser = Get.put(CurrentUser());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: secondMobileBackgroundColor,
              ),
              child: Icon(
                Icons.person,
                size: 80,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextInProfile(
                  smallText: 'First Name',
                  mainText: _currentUser.user.firstName,
                ),
                SizedBox(
                  height: 15,
                ),
                TextInProfile(
                  smallText: 'Last Name',
                  mainText: _currentUser.user.lastName,
                ),
                SizedBox(
                  height: 15,
                ),
                TextInProfile(
                  smallText: 'Email',
                  mainText: _currentUser.user.email,
                ),
                SizedBox(
                  height: 15,
                ),
                TextInProfile(
                  smallText: 'Date of Birth',
                  mainText: _currentUser.user.dob,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: purpleColor,
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: secondMobileBackgroundColor,
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'No',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            RememberUserPreference.removeRememberUser();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Yes',
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 150, 27, 18),
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
