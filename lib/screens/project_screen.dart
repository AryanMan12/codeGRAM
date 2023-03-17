import 'package:codegram/screens/forms_screen.dart';
import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/project_item.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: const Text(
          "Projects",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 4.0,
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
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
