import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_app/screen/pages/Sign_in/Sign_in.dart';
import 'package:flutter_app/screen/pages/home_page/add_post.dart';
// import 'package:flutter_app/screen/pages/sign_up/sign_up1.dart';
import 'package:flutter_app/screen/pages/splash_Screens/body.dart';
import 'package:flutter_app/screen/utilities/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Body()));
                }).onError((error, stackTrace) {
                  util.toastmessage(error.toString());
                });
              },
              icon: Icon(Icons.logout)),
          SizedBox(
            width: 18,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPostScreen()));
          },
          child: Icon(Icons.add)),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchFilter,
                decoration: InputDecoration(
                    hintText: "search", border: OutlineInputBorder()),
                onChanged: (String value) {
                  setState(() {});
                },
              )),
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              //initialData: initialData,
              builder: (BuildContext context,
                  AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Map<dynamic, dynamic>? map =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                  if (map == null) {
                    return Center(
                      child: Text("No posts available."),
                    );
                  }
                  List<dynamic> list = map.values.toList();

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      String postTitle = list[index]["title"] ?? "";
                      String postId = list[index]["id"] ?? "";

                      if (searchFilter.text.isEmpty ||
                          postTitle
                              .toLowerCase()
                              .contains(searchFilter.text.toLowerCase())) {
                        return ListTile(
                          title: Text(postTitle),
                          subtitle: Text(postId),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);

                                      ShowMyDialog(postTitle, postId);
                                    },
                                    leading: Icon(Icons.edit),
                                    title: Text("Edit"),
                                  )),
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      ref.child(postId).remove();
                                    },
                                    leading: Icon(Icons.delete_outline),
                                    title: Text("Delete"),
                                  ))
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> ShowMyDialog(String postTitle, String postId) async {
    editController.text = postTitle;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(hintText: "edit"),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(postId).update({
                      "title": editController.text.toLowerCase()
                    }).then((value) {
                      util.toastmessage('Post Updated');
                    }).onError((error, stackTrace) {
                      util.toastmessage(error.toString());
                    });
                  },
                  child: Text("update"))
            ],
          );
        });
  }
}
