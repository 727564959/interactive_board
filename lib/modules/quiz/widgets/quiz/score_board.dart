import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import '../../../../common.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key, required this.score, required this.width}) : super(key: key);
  final int score;
  final double width;

  Widget getCount(int num) {
    return SizedBox(
      height: 0.4 * width,
      width: width * 0.27,
      child: AnimatedFlipCounter(
        value: num,
        textStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: width * 0.35,
          decoration: TextDecoration.none,
          fontFamily: 'BurbankBold',
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = 0.715 * width;
    final num1 = score ~/ 100;
    final num2 = (score % 100) ~/ 10;
    final num3 = score % 10;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Global.getQuizIconUrl("score_bg.png")),
          fit: BoxFit.fill,
        ),
      ),
      child: Align(
        alignment: const Alignment(0.0, 0.5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [getCount(num1), getCount(num2), getCount(num3)],
        ),
      ),
    );
  }
}
