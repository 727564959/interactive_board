import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common.dart';

class WaitingMask extends StatefulWidget {
  const WaitingMask({Key? key}) : super(key: key);

  @override
  State<WaitingMask> createState() => _WaitingMaskState();
}

class _WaitingMaskState extends State<WaitingMask> with TickerProviderStateMixin {
  late FlutterGifController controller;
  late Timer timer;
  int dotCount = 1;
  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.repeat(min: 0, max: 69, period: 2.seconds);
    });
    timer = Timer.periodic(700.ms, (timer) {
      setState(() {
        dotCount = dotCount % 3 + 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xb4000000),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GifImage(
              width: 500.w,
              controller: controller,
              image: AssetImage(Global.getGifUrl("vr_preparing.gif")),
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              width: 490.w,
              child: Text(
                "Headset Preparing ${"." * dotCount}",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 60.sp,
                  decoration: TextDecoration.none,
                  fontFamily: 'BurbankBlack',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
