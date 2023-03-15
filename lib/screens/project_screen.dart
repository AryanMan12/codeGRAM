import 'package:codegram/screens/forms_screen.dart';
import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/project_item.dart';

class Projects_Screen extends StatefulWidget {
  const Projects_Screen({Key? key}) : super(key: key);

  @override
  State<Projects_Screen> createState() => _Projects_ScreenState();
}

class _Projects_ScreenState extends State<Projects_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () {},
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Text(
              "Projects",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21.0,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            ProjectItem(),
            ProjectItem(),
            ProjectItem(),
            ProjectItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FormsPage(),
        )),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
