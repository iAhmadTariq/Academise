import 'package:academise_front/screens/signup_screen_2.dart';
import 'package:academise_front/screens/student_screens/add_education_screen.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class SignUpScreen1 extends StatefulWidget {
  bool isStudent;
  SignUpScreen1({this.isStudent = false});
  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1>
    with SingleTickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  DateTime? _selectedDate;
  late Map<String, dynamic> _data;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void insertData() {
    _data = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'dob': _selectedDate.toString().substring(0, 10),
      'isStudent': widget.isStudent.toString(),
    };
    dispose(){
      _firstNameController.dispose();
      _lastNameController.dispose();
    }
    _selectedDate = null;
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
                hintText: 'First name here',
                textEditingController: _firstNameController,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldInput(
                hintText: 'Last name here',
                textEditingController: _lastNameController,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    color: secondMobileBackgroundColor,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _selectedDate == null
                          ? 'Select date of birth'
                          : _selectedDate.toString().substring(0, 10),
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (_firstNameController.text.isEmpty ||
                          _lastNameController.text.isEmpty ||
                          _selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill all the fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      else {
                        insertData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widget.isStudent?AddEducationScreen(data: _data):SignUpScreen2(data: _data),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                              'Next',
                            ),
                          ),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Text('Step 1/3',
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
                  value: 0.33,
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
