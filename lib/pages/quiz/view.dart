import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;

import '../../common.dart';
import 'logic.dart';
import 'widgets/waiting_start/cover_view.dart';
import 'widgets/quiz/quiz_view.dart';

class QuizCoverPage extends StatelessWidget {
  QuizCoverPage({Key? key}) : super(key: key);
  final logic = Get.find<QuizLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Transform.scale(
            scale: 2,
            child: SizedBox(
              width: 1.0.sw,
              child: Image.asset(
                Global.getQuizIconUrl('background.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat()).rotate(duration: 30.seconds, begin: 0, end: 1.0),
          SizedBox(
            width: 1.0.sw,
            height: 1.0.sh,
            child: GetBuilder<QuizLogic>(
              id: "page",
              builder: (logic) {
                if (logic.pageState == PageState.waiting) {
                  return const CoverView();
                } else {
                  return QuizView(key: UniqueKey());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
