import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../common.dart';
import '../logic.dart';
import 'answer_list.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              "1 / 10",
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
          width: 0.5.sw,
          child: Text(
            "Who is known for his role as Jack Dawson in the movie \"Titanic\" (1997)?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 80.sp,
              decoration: TextDecoration.none,
              fontFamily: 'Burbank',
              color: const Color(0xFFFFE350),
            ),
          ),
        ),
        SizedBox(height: 0.1.sh),
        AnswerList(
          width: 400.w,
        ),
        SizedBox(height: 0.1.sh),
        SizedBox(
          width: 700.w,
          child: Countdown(
            seconds: 15,
            interval: const Duration(milliseconds: 33),
            build: (context, time) {
              const totalSteps = 500;
              final int currentStep = min(((15 - time) / 15 * totalSteps).toInt(), 495);

              return StepProgressIndicator(
                totalSteps: totalSteps,
                currentStep: currentStep,
                size: 12,
                padding: 0,
                selectedColor: const Color(0xFF344337),
                unselectedColor: const Color(0xFF4FBF64),
                roundedEdges: const Radius.circular(6),
              );
            },
          ),
        ),
      ],
    );
  }
}
