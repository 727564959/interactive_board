import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common.dart';

import 'widgets/cover_view.dart';
import 'widgets/tips_view.dart';
import 'widgets/question_view.dart';
import 'widgets/category_show_view.dart';

class QuizCoverPage extends StatelessWidget {
  const QuizCoverPage({Key? key}) : super(key: key);

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
            child: CoverView(key: UniqueKey()),
          ),
        ],
      ),
    );
  }
}
