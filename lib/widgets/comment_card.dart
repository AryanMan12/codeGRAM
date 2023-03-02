import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1677629828024-7793ff7d9403?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
          ),
          radius: 18,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "username",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "some description",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "02-03-2023",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ))
                ]),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.favorite,
            size: 16,
          ),
        )
      ]),
    );
  }
}
