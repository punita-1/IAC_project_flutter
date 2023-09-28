import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:flutter_app/screen/pages/splash_Screens/splash_content.dart';
import 'package:flutter_svg/svg.dart';
import '../Sign_in/Sign_in.dart';
import '../sign_up/sign_up1.dart';

class Body extends StatefulWidget {
  const Body({Key? key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  String? facebookAccessToken;
  List<Map<String, String>> splashData = [
    {
      "text": "Join a trusted community of\n professionals",
      "image": "assets/logo.png",
    },
    {
      "text": "Build your network on the go",
      "image": "assets/network.jpg",
    },
    {
      "text": "Stay ahead with curated content for \nyour career",
      "image": "assets/career-logo.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemCount: splashData.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final image = splashData[index]["image"] ?? "logo.png";
                      final text = splashData[index]["text"] ??
                          "Join a trusted community of\n professionals";

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SplashContent(
                          image: image,
                          text: text,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(22),
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  splashData.length,
                                  (index) => buildDot(index: index),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: getProportionateScreenHeight(55),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        kPrimaryColor),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            side: const BorderSide(
                                                color: kPrimaryColor)))),
                                onPressed: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const SignUp(),
                                )),
                                child: Text(
                                  "Join now",
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(40),
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: getProportionateScreenHeight(55),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              side: const BorderSide(
                                                  color: Colors.black)))),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      SvgPicture.asset(
                                        "assets/google.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Continue with Google",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(40),
                                            color: Colors.black),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: getProportionateScreenHeight(55),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              side: BorderSide(
                                                  color: Colors.black)))),
                                  onPressed: () async {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      SvgPicture.asset(
                                        "assets/facebook.svg",
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Continue with Facebook",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(40),
                                            color: Colors.black),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => SignIn(),
                                  ),
                                );
                              },
                              child: Text(
                                "sign in",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.grey[800] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
