import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_services/splash_services.dart';
import 'package:flutter_app/screen/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices SplashScreen = SplashServices();
  double imageOpacity = 0.0;
  double textOpacity = 0.0;
  @override
  void initState() {
    super.initState();
    SplashScreen.isLogin(context);
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        imageOpacity = 1.0; // Set opacity to 1 for the fade-in effect
      });
      // Add a delay for the text animation to start after the image animation
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          textOpacity = 1.0; // Set opacity to 1 for the text fade-in effect
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
          Colors.blue.shade100,
          Colors.blue.shade200,
          Colors.blue.shade400,
          Colors.blue.shade600,
          Colors.blue.shade900,
          Colors.black,
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration:
                  Duration(milliseconds: 200), // Duration for the animation
              opacity: imageOpacity, // Use the opacity value
              child: Image.asset('assets/logo.png'),
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: textOpacity,
              child: Text(
                "Industry Academia \n       Community",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
