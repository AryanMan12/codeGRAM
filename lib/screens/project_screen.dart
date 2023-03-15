import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';

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
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
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
                    fit: BoxFit.scaleDown,
                    image: NetworkImage(
                        "https://www.ikea.com/in/en/images/products/fejka-artificial-potted-plant-in-outdoor-monstera__0614197_pe686822_s5.jpg"),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Column(
            children: <Widget>[
              Container(
                width: 100.0,
                child: Text(
                  "Green Survival",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 22.0,
          ),
          Column(
            children: <Widget>[
              Container(
                width: 100.0,
                height: 30.0,
                alignment: Alignment.centerRight,
                child: Text(
                  "View",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
