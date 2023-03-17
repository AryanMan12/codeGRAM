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
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 0.2,
          ),
          Text(
            DateFormat.yMMMd().format(date.toDate()),
            style: TextStyle(
                fontSize: 9, color: Colors.black, fontWeight: FontWeight.w300),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(left: 100, right: 5, bottom: 3, top: 6),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: secondaryColor.withOpacity(0.1),
          ),
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            topRight: Radius.circular(3),
            bottomRight: Radius.circular(3)),
        color: secondaryColor,
      ),
    );
  }
}
