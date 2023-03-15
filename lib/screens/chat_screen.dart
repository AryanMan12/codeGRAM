import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegram/models/user.dart';
import 'package:codegram/providers/user_provider.dart';
import 'package:codegram/resources/firestore_methods.dart';
import 'package:codegram/utils/colors.dart';
import 'package:codegram/widgets/receiver_card.dart';
import 'package:codegram/widgets/sender_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final snap;
  const ChatScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> messages = [];
  List<dynamic> sender = [];
  final TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _chatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(widget.snap['photoUrl']),
          ),
        ),
        title: Text(widget.snap['username']),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          messages = (snapshot.data! as dynamic).docs[0]["messages"];
          sender = (snapshot.data! as dynamic).docs[0]["sender"];

          List<dynamic> timeStamps =
              (snapshot.data! as dynamic).docs[0]["timeStamps"];

          return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => sender[index] == user.uid
                  ? SenderCard(
                      message: messages[index],
                      date: timeStamps[index],
                    )
                  : ReceiverCard(
                      message: messages[index],
                      date: timeStamps[index],
                    ));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 10, right: 8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 8),
                  child: TextField(
                    controller: _chatController,
                    decoration: const InputDecoration(
                      hintText: "Message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  messages.add(_chatController.text);
                  sender.add(user.uid);
                  FirestoreMethods().sendMessage(
                      messages, sender, user.uid, widget.snap['username']);
                  _chatController.text = "";
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
