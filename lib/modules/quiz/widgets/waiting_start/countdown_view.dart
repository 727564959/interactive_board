import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../logic.dart';
import '../../text_style.dart';

class CountdownView extends StatelessWidget {
  CountdownView({super.key});
  final logic = Get.find<QuizLogic>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Countdown(
        seconds: logic.countdown,
        build: (context, time) => Text(
          "${time.toInt() + 1}",
          style: TriviaTextStyles.title(
            fontSize: 400.sp,
            color: const Color(0xff13EFEF),
          ),
        ),
      ),
    );
  }
}
