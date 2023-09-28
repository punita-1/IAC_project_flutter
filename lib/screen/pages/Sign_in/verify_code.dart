// import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/pages/home_page/mobile_screen_home.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:flutter_app/screen/utilities/utils.dart';

class verifycodeScreen extends StatefulWidget {
  final String verificationId;
  verifycodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<verifycodeScreen> createState() => _verifycodeScreenState();
}

class _verifycodeScreenState extends State<verifycodeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController VerificationCodeController = TextEditingController();
  bool loading = false;

  void dispose() {
    super.dispose();
    VerificationCodeController.dispose();
  }

  final auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber() async {
    setState(() {
      loading = true;
    });

    final Credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: VerificationCodeController.text.toString(),
    );

    try {
      await auth.signInWithCredential(Credential);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MobileScreen(),
        ),
      );
    } catch (e) {
      setState(() {
        loading = false; // Stop loading on error
      });

      util.toastmessage(e.toString());
    }
  }

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
                          "Verify",
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
                        controller: VerificationCodeController,
                        decoration: InputDecoration(
                          labelText: "6 Digit Code",
                          hintText: "6 Digit Code",
                          prefixIcon: Icon(Icons.phone),
                        ),
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
                          onPressed: () async {
                            await verifyPhoneNumber(); // Call the verification function
                          },
                          child: loading
                              ? CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                )
                              : Text(
                                  "Verify",
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
