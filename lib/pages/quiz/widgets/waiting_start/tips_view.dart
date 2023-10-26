import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common.dart';
import '../border_title.dart';
import 'joined_button.dart';

class TipsView extends StatefulWidget {
  const TipsView({Key? key}) : super(key: key);

  @override
  State<TipsView> createState() => _TipsViewState();
}

class _TipsViewState extends State<TipsView> with TickerProviderStateMixin {
  late final FlutterGifController controller;
  @override
  void initState() {
    controller = FlutterGifController(vsync: this, duration: 1000.ms, value: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animateTo(36);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.15.sh),
        BorderTitle(
          title: "Get Ready for Trivia Time!",
          fontSize: 130.sp,
        ),
        SizedBox(height: 0.1.sh),
        SizedBox(
          width: 1.0.sw,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GifImage(
                image: AssetImage(Global.getQuizIconUrl("tips_expand.gif")),
                fit: BoxFit.fill,
                height: 0.4.sh,
                controller: controller,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                // color: Colors.cyan,
                height: 0.28.sh,
                width: 0.6.sw,
                child: AutoSizeText(
                  "Join the Trivia Challenge for knowledge and fun. Answer 10 fun questions in just 15 seconds each, with "
                  "only one right answer.\n\n Accumulate ten points for each correct answer and aim for the top score!",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 70.sp,
                    decoration: TextDecoration.none,
                    fontFamily: 'BurbankBold',
                    color: Colors.white,
                  ),
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
