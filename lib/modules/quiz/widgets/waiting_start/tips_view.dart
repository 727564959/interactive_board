import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/quiz/text_style.dart';
import '../../logic.dart';
import '../border_title.dart';
import 'joined_button.dart';
import 'package:interactive_board/3rd_libs/gif_view-0.4.3/gif_view.dart';

class TipsView extends StatefulWidget {
  const TipsView({super.key});

  @override
  State<TipsView> createState() => _TipsViewState();
}

class _TipsViewState extends State<TipsView> {
  late final GifController controller = GifController(
    autoPlay: true,
    loop: false,
    reserved: true,
  );
  final logic = Get.find<QuizLogic>();
  @override
  void initState() {
    // Future.delayed(1.seconds).then((value) => controller.play());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      logic.join();
      // controller.play();
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
    return Column(
      children: [
        SizedBox(height: 50.w),
        Text(
          "Get Ready for Trivia Time!",
          style: TriviaTextStyles.title(
            color: const Color(0xff13EFEF),
            fontSize: 130.sp,
          ),
        ),
        SizedBox(height: 0.15.sh),
        SizedBox(
          width: 1.0.sw,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GifView.asset(
                MirraIcons.getGifPath("tips_expand.gif"),
                fit: BoxFit.fill,
                height: 0.4.sh,
                controller: controller,
                withOpacityAnimation: false,
                // fadeDuration: 1.days,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                // color: Colors.cyan,
                height: 0.28.sh,
                width: 0.7.sw,
                child: Text(
                  "Join the Trivia Challenge for knowledge and fun. Answer 10 fun questions in just 15 seconds each,"
                  " with only one right answer. Accumulate ten points for each correct answer and aim for the top score!",
                  style: TriviaTextStyles.content(color: const Color(0xffFCFF77), fontSize: 40.sp),
                ).animate().fade(delay: 500.ms),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.1.sh),
        JoinedButton(width: 250.w),
      ],
    );
  }
}
