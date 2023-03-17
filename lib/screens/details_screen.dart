import 'dart:developer';

import 'package:codegram/screens/profile_screen.dart';
import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';

class DetailsScreen extends StatefulWidget {
  final snap;
  final userUid;
  const DetailsScreen({Key? key, required this.snap, required this.userUid})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final double coverHeight = 280;
  final double projectHeight = 144;
  bool _liked = false;
  bool _alreadyLiked = false;
  int numOfLikes = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _liked = widget.snap["likes"].contains(widget.userUid);
      _alreadyLiked = _liked;
      log(_liked.toString());
      numOfLikes = widget.snap["likes"].length;
    });
  }

  void _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void deactivate() async {
    super.deactivate();
    if (_alreadyLiked || _liked) {
      await FirestoreMethods().likeProject(
          widget.snap['projectId'], widget.userUid, widget.snap["likes"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snap["projectName"]),
        backgroundColor: mobileBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundColor: primaryColor,
                backgroundImage: NetworkImage(widget.snap["projPhotoUrl"]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Creator:',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: blueColor),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(uid: widget.snap["uid"]),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: primaryColor,
                        backgroundImage: NetworkImage(widget.snap["profImage"]),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.snap["username"],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _liked = !_liked;
                            if (!_alreadyLiked) {
                              if (_liked) {
                                numOfLikes++;
                              } else {
                                numOfLikes--;
                              }
                            } else {
                              if (_liked) {
                                numOfLikes++;
                              } else {
                                numOfLikes--;
                              }
                            }
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: _liked ? blueColor : Colors.white,
                        )),
                    Text("$numOfLikes")
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Description:',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: blueColor),
            ),
            Text(
              widget.snap["description"],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Project Link:',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: blueColor),
            ),
            InkWell(
              onTap: () => _launchURL(widget.snap["projectLink"]),
              child: Text(
                widget.snap["projectLink"],
                style: const TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            const Text(
              'Want to Join?',
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Ask!',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
