import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart' hide AnimationExtension;

import '../border_title.dart';
import '../../logic.dart';
import '../../../../common.dart';

class CategoryShowView extends StatelessWidget {
  CategoryShowView({Key? key}) : super(key: key);
  final logic = Get.find<QuizLogic>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BorderTitle(
            fontSize: 180.sp,
            title: "QUESTION ${logic.quizState!.question.round}",
          ),
          _TypeContent(
            width: 550.w,
            type: logic.quizState!.question.type,
          ),
        ],
      ),
    );
  }
}

class _TypeContent extends StatefulWidget {
  const _TypeContent({Key? key, required this.width, required this.type}) : super(key: key);
  final double width;
  final String type;
  @override
  State<_TypeContent> createState() => _TypeContentState();
}

class _TypeContentState extends State<_TypeContent> with TickerProviderStateMixin {
  late FlutterGifController controller;
  double get width => widget.width;
  double get height => widget.width * 0.45;
  @override
  void initState() {
    controller = FlutterGifController(vsync: this, duration: 1733.ms, value: 0.0);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.value = 0;
      controller.animateTo(52);
    });
  }

  String get type => widget.type;
  String get typeIconUri => Global.getQuizIconUrl('icons/${type.toLowerCase()}.png');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          GifImage(
            width: width,
            height: height,
            controller: controller,
            image: AssetImage(Global.getQuizIconUrl("type_bg.gif")),
            fit: BoxFit.fill,
          ),
          Align(
            alignment: const Alignment(-0.87, 0),
            child: Image.asset(
              typeIconUri,
              height: height * 0.5,
              fit: BoxFit.fitHeight,
            ).animate().scale(
                  curve: Curves.elasticOut,
                  delay: 400.ms,
                  duration: 900.ms,
                ),
          ),
          Align(
            alignment: const Alignment(0.9, 0.0),
            child: Transform.rotate(
              angle: -0.05,
              child: SizedBox(
                width: 0.6 * width,
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: width * 0.1,
                    color: const Color(0xFF50E9C4),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Burbank',
                  ),
                ).animate().scale(
                      delay: 700.ms,
                      duration: 300.ms,
                      alignment: Alignment.centerLeft,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
