import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/pages/sign_up/signup5.dart';
import 'package:flutter_app/screen/size_config.dart';

class SignUp4 extends StatefulWidget {
  const SignUp4({super.key});

  @override
  State<SignUp4> createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
  final _firstNameController = TextEditingController();
  final _locationFocus = FocusNode();

  String? _location;

  @override
  void dispose() {
    _firstNameController.dispose();
    _locationFocus.dispose();
    super.dispose();
  }

  void _onFirstNameFocusChange() {
    setState(() {
      _location = null;
    });
  }

  void _validateAndSubmit() {
    if (_firstNameController.text.isEmpty) {
      setState(() {
        _location = 'Location*';
      });
    }

    if (_firstNameController.text.isNotEmpty) {
      // Both fields are filled, navigate to the next screen.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const SignUp5(),
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
                      "Confirm your location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("See people, jobs, and news in your area."),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      focusNode: _locationFocus,
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: _locationFocus.hasFocus ? 'Location*' : null,
                        hintText: 'Location*',
                        errorText: _location,
                      ),
                      onTap: _onFirstNameFocusChange,
                    ),
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: kPrimaryColor),
                                ),
                              )),
                          onPressed: () => _validateAndSubmit(),
                          child: Text(
                            "Next",
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
