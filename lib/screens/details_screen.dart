import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final snap;

  const DetailsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final double coverHeight = 280;
  final double projectHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.snap["projectName"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 90,
                backgroundColor: primaryColor,
                backgroundImage: NetworkImage(widget.snap["projPhotoUrl"]),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description:',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: blueColor),
            ),
            Text(
              widget.snap["description"],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Project Link:',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: blueColor),
            ),
            Expanded(
              child: Text(
                widget.snap["projectLink"],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Want to Join?',
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Ask!'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
