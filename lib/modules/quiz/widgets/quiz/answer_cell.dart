import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/3rd_libs/gif_view-0.4.3/gif_view.dart';
import 'package:interactive_board/modules/quiz/text_style.dart';

class AnswerCell extends StatefulWidget {
  const AnswerCell({
    super.key,
    required this.width,
    required this.bSelected,
    this.bRight,
    required this.title,
    required this.index,
    required this.score,
  });
  final double width;
  final bool bSelected;
  final bool? bRight;
  final String title;
  final int index;
  final int score;

  @override
  State<AnswerCell> createState() => _AnswerCellState();
}

class _AnswerCellState extends State<AnswerCell> {
  double get width => widget.width;
  bool get bSelected => widget.bSelected;
  bool? get bRight => widget.bRight;
  String get title => widget.title;
  int get score => widget.score;
  int get index => widget.index;
  late final GifController controller = GifController(autoPlay: true, loop: false, reserved: true);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.play();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = width * 0.135;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            MirraIcons.getQuizIconPath("answer_cell.png"),
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          if (bSelected)
            _ExpandingBackground(
              width: width,
              height: height,
              uri: MirraIcons.getQuizIconPath("answer_cell_selected.png"),
            ),
          if (bRight != null)
            _ExpandingBackground(
              width: width,
              height: height,
              uri: MirraIcons.getQuizIconPath(bRight! ? "answer_cell_right.png" : "answer_cell_wrong.png"),
            ),
          Align(
            alignment: const Alignment(-0.85, 0.5),
            child: Text(
              ascii.decode([0x41 + index]),
              style: TriviaTextStyles.title(color: Colors.black, fontSize: width * 0.06),
            ),
          ),
          Align(
            alignment: const Alignment(0.5, 0.0),
            child: SizedBox(
              width: width * 0.7,
              child: AutoSizeText(
                title,
                maxLines: 1,
                style: TriviaTextStyles.title(color: Colors.black, fontSize: width * 0.06),
              ),
            ),
          ),
          if (bRight != null)
            Align(
              alignment: const Alignment(0.8, 0.0),
              child: Image.asset(
                MirraIcons.getQuizIconPath(bRight! ? "check.png" : "wrong.png"),
                width: width * 0.05,
                fit: BoxFit.fitWidth,
              ).animate().scale(delay: 200.ms, duration: 200.ms),
            ),
          if ((bRight ?? false) && bSelected)
            Align(
              alignment: const Alignment(1.0, 0.0),
              child: Transform.translate(
                offset: Offset(150.w, 0),
                child: AutoSizeText(
                  "+$score",
                  style: TriviaTextStyles.title(
                    color: const Color(0xFF3ADD8F),
                    fontSize: 80.sp,
                  ),
                )
                    .animate()
                    .scale(duration: 200.ms, end: const Offset(1.8, 1.8))
                    .fadeOut(delay: 700.ms, duration: 300.ms),
              ),
            ),
        ],
      ),
    );
  }
}

class _ExpandingBackground extends StatefulWidget {
  const _ExpandingBackground({
    required this.uri,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  final String uri;
  @override
  State<_ExpandingBackground> createState() => _ExpandingBackgroundState();
}

class _ExpandingBackgroundState extends State<_ExpandingBackground> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: 200.ms);
    animation = Tween<double>(begin: 0, end: widget.width).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: animation.value,
        child: ClipRect(
          child: Image.asset(
            widget.uri,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
