import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, i) => Container(
        padding: EdgeInsets.all(8),
        child: Text('This Works!'),
      ),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection('chats/kLUXFPqv8qInucME9qCd/messages')
              .snapshots()
              .listen((event) {
               // print(event.docs[0]['text']);
               event.docs.forEach((element) {
                 print(element['text']);
               });
              });
        },
      ),
    );
  }
}
