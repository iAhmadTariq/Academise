import 'dart:convert';
import 'package:academise_front/screens/login_screen.dart';
import 'package:academise_front/screens/signup_screen_2.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/utils/dbconnection_links.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class SignUpScreen3 extends StatefulWidget {
  Map<String, dynamic> data;
  SignUpScreen3({super.key, required this.data});
  @override
  _SignUpScreen3State createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _hidePass = true;
  DateTime? _selectedDate;

  bool isEmailValid(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value) ? false : true;
  }

  Future<void> insertRecord() async {
    try {
      String uri = insert_recordUrl;
      var res = await http.post(Uri.parse(uri), body: {
        "first_name": widget.data['first_name'],
        "last_name": widget.data['last_name'],
        "date_of_birth": widget.data['dob'],
        "email": _emailController.text,
        "password": _passwordController.text,
      });
      print('here');
      var response = json.decode(res.body);
      if (response["success"] == "true") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Record inserted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => LoginScreen())));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response["message"]}'),
            backgroundColor: Colors.red,
          ),
        );
        
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );  
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: secondaryColor,
          ),
        ),
      ),
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
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Personal details',
                      style: TextStyle(
                        fontSize: 20,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldInput(
                hintText: 'Email here',
                textEditingController: _emailController,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldInput(
                hintText: 'Password here',
                textEditingController: _passwordController,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldInput(
                hintText: 'Confirm password here',
                textEditingController: _confirmPassController,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (_passwordController.text !=
                          _confirmPassController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Passwords do not match'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (!isEmailValid(_emailController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid email'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_passwordController.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Password must be at least 8 characters long'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _confirmPassController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Fill all the fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_emailController.text.contains(' ')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email cannot contain spaces'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_passwordController.text.contains(' ')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password cannot contain spaces'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_confirmPassController.text.contains(' ')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password cannot contain spaces'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_passwordController.text !=
                          _confirmPassController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Passwords do not match'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_passwordController.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Password must be at least 8 characters long'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _confirmPassController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Fields cannot be empty'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_emailController.text.contains(' ')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email cannot contain spaces'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_passwordController.text.contains(' ')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password cannot contain spaces'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else if (_confirmPassController.text.contains(' ')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password cannot contain spaces'),
                          ),
                        );
                        return;
                      } 
                      else {
                        insertRecord();
                      }
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        color: purpleColor,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Done',
                            ),
                          ),
                          const Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Text('Step 3/3',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                child: LinearProgressIndicator(
                  value: 1,
                  backgroundColor: secondMobileBackgroundColor,
                  color: purpleColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
