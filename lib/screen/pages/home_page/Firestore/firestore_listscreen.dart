// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/screen/pages/Sign_in/Sign_in.dart';
import 'package:flutter_app/screen/pages/home_page/Firestore/add_FireStore_data.dart';
// import 'package:flutter_app/screen/pages/home_page/add_post.dart';
import 'package:flutter_app/screen/utilities/utils.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("users").snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddFireStoreDataScreen()));
          },
          child: Icon(Icons.add)),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: firestore,
            // initialData: initialData,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              if (snapshot.hasError) return Text("Some Error");
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    String title = snapshot.data!.docs[index]['title'];
                    String id = snapshot.data!.docs[index].id;

                    return ListTile(
                      title: Text(title),
                      subtitle: Text(id),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);

                                  ShowMyDialog(title, id);
                                },
                                leading: Icon(Icons.edit),
                                title: Text("Edit"),
                              )),
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  ref.doc(id).delete().then((_) {
                                    util.toastmessage('Post Deleted');
                                  }).catchError((error) {
                                    util.toastmessage(
                                        'Error deleting post: $error');
                                  });
                                },
                                leading: Icon(Icons.delete_outline),
                                title: Text("Delete"),
                              ))
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
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
                    // Update Firestore document here
                    ref.doc(postId).update({
                      'title': editController.text,
                    }).then((_) {
                      util.toastmessage('Post Updated');
                    }).catchError((error) {
                      util.toastmessage('Error updating post: $error');
                    });
                  },
                  child: Text("update"))
            ],
          );
        });
  }
}
