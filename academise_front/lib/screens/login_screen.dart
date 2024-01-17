import 'dart:convert';

import 'package:academise_front/models/user.dart';
import 'package:academise_front/screens/home_screen.dart';
import 'package:academise_front/screens/signup_screen_1.dart';
import 'package:academise_front/screens/student_screens/student_home_screen.dart';
import 'package:academise_front/userPreference/user_preference.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  bool isStudent;
  LoginScreen({this.isStudent = false});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePass = true;

  Future<void> loginUser() async {
    try {
      String uri = loginUrl;
      var res = await http.post(Uri.parse(uri), body: {
        "email": _emailController.text,
        "password": _passwordController.text,
        "isStudent": widget.isStudent.toString(),
      });
      var response = json.decode(res.body);
      if (response["success"] == "true") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful"),
            backgroundColor: Colors.green,
          ),
        );
        User user = User.fromJson(response["userRecord"]);
        await RememberUserPreference.saveRemeberUser(user);

        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((context) => widget.isStudent?StudentHomeScreen():HomeScreen()),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Failed, email or password incorrect"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }

    dispose() {
      _emailController.dispose();
      _passwordController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
      gapPadding: 8,
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/images/App_Logo.svg',
                height: 80,
                color: purpleColor,
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldInput(
                hintText: 'Email here',
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: purpleColor,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                    icon: _hidePass
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  hintText: "Password here",
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hidePass,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  loginUser();
                },
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
                    'Log in',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account? "),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => SignUpScreen1(
                                isStudent: widget.isStudent,
                              )),
                        ),
                      );
                    },
                    child: Container(
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
