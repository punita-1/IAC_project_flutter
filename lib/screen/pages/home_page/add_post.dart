import 'package:flutter/material.dart';
import 'package:flutter_app/screen/constants.dart';
import 'package:flutter_app/screen/size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/screen/utilities/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
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

                  databaseRef.child(id).set({
                    'title': postController.text.toString(),
                    'id': id,
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });

                    util.toastmessage('Post Added');
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
