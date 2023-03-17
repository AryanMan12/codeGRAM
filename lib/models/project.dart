import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String projectName;
  final String projectId;
  final String description;
  final String uid;
  final String username;
  final String projPhotoUrl;
  final String profImage;
  final String projectLink;
  final datePublished;
  final likes;

  const Project({
    required this.projectName,
    required this.projectId,
    required this.description,
    required this.uid,
    required this.username,
    required this.projPhotoUrl,
    required this.profImage,
    required this.projectLink,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "projectName": projectName,
        "projectId": projectId,
        "description": description,
        "uid": uid,
        "username": username,
        "projPhotoUrl": projPhotoUrl,
        "profImage": profImage,
        "projectLink": projectLink,
        "datePublished": datePublished,
        "likes": likes,
      };

  static ProjectfromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Project(
      projectName: snapshot["projectName"],
      projectId: snapshot["projectId"],
      description: snapshot["description"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      projPhotoUrl: snapshot["projPhotoUrl"],
      profImage: snapshot["profImage"],
      projectLink: snapshot["projectLink"],
      datePublished: snapshot["datePublished"],
      likes: snapshot["likes"],
    );
  }
}
