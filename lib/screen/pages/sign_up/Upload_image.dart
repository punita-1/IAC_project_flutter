import 'dart:io';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/pages/home_page/home_page.dart';
import 'package:flutter_app/screen/pages/home_page/mobile_screen_home.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:flutter_app/screen/utilities/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('post');
  bool imageUploaded = false;
  Future getImageGallary() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageUploaded = true; // Set the flag to true when an image is uploaded
      } else {
        print('No Image Picked');
      }
    });
  }

  Future<void> uploadImage() async {
    setState(() {
      loading = true;
    });

    if (_image == null) {
      setState(() {
        loading = false;
      });
      return;
    }

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('/folder' + '/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = ref.putFile(_image!);

      await uploadTask.whenComplete(() async {
        final newUrl = await ref.getDownloadURL();
        await databaseRef
            .child('1')
            .set({'id': '1212', 'title': newUrl.toString()});
        util.toastmessage('Upload');
        setState(() {
          loading = false;
        });
      });
    } catch (error) {
      util.toastmessage('Error: $error');
      setState(() {
        loading = false;
      });
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(
              "assets/logo.png",
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Adding a photo helps people recognize you',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      getImageGallary();
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200, // Shadow color
                            offset:
                                const Offset(10, 10), // Offset of the shadow
                            blurRadius: 4, // Blur radius of the shadow
                          ),
                        ],
                      ),
                      child: _image != null
                          ? Image.file(_image!.absolute)
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Icon(
                                  Icons.image,
                                  size: 50,
                                )),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (!imageUploaded) // Display "Add a photo" button if no image is uploaded
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    kPrimaryColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  uploadImage();
                },
                child: loading
                    ? const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      )
                    : Text(
                        "Add a photo",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(40),
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          if (imageUploaded) // Display "Next" button if an image is uploaded
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    kPrimaryColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MobileScreen()));
                  // Handle the action when the user clicks "Next"
                  // This is where you can navigate to the next screen or perform any other action.
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(40),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text(
                  "Skip for now",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: getProportionateScreenWidth(40)),
                )),
          )
        ],
      ),
    )));
  }
}
