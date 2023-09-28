import 'package:flutter/material.dart';
import 'package:flutter_app/screen/pages/splash_Screens/splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IAC Project",
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black, // Set the text color
            fontSize: 16,
            decoration: TextDecoration.none, // Remove underline
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
