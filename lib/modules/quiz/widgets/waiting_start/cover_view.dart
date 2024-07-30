import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:interactive_board/3rd_libs/gif_view-0.4.3/gif_view.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../../logic.dart';
import 'tips_view.dart';

class CoverView extends StatefulWidget {
  const CoverView({super.key});

  @override
  State<CoverView> createState() => _CoverViewState();
}

class _CoverViewState extends State<CoverView> {
  late final GifController titleController;
  late final GifController iconsController;
  final logic = Get.find<QuizLogic>();
  bool bTipsView = false;
  @override
  void initState() {
    super.initState();
    titleController = GifController(autoPlay: true, loop: false, reserved: true);
    iconsController = GifController(autoPlay: true, loop: false, reserved: true);
    // Future.delayed(1.seconds).then((value) => titleController.play());
    // Future.delayed(1733.ms).then((value) => iconsController.play());
    logic.soundEffect.coverLogoPlay();
    Future.delayed(10.seconds).then((value) {
      logic.soundEffect.joinPagePlay();
      setState(() {
        bTipsView = true;
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
    return bTipsView
        ? const TipsView()
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
