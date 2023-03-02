import 'package:codegram/screens/add_post_screen.dart';
import 'package:codegram/screens/feed_screen.dart';
import 'package:codegram/screens/search_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("Notifications"),
  Text("Profile"),
];
