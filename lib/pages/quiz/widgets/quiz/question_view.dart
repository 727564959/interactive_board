import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/quiz/data/question.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../common.dart';
import '../../logic.dart';
import 'score_board.dart';
import 'answer_list.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final logic = Get.find<QuizLogic>();
  QuestionInfo get question => logic.quizState!.question;
  bool bShowAnswer = false;
  @override
  void initState() {
    Future.delayed(2.seconds).then((value) => setState(() => bShowAnswer = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 84.w,
              width: 243.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Global.getQuizIconUrl("round_board_bg.png")),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Center(
                child: Text(
                  "${question.round} / ${logic.questionCount}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 60.sp,
                    decoration: TextDecoration.none,
                    fontFamily: 'Burbank',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0.1.sh),
            SizedBox(
              width: 0.7.sw,
              child: Text(
                question.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 80.sp,
                  decoration: TextDecoration.none,
                  fontFamily: 'BurbankBold',
                  color: const Color(0xFFFFE350),
                ),
              ),
            ),
            SizedBox(height: 0.08.sh),
            if (bShowAnswer)
              SizedBox(
                width: 900.w,
                child: Countdown(
                  seconds: 11,
                  interval: const Duration(milliseconds: 33),
                  onFinished: () {},
                  build: (context, time) {
                    const totalSteps = 500;
                    final int currentStep = min(((11 - time) / 11 * totalSteps).toInt(), 495);
                    return StepProgressIndicator(
                      totalSteps: totalSteps,
                      currentStep: currentStep,
                      size: 12,
                      padding: 0,
                      selectedColor: const Color(0xFF344337),
                      unselectedColor: currentStep > 308 ? Colors.red : const Color(0xFF4FBF64),
                      roundedEdges: const Radius.circular(6),
                    );
                  },
                ),
              ).animate().scaleX(duration: 400.ms),
            SizedBox(height: 0.08.sh),
            if (bShowAnswer)
              GetBuilder<QuizLogic>(
                id: 'answer',
                builder: (_) {
                  return AnswerList(
                    width: 700.w,
                  );
                },
              ),
          ],
        ),
        Align(
          alignment: const Alignment(0.9, 0.9),
          child: GetBuilder<QuizLogic>(
            id: 'score',
            builder: (logic) {
              return ScoreBoard(
                width: 300.w,
                score: logic.score,
              );
            },
          ),
        ),
      ],
    );
  }
}
