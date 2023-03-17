import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

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
        title: Text('Green Survival'),
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
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dGVjaG5vbG9neXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
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
              'Green Survival is an app developed by my team as an initiative to take a step forward in the betterment of our environment',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Github Link:',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: blueColor),
            ),
            Expanded(
              child: Text(
                'https://github.com/',
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
