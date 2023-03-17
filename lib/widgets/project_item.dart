import 'package:codegram/screens/details_screen.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ProjectItem extends StatelessWidget {
  final snap;
  const ProjectItem({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            snap: snap,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                      image: NetworkImage(snap['projPhotoUrl']),
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
                    snap["projectName"],
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
                  ),
                  Text(
                    snap["description"],
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "${snap["likes"].length}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  "likes",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
