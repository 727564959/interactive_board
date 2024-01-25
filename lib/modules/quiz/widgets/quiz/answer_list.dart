import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;

import '../../logic.dart';
import 'answer_cell.dart';

class AnswerList extends StatelessWidget {
  AnswerList({
    Key? key,
    required this.width,
  }) : super(key: key);
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
          ),
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
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 120.sp,
              decoration: TextDecoration.none,
              fontFamily: 'Burbank',
              color: const Color(0xFF8B8282),
            ),
          ).animate().scale(duration: 200.ms).fadeOut(delay: 2.seconds, duration: 300.ms),
      ],
    );
  }
}
