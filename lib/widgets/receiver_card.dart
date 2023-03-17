import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiverCard extends StatelessWidget {
  final message;
  final date;
  const ReceiverCard({Key? key, required this.message, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          message,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text(
          DateFormat.yMMMd().format(date.toDate()),
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w300,
            color: blueColor,
          ),
          textAlign: TextAlign.left,
        ),
      ]),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 5, right: 100, bottom: 10, top: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: secondaryColor.withOpacity(0.1),
          ),
        ],
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
            topLeft: Radius.circular(3),
            bottomLeft: Radius.circular(3)),
        color: primaryColor,
      ),
    );
  }
}
