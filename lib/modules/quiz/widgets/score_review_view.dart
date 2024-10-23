import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;
import 'package:flutter/material.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/modules/quiz/text_style.dart';
import '../logic.dart';

class ScoreReviewView extends StatelessWidget {
  ScoreReviewView({super.key});
  final logic = Get.find<QuizLogic>();
  final upperHeight = 0.5.sh;
  final baseHeight = 0.3.sh;
  List<Widget> get children {
    return logic.records
        .map((e) => _ScoreBar(
              score: e.score,
              tableId: e.tableId,
              rank: e.rank,
              height: upperHeight * e.score / 100 + baseHeight,
            ))
        .toList();
  }

  int get score {
    return logic.records.firstWhere((e) => e.tableId == Global.tableId).rankScore;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.05.sh),
        Text(
          "Score Review",
          style: TriviaTextStyles.title(
            fontSize: 90.sp,
            color: const Color(0xff13EFEF),
          ),
        ),
        SizedBox(height: 0.05.sh),
        FadeIn(
          delay: 1.seconds,
          child: Text(
            "SQUAD ${ascii.decode([0x40 + Global.tableId])}    +$score",
            style: TriviaTextStyles.title(
              fontSize: 60.sp,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        )
      ],
    );
  }
}

class _ScoreBar extends StatefulWidget {
  const _ScoreBar({
    Key? key,
    required this.score,
    required this.tableId,
    required this.rank,
    required this.height,
  }) : super(key: key);
  final double height;
  final int score;
  final int tableId;
  final int rank;
  @override
  State<_ScoreBar> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<_ScoreBar> with TickerProviderStateMixin {
  double get width => 270.w;
  double get height => widget.height;
  int get score => widget.score;
  int get tableId => widget.tableId;
  int get rank => widget.rank;
  final upperHeight = 0.5.sh;
  final baseHeight = 0.3.sh;
  late AnimationController controller;
  late final Animation<double> animation;
  late final Animation<double> scoreAnimation;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: 1.seconds);

    animation = Tween<double>(begin: upperHeight * score / 100, end: 0).animate(controller);
    scoreAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  Color get color {
    if (tableId == 1) {
      return const Color(0xFFC73616);
    } else if (tableId == 2) {
      return const Color(0xFFD74D22);
    } else if (tableId == 3) {
      return const Color(0xFFE8651B);
    } else if (tableId == 4) {
      return const Color(0xFFEB882D);
    } else if (tableId == 5) {
      return const Color(0xFF9C60D8);
    } else if (tableId == 6) {
      return const Color(0xFFAB4CCD);
    } else if (tableId == 7) {
      return const Color(0xFF9A20C6);
    } else {
      return const Color(0xFF6B16BF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, animation.value),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        width: width,
        height: height,
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: width,
                  height: height - 170.w,
                  color: color,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (scoreAnimation.value * score ~/ 1).toString(),
                      style: TriviaTextStyles.title(
                        fontSize: 100.sp,
                        color: Colors.white,
                      ),
                    ),
                    _Circle(
                      rank: rank,
                      width: 120.w,
                    ),
                    SizedBox(height: 20.w),
                    Container(
                      height: 55.w,
                      padding: EdgeInsets.only(top: 10.w, bottom: 8.w),
                      width: 130.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(27.5.w),
                      ),
                      child: AutoSizeText(
                        "SQUAD ${ascii.decode([0x40 + tableId])}",
                        maxLines: 1,
                        style: TriviaTextStyles.title(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({
    Key? key,
    required this.rank,
    required this.width,
  }) : super(key: key);
  final int rank;
  final double width;
  Color get color {
    if (rank == 1) {
      return const Color(0xFFC93000);
    } else if (rank == 2) {
      return const Color(0xFFFA6424);
    } else if (rank == 3) {
      return const Color(0xFF72AF42);
    } else {
      return const Color(0xFFA36A52);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: Stack(
        alignment: const Alignment(0, -0.3),
        children: [
          Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.5),
            ),
          ),
          Container(
            width: width * 0.9,
            height: width * 0.9,
            alignment: const Alignment(0, 0.2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(width * 0.45),
            ),
            child: Text(
              rank.toString(),
              style: TriviaTextStyles.title(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
