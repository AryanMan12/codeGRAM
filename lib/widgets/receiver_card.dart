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
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          DateFormat.yMMMd().format(date.toDate()),
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ]),
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 2, right: 100, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
        color: primaryColor,
      ),
    );
  }
}
