import 'package:flutter/material.dart';
import 'package:flutter_app/screen/size_config.dart';

class SplashContent extends StatelessWidget {
  final String text;
  final String image;
  const SplashContent({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          image,
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(255),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.normal,
            color: Colors.black, // Set the text color to black
            decoration: TextDecoration.none,
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
