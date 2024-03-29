import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegram/models/post.dart';
import 'package:codegram/models/project.dart';
import 'package:codegram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error Occurred!";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postid = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postid: postid,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postid).set(
            post.toJson(),
          );
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComments(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
      } else {
        print("Text is Empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createChats(String chatUser, String uid) async {
    try {
      String chatId = const Uuid().v1();
      var users = [uid, chatUser];
      users.sort();
      await _firestore
          .collection('chats')
          .where('users', isEqualTo: users)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          _firestore.collection('chats').doc(chatId).set({
            'chatId': chatId,
            'users': users,
            'lastdate': "",
            'messages': [],
            'sender': [],
            'timeStamps': [],
          });
        } else {
          print("Already there");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMessage(List<dynamic> message, List<dynamic> sender,
      String uid, String chatUser) async {
    try {
      var users = [uid, chatUser];
      users.sort();
      if (message.isNotEmpty) {
        var currentTime = DateTime.now();
        await _firestore
            .collection('chats')
            .where('users', isEqualTo: users)
            .get()
            .then((value) => value.docs.first.reference.update({
                  'lastdate': currentTime,
                  'messages': message,
                  'sender': sender,
                  'timeStamps': FieldValue.arrayUnion([currentTime]),
                }));
      } else {
        print("Text is Empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> saveEditedProfile(
      String uid,
      String username,
      String bio,
      String ogUsername,
      String ogBio,
      Uint8List? file,
      String ogPhotoUrl) async {
    String ret = "Unsuccessful";
    String photoUrl = ogPhotoUrl;
    try {
      if (username.isEmpty) {
        username = ogUsername;
      }
      if (bio.isEmpty) {
        bio = ogBio;
      }
      if (file != null) {
        photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
      }
      await _firestore
          .collection('users')
          .doc(uid)
          .update({'username': username, 'bio': bio, 'photoUrl': photoUrl});
      ret = "Successfull";
    } catch (e) {
      print(e.toString());
    }
    return ret;
  }

  Future<String> uploadProject(
      String projName,
      String description,
      Uint8List file,
      String uid,
      String username,
      String profImage,
      String projectLink) async {
    String res = "Some error Occurred!";
    try {
      if (projName.isEmpty) {
        res = "Project Name Cannot be Empty";
      }
      String photoUrl =
          await StorageMethods().uploadImageToStorage('projects', file, true);

      String projId = const Uuid().v1();

      Project project = Project(
          projectName: projName,
          projectId: projId,
          description: description,
          uid: uid,
          username: username,
          projPhotoUrl: photoUrl,
          profImage: profImage,
          projectLink: projectLink,
          datePublished: DateTime.now(),
          likes: []);

      _firestore.collection('projects').doc(projId).set(
            project.toJson(),
          );
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likeProject(String projectId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('projects').doc(projectId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('projects').doc(projectId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
