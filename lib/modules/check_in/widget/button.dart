import 'package:flutter/material.dart';

import '../../../common.dart';

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.disable = false,
  }) : super(key: key);
  final String title;
  final void Function() onPress;
  final bool disable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (detail) => disable ? null : onPress(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 80),
        decoration: BoxDecoration(
          color: disable ? Colors.grey : Colors.deepPurpleAccent,
          borderRadius: const BorderRadius.all(Radius.circular(26.5)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            decoration: TextDecoration.none,
            fontFamily: 'Burbank',
            color: Colors.white,
            textBaseline: TextBaseline.ideographic,
          ),
        ),
      ),
    );
  }
}
