import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:flutter_app/screen/pages/sign_up/sign_up2.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();

  String? _firstNameErrorText;
  String? _lastNameErrorText;
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    super.dispose();
  }

  void _onFirstNameFocusChange() {
    setState(() {
      _firstNameErrorText = null;
    });
  }

  void _onLastNameFocusChange() {
    setState(() {
      _lastNameErrorText = null;
    });
  }

  void _validateAndSubmit() {
    if (_firstNameController.text.isEmpty) {
      setState(() {
        _firstNameErrorText = 'Please enter your first name';
      });
    }
    if (_lastNameController.text.isEmpty) {
      setState(() {
        _lastNameErrorText = 'Please enter your last name';
      });
    }

    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty) {
      // Both fields are filled, navigate to the next screen.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SignUp2(),
        ),
      );
    }
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
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                      "Add your name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      focusNode: _firstNameFocus,
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText:
                            _firstNameFocus.hasFocus ? 'First name*' : null,
                        hintText: 'First name*',
                        errorText: _firstNameErrorText,
                      ),
                      onTap: _onFirstNameFocusChange,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: _lastNameFocus,
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText:
                            _lastNameFocus.hasFocus ? 'Last name*' : null,
                        hintText: 'Last name*',
                        errorText: _lastNameErrorText,
                      ),
                      onTap: _onLastNameFocusChange,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(50),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: kPrimaryColor),
                                ),
                              )),
                          onPressed: () => _validateAndSubmit(),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(40),
                                color: Colors.white),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
