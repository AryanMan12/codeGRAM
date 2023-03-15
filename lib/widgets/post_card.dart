import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegram/models/user.dart';
import 'package:codegram/providers/user_provider.dart';
import 'package:codegram/resources/firestore_methods.dart';
import 'package:codegram/screens/comment_screen.dart';
import 'package:codegram/screens/profile_screen.dart';
import 'package:codegram/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot cSnap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postid'])
          .collection('comments')
          .get();

      commentLen = cSnap.docs.length;
    } catch (e) {
      log(e.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(uid: widget.snap['uid']),
                  )),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap["username"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(widget.snap["postUrl"], fit: BoxFit.cover),
          ),
          // Footer
          Row(
            children: [
              Row(children: [
                CupertinoButton(
                  minSize: double.minPositive,
                  padding: const EdgeInsets.only(left: 8),
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                        widget.snap['postid'], user.uid, widget.snap["likes"]);
                  },
                  child: widget.snap["likes"].contains(user.uid)
                      ? const Icon(
                          CupertinoIcons.add,
                          color: Colors.blue,
                          size: 28,
                          weight: 30,
                        )
                      : const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                ),
                CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                        widget.snap['postid'], user.uid, widget.snap["likes"]);
                  },
                  child: widget.snap["likes"].contains(user.uid)
                      ? const Icon(
                          CupertinoIcons.add,
                          color: Colors.blue,
                          size: 28,
                        )
                      : const Icon(
                          CupertinoIcons.add,
                          size: 28,
                          color: Colors.white,
                        ),
                ),
              ]),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(snap: widget.snap),
                  ),
                ),
                icon: const Icon(Icons.comment_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          // Description
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                    child: Text(
                      '${widget.snap["likes"].length} likes',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                        text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap["username"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.snap["description"]}',
                        ),
                      ],
                    )),
                  )
                ]),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CommentScreen(
                  snap: widget.snap,
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                "View all $commentLen comments",
                style: const TextStyle(
                  fontSize: 16,
                  color: secondaryColor,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              DateFormat.yMMMd().format(
                widget.snap["datePublished"].toDate(),
              ),
              style: const TextStyle(
                fontSize: 12,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
