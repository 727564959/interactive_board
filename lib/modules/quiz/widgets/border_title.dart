import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BorderTitle extends StatelessWidget {
  const BorderTitle({super.key, required this.fontSize, required this.title});
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
    ).animate().scale(curve: Curves.elasticOut, duration: 1.seconds);
  }
}
