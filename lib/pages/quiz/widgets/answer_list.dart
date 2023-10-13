import 'package:flutter/material.dart';

class AnswerList extends StatelessWidget {
  const AnswerList({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      color: Colors.cyan,
    );
  }
}
