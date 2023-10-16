import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';

import '../../../common.dart';

class CoverView extends StatefulWidget {
  const CoverView({Key? key}) : super(key: key);

  @override
  State<CoverView> createState() => _CoverViewState();
}

class _CoverViewState extends State<CoverView> with TickerProviderStateMixin {
  late FlutterGifController titleController;
  late FlutterGifController iconsController;

  @override
  void initState() {
    super.initState();
    titleController = FlutterGifController(vsync: this, duration: 1000.ms, value: 0.0);
    iconsController = FlutterGifController(vsync: this, duration: 1733.ms, value: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      titleController.animateTo(56);
      iconsController.animateTo(56);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80.h),
        GifImage(
          height: 0.8.sw * 0.556,
          width: 0.8.sw,
          controller: titleController,
          image: AssetImage(Global.getQuizIconUrl("cover_title.gif")),
          fit: BoxFit.fitWidth,
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
                  child: GifImage(
                    height: 160.w,
                    controller: iconsController,
                    image: AssetImage(Global.getQuizIconUrl("cover_icons.gif")),
                    fit: BoxFit.fitHeight,
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
