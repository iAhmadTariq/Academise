import 'package:academise_front/screens/login_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstMenuScreen extends StatelessWidget {
  const FirstMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Flexible(
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/images/App_Logo.svg',
                height: 80,
                color: purpleColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Welcome to Academise",
                  style: GoogleFonts.roboto(
                    color: primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Log in as:",
                      style: GoogleFonts.roboto(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => LoginScreen(
                          isStudent: true,
                        )),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    color: purpleColor,
                  ),
                  child: Text(
                    'Student',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => LoginScreen()),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    color: purpleColor,
                  ),
                  child: Text(
                    'Teacher',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    color: purpleColor,
                  ),
                  child: Text(
                    'Guest',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Flexible(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
