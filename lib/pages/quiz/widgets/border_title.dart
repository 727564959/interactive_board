import 'package:flutter/material.dart';

class BorderTitle extends StatelessWidget {
  const BorderTitle({Key? key, required this.fontSize, required this.title}) : super(key: key);
  final double fontSize;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(0, fontSize * 0.06),
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = fontSize * 0.15
                ..color = const Color(0xFF50E9C4),
              fontFamily: 'Burbank',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = fontSize * 0.15
              ..color = Colors.black,
            fontFamily: 'Burbank',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFFFCFF77),
            fontWeight: FontWeight.bold,
            fontFamily: 'Burbank',
          ),
        ),
      ],
    );
  }
}
