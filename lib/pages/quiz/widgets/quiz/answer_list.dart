import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart' hide AnimationExtension;
import '../../../../common.dart';
import '../../logic.dart';

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
          child: _AnswerCell(
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
    return Container(
      width: width,
      height: width * 0.5,
      // color: Colors.cyan,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}

class _AnswerCell extends StatelessWidget {
  const _AnswerCell({
    Key? key,
    required this.width,
    required this.bSelected,
    this.bRight,
    required this.title,
    required this.index,
  }) : super(key: key);
  final double width;
  final bool bSelected;
  final bool? bRight;
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    final height = width * 0.135;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          _ExpandingBackground(
            width: width,
            height: height,
            uri: Global.getQuizIconUrl("answer_cell.png"),
          ),
          if (bSelected)
            _ExpandingBackground(
              width: width,
              height: height,
              uri: Global.getQuizIconUrl("answer_cell_selected.png"),
            ),
          if (bRight != null)
            _ExpandingBackground(
              width: width,
              height: height,
              uri: Global.getQuizIconUrl(bRight! ? "answer_cell_right.png" : "answer_cell_wrong.png"),
            ),
          Align(
            alignment: const Alignment(-0.85, 0.5),
            child: Text(
              ascii.decode([0x41 + index]),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.08,
                decoration: TextDecoration.none,
                fontFamily: 'Burbank',
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.5, 0.0),
            child: SizedBox(
              width: width * 0.7,
              child: AutoSizeText(
                title,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.08,
                  decoration: TextDecoration.none,
                  fontFamily: 'Burbank',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          if (bRight != null)
            Align(
              alignment: const Alignment(0.8, 0.0),
              child: Image.asset(
                Global.getQuizIconUrl(bRight! ? "check.png" : "wrong.png"),
                width: width * 0.05,
                fit: BoxFit.fitWidth,
              ).animate().scale(delay: 200.ms, duration: 200.ms),
            ),
        ],
      ),
    );
  }
}

class _ExpandingBackground extends StatefulWidget {
  const _ExpandingBackground({
    Key? key,
    required this.uri,
    required this.height,
    required this.width,
  }) : super(key: key);
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
