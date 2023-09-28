import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/pages/home_page/mobile_screen_home.dart';
import 'package:flutter_app/screen/pages/splash_Screens/body.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MobileScreen()),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Body()),
        ),
      );
    }
  }
}
