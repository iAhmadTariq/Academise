import 'package:academise_front/screens/signup_screen_3.dart';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class AddEducationScreen extends StatefulWidget {
  Map<String, dynamic> data;
  AddEducationScreen({super.key, required this.data});

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: secondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Flexible(
                child: Container(),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "Add Education",
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
              TextFieldInput(
                hintText: 'Grade',
                textEditingController: _gradeController,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldInput(
                hintText: 'School/University',
                textEditingController: _schoolController,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldInput(
                hintText: 'Country',
                textEditingController: _countryController,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      widget.data['grade'] = _gradeController.text;
                      widget.data['school'] = _schoolController.text;
                      widget.data['country'] = _countryController.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen3(
                            data: widget.data,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
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
              const Text('Step 2/3',
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
            ],
          ),
        ),
      ),
    );
  }
}
