import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
// import 'package:flutter_app/screen/pages/home_page/Firestore/firestore_listscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:flutter_app/screen/utilities/utils.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_app/screen/utilities/utils.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({super.key});

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final firestore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore Data"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "what is in your mind?",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
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
                      side: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  firestore.doc().set({
                    'title': postController.text.toString(),
                    'id': id,
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    util.toastmessage("Post added");
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    util.toastmessage(error.toString());
                  });
                },
                child: loading
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      )
                    : Text(
                        "add",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(22),
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
