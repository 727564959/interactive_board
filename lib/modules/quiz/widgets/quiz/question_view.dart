import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/quiz/text_style.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../data/question.dart';
import '../../logic.dart';
import 'score_board.dart';
import 'answer_list.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final logic = Get.find<QuizLogic>();
  QuestionInfo get question => logic.quizState!.question;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final delay = Duration(milliseconds: (logic.config.questionTime + logic.config.answerTime) * 1000 - 600);
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
                  image: AssetImage(MirraIcons.getQuizIconPath("round_board_bg.png")),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Center(
                child: Text(
                  "${question.round} / ${logic.config.questionCount}",
                  style: TriviaTextStyles.title(color: const Color(0xffC1D3D4), fontSize: 50.sp),
                ),
              ),
            )
                .animate()
                .moveX(
                  curve: Curves.easeInOut,
                  begin: -0.7.sw,
                )
                .animate()
                .scale(end: Offset.zero, delay: delay, duration: 200.ms),

            SizedBox(height: 0.1.sh),
            SizedBox(
              width: 0.7.sw,
              child: AutoSizeText(
                question.title,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TriviaTextStyles.title(color: const Color(0xffA4EDF1), fontSize: 67.sp),
              ),
            )
                .animate()
                .moveX(curve: Curves.easeInOut, begin: -1.0.sw, delay: 30.ms)
                .animate()
                .scale(end: Offset.zero, delay: delay, duration: 200.ms),
            SizedBox(height: 0.08.sh),
            // if (bShowAnswer)
            SizedBox(
              width: 900.w,
              child: Countdown(
                seconds: logic.config.questionTime,
                interval: const Duration(milliseconds: 33),
                onFinished: () {},
                build: (context, time) {
                  final questionTime = logic.config.questionTime;
                  const totalSteps = 500;
                  final int currentStep = min(((questionTime - time) / questionTime * totalSteps).toInt(), 495);
                  return StepProgressIndicator(
                    totalSteps: totalSteps,
                    currentStep: currentStep,
                    size: 12,
                    padding: 0,
                    selectedColor: const Color(0xFF344337),
                    unselectedColor: currentStep > 300 ? Colors.red : const Color(0xFF4FBF64),
                    roundedEdges: const Radius.circular(6),
                  );
                },
              ),
            )
                .animate()
                .moveX(curve: Curves.easeInOut, begin: -1.0.sw, delay: 60.ms)
                .animate()
                .scale(end: Offset.zero, delay: delay, duration: 200.ms),
            SizedBox(height: 0.08.sh),
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
          ).animate().scale(end: Offset.zero, delay: delay, duration: 200.ms),
        ),
      ],
    );
  }
}
