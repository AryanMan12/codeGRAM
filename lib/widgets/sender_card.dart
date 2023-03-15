import 'package:codegram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderCard extends StatelessWidget {
  final message;
  final date;
  const SenderCard({Key? key, required this.message, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          DateFormat.yMMMd().format(date.toDate()),
          style: TextStyle(fontSize: 10),
        ),
      ]),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(left: 100, right: 2, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
        color: secondaryColor,
      ),
    );
  }
}
