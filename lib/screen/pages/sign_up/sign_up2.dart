import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/pages/Sign_in/sign_in_with_ph.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:flutter_app/screen/pages/sign_up/signup3.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  final _inputController = TextEditingController();
  final _inputFocus = FocusNode();

  String? _inputErrorText;
  @override
  void dispose() {
    _inputController.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  void _onInputFocusChange() {
    setState(() {
      _inputErrorText = null;
    });
  }

  void _validateAndSubmit() {
    final input = _inputController.text.trim();

    if (input.isEmpty) {
      setState(() {
        _inputErrorText = 'Please enter your email';
      });
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(input)) {
      setState(() {
        _inputErrorText = 'Please enter a valid email ';
      });
    }
    if (_inputErrorText == null) {
      // Input is valid, navigate to the next screen.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SignUp3(emailOrPhone: input),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
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
                      "Add your email*",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      focusNode: _inputFocus,
                      controller: _inputController,
                      decoration: InputDecoration(
                        labelText: _inputFocus.hasFocus ? 'Email*' : null,
                        hintText: 'Email',
                        errorText: _inputErrorText,
                      ),
                      onTap: _onInputFocusChange,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
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
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInWithPh()));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.black)),
                            child: Center(child: Text("Sign Up with phone")),
                          ),
                        )
                      ],
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
