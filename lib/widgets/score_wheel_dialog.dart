import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:interactive_board/mirra_style.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:interactive_board/3rd_libs/gif_view-0.4.3/gif_view.dart';

import '../common.dart';

class ScoreWheelDialog extends StatefulWidget {
  const ScoreWheelDialog({super.key});

  @override
  State<ScoreWheelDialog> createState() => _ScoreWheelDialogState();
}

class _ScoreWheelDialogState extends State<ScoreWheelDialog> {
  int? score;
  final Socket socket = io(
    baseBonusUrl,
    OptionBuilder().setTransports(['websocket']).enableReconnection().disableAutoConnect().build(),
  );
  @override
  void initState() {
    socket.on('turn_wheel', (data) async {
      if (data["teamId"] != Global.tableId) return;
      await Future.delayed(9.seconds);
      setState(() {
        score = data["score"];
      });
      await Future.delayed(10.seconds);
      Get.close();
    });
    socket.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: score == null
          ? _ButtonView()
          : _ScoreView(
              score: score!,
            ),
    );
  }
}

class _ButtonView extends StatelessWidget {
  _ButtonView();
  final bCountdown = true.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PushableButton(
            height: 200.w,
            elevation: 30.w,
            hslColor: const HSLColor.fromAHSL(1.0, 120, 1.0, 0.37),
            onPressed: () async {
              Get.back();
              await Dio().post("$baseBonusUrl/turn");
              bCountdown.value = false;
            },
            child: Text(
              'SPIN',
              style: CustomTextStyles.button(
                color: Colors.white,
                fontSize: 100.sp,
              ),
            ),
          ),
          Obx(
            () => bCountdown.value
                ? Countdown(
                    seconds: 9,
                    onFinished: () => bCountdown.value = false,
                    build: (BuildContext context, double time) => SizedBox(
                      height: 250.w,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          (time.toInt() + 1).toString().padLeft(2, '0'),
                          style: CustomTextStyles.title3(
                            color: Colors.white,
                            fontSize: 120.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(height: 250.w),
          ),
        ],
      ),
    );
  }
}

class _ScoreView extends StatelessWidget {
  const _ScoreView({required this.score});
  final int score;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GifView.asset(
          MirraIcons.getGifPath("show_end_fireworks.gif"),
          fit: BoxFit.fill,
        ),
        Center(
          child: Text(
            "+ $score",
            style: CustomTextStyles.title3(color: Colors.white, fontSize: 300.sp),
          ),
        ),
      ],
    );
  }
}
