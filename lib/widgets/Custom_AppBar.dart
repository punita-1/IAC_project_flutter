// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_app/screen/pages/sign_up/sign_up1.dart';
import 'package:flutter_app/screen/pages/splash_Screens/body.dart';
import 'package:flutter_app/screen/utilities/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key, required this.sizingInformation});
  final SizingInformation sizingInformation;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      height: sizingInformation.screenSize.height * 0.08,
      padding: EdgeInsets.only(top: 5, left: 15, right: 15),
      child: OverflowBox(
        maxWidth: double.infinity, // Allow the child to overflow
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 16, // Set the desired radius
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                ),
              ],
            ),
            Container(
              height: 35,
              width: sizingInformation.screenSize.width * 0.668,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white70,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                  suffixIcon: Icon(
                    Icons.qr_code,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              width: 30,
              child: Icon(FontAwesomeIcons.facebookMessenger),
            ),
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Body())));
                  }).onError((error, stackTrace) {
                    util.toastmessage(error.toString());
                  });
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
