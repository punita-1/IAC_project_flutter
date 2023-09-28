// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/pages/Sign_in/sign_in_with_ph.dart';
import 'package:flutter_app/screen/pages/splash_Screens/body.dart';
import 'package:flutter_app/screen/utilities/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../size_config.dart';
import '../forget_password/forget_password.dart';
import '../home_page/mobile_screen_home.dart';

bool remember = true;

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailOrPhoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool remember = true;

  Future<void> _saveRememberMePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  Future<void> _loadRememberMePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      remember = prefs.getBool('rememberMe') ?? true; // Default to true
    });
  }

  void dispose() {
    super.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
  }

  void login() {
    setState(() {
      isLoading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: _emailOrPhoneController.text,
            password: _passwordController.text.toString())
        .then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => MobileScreen(),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      util.toastmessage(error.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRememberMePreference(); // Load the preference when the widget initializes
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
                          "Sign in",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 80,
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
                            child: Center(child: Text("Sign in with phone")),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "or ",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Body(),
                                  ),
                                );
                              },
                              child: Text(
                                "Join now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _emailOrPhoneController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          prefixIcon: Icon(Icons.lock_open),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // You can add more validation here, such as checking for a minimum password length.
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: remember,
                              activeColor: Colors.green[900],
                              onChanged: (value) {
                                setState(() {
                                  remember = value!;
                                });
                              },
                            ),
                            Text(
                              "Remember me. ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "Learn more",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ForgetPassword(),
                          ),
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
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
                              login();
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         MobileScreen(),
                              //   ),
                              // );
                            }
                          },
                          child: isLoading
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 0.3,
                            width: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text("or"),
                          SizedBox(
                            height: 0.3,
                            width: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(55),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/google.svg",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(22),
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(55),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/Apple-Logo.svg",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Sign in with Apple",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(55),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/facebook.svg",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Sign in with Facebook",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
