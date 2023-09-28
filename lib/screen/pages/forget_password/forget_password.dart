import 'package:flutter/material.dart';
import 'package:flutter_app/screen/pages/Sign_in/Sign_in.dart';
//import 'package:flutter_app/screen/pages/sign_up/signup3.dart';
import 'package:flutter_app/screen/utilities/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
import '../../size_config.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  bool isEmailValid(String email) {
    // Simple email format validation (you can adjust this regex pattern as needed)
    final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailPattern.hasMatch(email);
  }

  void resetPassword(BuildContext context) {
    final email = emailController.text.trim();

    if (!isEmailValid(email)) {
      util.toastmessage("Invalid email format");
      return;
    }

    auth.sendPasswordResetEmail(email: email).then((value) {
      util.toastmessage(
          "We have sent an email to recover your password. Please check your email.");
    }).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SignIn(),
        ),
      );
    }).onError((error, stackTrace) {
      util.toastmessage(error.toString());
    });
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
                child: SvgPicture.asset(
                  "assets/Logo.svg",
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forget Password",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      Text(
                        "Reset Password in two quick steps",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
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
                            onPressed: () {
                              resetPassword(context);
                            },
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.white),
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
