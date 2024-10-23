import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/3rd_libs/gif_view-0.4.3/gif_view.dart';
import 'package:interactive_board/modules/quiz/text_style.dart';

import '../../logic.dart';

class CategoryShowView extends StatelessWidget {
  CategoryShowView({super.key});
  final logic = Get.find<QuizLogic>();
  @override
  Widget build(BuildContext context) {
    final delay = Duration(milliseconds: logic.config.categoryTime * 1000 - 400);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "QUESTION ${logic.quizState!.question.round}",
            style: TriviaTextStyles.title(fontSize: 180.sp, color: const Color(0xff13EFEF)),
          ).animate().moveX(delay: delay, duration: 300.ms, end: 1.0.sw),
          _TypeContent(
            width: 550.w,
            type: logic.quizState!.question.category,
          ).animate().moveX(delay: delay, duration: 300.ms, end: -1.0.sw),
        ],
      ),
    );
  }
}

class _TypeContent extends StatefulWidget {
  const _TypeContent({super.key, required this.width, required this.type});
  final double width;
  final String type;
  @override
  State<_TypeContent> createState() => _TypeContentState();
}

class _TypeContentState extends State<_TypeContent> {
  late GifController controller = GifController(autoPlay: true, loop: false, reserved: true);
  double get width => widget.width;
  double get height => widget.width * 0.45;
  @override
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String get type => widget.type;
  String get typeIconUri => MirraIcons.getQuizIconPath('icons/${type.toLowerCase()}.png');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          GifView.asset(
            MirraIcons.getGifPath("type_bg.gif"),
            width: width,
            height: height,
            controller: controller,
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
                child: AutoSizeText(
                  type,
                  maxLines: 1,
                  style: TriviaTextStyles.title(color: const Color(0xff8ee8bd), fontSize: width * 0.1),
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
