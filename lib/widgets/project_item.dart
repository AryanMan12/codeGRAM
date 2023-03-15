import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dGVjaG5vbG9neXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Project Name",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
                ),
                Text(
                  "Project Description...",
                  style: TextStyle(fontSize: 12.0, color: secondaryColor),
                ),
              ],
            ),
          ),
          Text(
            "View",
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
