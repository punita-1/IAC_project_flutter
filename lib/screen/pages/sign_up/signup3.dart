import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
// import 'package:flutter_app/screen/pages/Sign_in/Sign_in.dart';
import 'package:flutter_app/screen/pages/Sign_in/sign_in_with_ph.dart';
import 'package:flutter_app/screen/pages/sign_up/signup4.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/screen/utilities/utils.dart';

class SignUp3 extends StatefulWidget {
  final String? emailOrPhone;
  const SignUp3({super.key, this.emailOrPhone});

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  bool _isPasswordHidden = true;

  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  //bool _rememberMe = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void signup() {
    setState(() {
      loading = true;
    });

    //UserCredential userCredential =
    auth
        .createUserWithEmailAndPassword(
      email: widget.emailOrPhone!,
      password: _passwordController.text,
    )
        .then((value) {
      setState(() {
        loading = false;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => SignUp4(),
          ),
        );
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      util.toastmessage(error.toString());
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      signup();
      // User successfully created, you can now navigate to the next screen or perform other actio
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
                      "Set your password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: widget.emailOrPhone,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Email*",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isPasswordHidden,
                            decoration: InputDecoration(
                              labelText: "Password*",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              helperText: "6 or more characters",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: _rememberMe,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _rememberMe = value ?? true;
                    //         });
                    //       },
                    //     ),
                    //     Text(
                    //       "Remember me. ",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     Text(
                    //       "Learn more",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         color: kPrimaryColor,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Text.rich(TextSpan(
                        text:
                            "By clicking Agree and Join, You agree to the Industry Academia Community ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "User Agreement",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: ", Privacy Policy,",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Cookie Policy",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text:
                                ". For phone number signups we will send a varification code via SMS. ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: 20,
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
                          onPressed: _validateAndSubmit,
                          child: loading
                              ? CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                )
                              : Text(
                                  "Agree and Join",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
