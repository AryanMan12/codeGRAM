import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegram/models/user.dart';
import 'package:codegram/providers/user_provider.dart';
import 'package:codegram/resources/firestore_methods.dart';
import 'package:codegram/screens/chat_screen.dart';
import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    List<String> chats = [];
    for (int i = 0; i < user.followers.length; i++) {
      if (user.following.contains(user.followers[i])) {
        chats.add(user.followers[i]);
        FirestoreMethods().createChats(user.followers[i], user.uid);
      }
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text("Messages"),
          centerTitle: false,
          elevation: .7,
        ),
        body: chats.isEmpty
            ? Center(
                child: Text(
                  "Follow a Follower to start a chat!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 36,
                  ),
                ),
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', whereIn: chats)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              snap: (snapshot.data! as dynamic)
                                  .docs[index]
                                  .data(),
                            ),
                          ),
                        ),
                        child: Column(children: [
                          ListTile(
                            minVerticalPadding: 20,
                            tileColor: mobileBackgroundColor,
                            selectedTileColor: mobileSearchColor,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['photoUrl']),
                              radius: 25,
                            ),
                            title: Text(
                              (snapshot.data! as dynamic).docs[index]
                                  ['username'],
                            ),
                          ),
                          const Divider()
                        ]),
                      );
                    },
                  );
                },
              ));
  }
}
