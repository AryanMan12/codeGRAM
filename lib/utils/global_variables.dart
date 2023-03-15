import 'package:codegram/screens/add_post_screen.dart';
import 'package:codegram/screens/feed_screen.dart';
import 'package:codegram/screens/profile_screen.dart';
import 'package:codegram/screens/project_screen.dart';
import 'package:codegram/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const ProjectScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
