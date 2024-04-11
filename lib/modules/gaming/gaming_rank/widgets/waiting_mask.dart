import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../mirra_style.dart';

class WaitingMask extends StatefulWidget {
  const WaitingMask({Key? key}) : super(key: key);

  @override
  State<WaitingMask> createState() => _WaitingMaskState();
}

class _WaitingMaskState extends State<WaitingMask> with TickerProviderStateMixin {
  late Timer timer;
  int dotCount = 1;
  @override
  void initState() {
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
    // controller.dispose();
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
            Image.asset(
              MirraIcons.getGifPath("vr_preparing.gif"),
              repeat: ImageRepeat.repeat,
              width: 500.w,
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
