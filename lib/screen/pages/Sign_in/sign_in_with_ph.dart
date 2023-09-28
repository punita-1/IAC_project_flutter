// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/pages/Sign_in/verify_code.dart';
import 'package:flutter_app/screen/utilities/utils.dart';
import '../../size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool remember = false;

class SignInWithPh extends StatefulWidget {
  const SignInWithPh({Key? key});

  @override
  State<SignInWithPh> createState() => _SignInWithPhState();
}

class _SignInWithPhState extends State<SignInWithPh> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneNumberController = TextEditingController();
  // bool isLoading = false;

  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }

  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          hintText: "Enter your phone number",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          // You can add more validation here, such as checking for a valid phone number format.
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(50),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              kPrimaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading =
                                    true; // Set loading to true when the button is pressed
                              });
                              auth.verifyPhoneNumber(
                                phoneNumber: _phoneNumberController.text,
                                verificationCompleted: (_) {
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                verificationFailed: (e) {
                                  setState(() {
                                    loading = false;
                                  });
                                  util.toastmessage(e.toString());
                                },
                                codeSent: ((String verificationId, int? Token) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => verifycodeScreen(
                                        verificationId:
                                            verificationId, // Pass the correct value
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    loading = false;
                                  });
                                }),
                                codeAutoRetrievalTimeout: (e) {
                                  setState(() {
                                    loading = false;
                                  });
                                  util.toastmessage(e.toString());
                                },
                              );
                            } else {
                              // If validation fails (phone number is empty), don't start loading
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: loading
                              ? CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                )
                              : Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(22),
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
