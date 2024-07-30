import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/quiz/text_style.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../logic.dart';

class JoinedButton extends StatelessWidget {
  JoinedButton({Key? key, required this.width}) : super(key: key);
  final double width;
  final logic = Get.find<QuizLogic>();
  String get backgroundUri => logic.joinedQuiz
      ? MirraIcons.getQuizIconPath("join_button_bg_disable.png")
      : MirraIcons.getQuizIconPath("join_button_bg.png");
  Widget get content {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: width * 0.15,
      decoration: TextDecoration.none,
      fontFamily: 'Burbank',
      color: Colors.white,
      textBaseline: TextBaseline.ideographic,
    );
    if (!logic.joinedQuiz) {
      return Text(
        "JOIN",
        style: TriviaTextStyles.title(
          fontSize: width * 0.15,
          color: Colors.white,
        ),
      );
    } else {
      return Countdown(
        seconds: logic.countdown,
        build: (context, time) => Text(
          "${time.toInt()}s",
          style: TriviaTextStyles.title(
            fontSize: width * 0.15,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (detail) {
        logic.join();
      },
      child: GetBuilder<QuizLogic>(
        id: "joined",
        builder: (logic) {
          return Container(
            height: width / 2,
            width: width,
            padding: EdgeInsets.only(left: width * 0.15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -width * 0.02),
                  child: Icon(
                    Icons.play_arrow,
                    size: width * 0.18,
                    color: logic.joinedQuiz ? const Color(0xFFC0C0C0) : const Color(0xFFFFE350),
                  ),
                ),
                SizedBox(width: width * 0.05),
                content,
              ],
            ),
          );
        },
      ),
    );
  }
}
