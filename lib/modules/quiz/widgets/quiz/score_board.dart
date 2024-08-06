import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/quiz/text_style.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key, required this.score, required this.width});
  final int score;
  final double width;

  Widget getCount(int num) {
    return SizedBox(
      height: 0.4 * width,
      width: width * 0.27,
      child: AnimatedFlipCounter(
        value: num,
        textStyle: TriviaTextStyles.title(color: Colors.white, fontSize: width * 0.30),
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
          image: AssetImage(MirraIcons.getQuizIconPath("score_bg.png")),
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
