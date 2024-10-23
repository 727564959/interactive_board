import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:interactive_board/3rd_libs/gif_view-0.4.3/gif_view.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/quiz/widgets/waiting_start/countdown_view.dart';

import '../../../../mirra_style.dart';
import '../../logic.dart';

class CoverView extends StatefulWidget {
  const CoverView({super.key});

  @override
  State<CoverView> createState() => _CoverViewState();
}

class _CoverViewState extends State<CoverView> {
  late final GifController titleController;
  late final GifController iconsController;
  final logic = Get.find<QuizLogic>();
  bool bCountdownView = false;
  @override
  void initState() {
    super.initState();
    final waitTime = max(0, (logic.quizRoundStartTimestamp - DateTime.now().millisecondsSinceEpoch - 5000));
    print(waitTime);
    titleController = GifController(autoPlay: true, loop: false, reserved: true);
    iconsController = GifController(autoPlay: true, loop: false, reserved: true);
    logic.soundEffect.coverLogoPlay();
    Future.delayed(Duration(milliseconds: waitTime)).then((value) {
      logic.soundEffect.joinPagePlay();
      setState(() {
        bCountdownView = true;
      });
    }).onError((error, stackTrace) async {
      print(error);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    iconsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bCountdownView
        ? CountdownView()
        : Column(
            children: [
              SizedBox(height: 80.h),
              GifView.asset(
                MirraIcons.getGifPath("cover_title.gif"),
                height: 0.8.sw * 0.556,
                width: 0.8.sw,
                controller: titleController,
                fit: BoxFit.fitWidth,
                withOpacityAnimation: false,
              ),
              Transform.translate(
                offset: Offset(0, -100.w),
                child: SizedBox(
                  width: 1.sw,
                  height: 160.w,
                  child: Stack(
                    children: [
                      Container(color: const Color(0xFF171616)).animate().scaleX(duration: 300.ms),
                      Center(
                        child: GifView.asset(
                          MirraIcons.getGifPath("cover_icons.gif"),
                          height: 160.w,
                          controller: iconsController,
                          fit: BoxFit.fitHeight,
                          withOpacityAnimation: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
