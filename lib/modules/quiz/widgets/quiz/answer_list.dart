import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;
import 'package:interactive_board/modules/quiz/text_style.dart';

import '../../logic.dart';
import 'answer_cell.dart';

class AnswerList extends StatelessWidget {
  AnswerList({
    super.key,
    required this.width,
  });
  final logic = Get.find<QuizLogic>();
  final double width;
  QuizState get state => logic.quizState!;

  List<Widget> get children {
    final result = <Widget>[];

    for (int i = 0; i < 3; i++) {
      bool? bRight;
      if (state.bShowAnswer) {
        if (state.selected == i) {
          bRight = state.selected == state.question.correctAnswer;
        }
        if (state.question.correctAnswer == i) {
          bRight = true;
        }
      }
      result.add(
        GestureDetector(
          onTapUp: (detail) {
            logic.select(i);
          },
          child: AnswerCell(
            index: i,
            title: state.question.selections[i],
            width: width,
            bSelected: state.selected == i,
            bRight: bRight,
          )
              .animate()
              .moveX(
                curve: Curves.easeInOut,
                begin: -1.0.sw,
                delay: (i * 30 + 90).ms,
              )
              .animate()
              .scale(end: Offset.zero, delay: 17500.ms, duration: 200.ms),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          height: width * 0.5,
          // color: Colors.cyan,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children),
        ),
        SizedBox(height: 0.08.sh),
        if (state.bShowAnswer && state.selected == null)
          Text(
            "Miss",
            style: TriviaTextStyles.title(
              color: const Color(0xFF8B8282),
              fontSize: 120.sp,
            ),
          ).animate().scale(duration: 200.ms).fadeOut(delay: 2.seconds, duration: 300.ms),
      ],
    );
  }
}
