import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/pages/sign_up/Upload_image.dart';
import 'package:flutter_app/screen/size_config.dart';
//import 'package:flutter_app/screen/pages/sign_up/sign_up2.dart';

class SignUp5 extends StatefulWidget {
  const SignUp5({super.key});

  @override
  State<SignUp5> createState() => _SignUp5State();
}

class _SignUp5State extends State<SignUp5> {
  final _locationFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _universityFocus = FocusNode();
  final _degreeFocus = FocusNode();
  final _specializationFocus = FocusNode();
  final _startYearFocus = FocusNode();
  final _startYearFocusy = FocusNode();
  String? _location;
  bool isYesSelected = false;

  List<Widget> formFields = [];

  @override
  void initState() {
    super.initState();
    formFields.add(
      Column(
        children: [
          TextFormField(
            focusNode: _locationFocus,
            decoration: InputDecoration(
              labelText: 'Most recent job title*',
              hintText: 'Most recent job title*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
          TextFormField(
            focusNode: _startYearFocusy,
            decoration: InputDecoration(
              labelText: 'Employement type*',
              hintText: 'Employement type*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
          TextFormField(
            focusNode: _startYearFocus,
            decoration: InputDecoration(
              labelText: 'Most recent company*',
              hintText: 'Most recent company*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        ],
      ),
    );
  }

  void _toggleYesNo(bool value) {
    setState(() {
      isYesSelected = value;
      // Clear the old text form field and add new ones based on the toggle value
      formFields.clear();
      if (isYesSelected) {
        formFields.add(
          TextFormField(
            focusNode: _firstNameFocus,
            decoration: InputDecoration(
              labelText: 'University or School*',
              hintText: 'University or School*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        );
        formFields.add(
          TextFormField(
            focusNode: _universityFocus,
            decoration: InputDecoration(
              labelText: 'Degree*',
              hintText: 'Degree*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        );
        formFields.add(
          TextFormField(
            focusNode: _degreeFocus,
            decoration: InputDecoration(
              labelText: 'Specialization*',
              hintText: 'Specialization*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        );
        formFields.add(
          TextFormField(
            focusNode: _specializationFocus,
            decoration: InputDecoration(
              labelText: 'Start year*',
              hintText: 'Start year*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        );
      } else {
        // Add back the original text form field
        formFields.add(
          TextFormField(
            focusNode: _locationFocus,
            decoration: InputDecoration(
              labelText: 'Most recent job title*',
              hintText: 'Most recent job title*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        );
        formFields.add(
          TextFormField(
            focusNode: _startYearFocusy,
            decoration: InputDecoration(
              labelText: 'Employement type*',
              hintText: 'Employement type*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        );
        formFields.add(
          TextFormField(
            focusNode: _startYearFocus,
            decoration: InputDecoration(
              labelText: 'Most recent company*',
              hintText: 'Most recent company*',
              errorText: _location,
            ),
            onTap: () {
              setState(() {
                _location = null;
              });
            },
          ),
        );
      }
    });
  }

  void _validateAndSubmit() {
    if (_location == null) {
      setState(() {
        _location = '*';
      });
      return; // Exit the method to prevent navigation
    }

    // Perform other validations for the form fields here

    // If all validations are successful, navigate to the next screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UploadImageScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _locationFocus.dispose();
    _firstNameFocus.dispose();
    _universityFocus.dispose();
    _degreeFocus.dispose();
    _specializationFocus.dispose();
    _startYearFocus.dispose();
    _startYearFocusy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  "assets/logo.png",
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your profile helps you discover people and opportunities",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "I'm a Student ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        Row(
                          children: [
                            Text(
                              isYesSelected ? "Yes" : "No",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Switch(
                              value: isYesSelected,
                              onChanged: _toggleYesNo,
                              activeColor: kPrimaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Display the form fields conditionally
                    ...formFields,
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(50),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: kPrimaryColor),
                            ),
                          ),
                        ),
                        onPressed: () => _validateAndSubmit(),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(40),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
