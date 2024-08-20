import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../mirra_style.dart';

import '../../../widgets/mirra_app_bar.dart';
import '../choose_player/logic.dart';
import 'mask_player_card.dart';

class ConfirmSelectionPage extends StatefulWidget {
  const ConfirmSelectionPage({super.key});

  @override
  State<ConfirmSelectionPage> createState() => _ConfirmSelectionPageState();
}

class _ConfirmSelectionPageState extends State<ConfirmSelectionPage> {
  final logic = Get.find<ChoosePlayerLogic>();
  bool bFinish = false;
  @override
  Widget build(BuildContext context) {
    final playerCards = <Widget>[];
    for (final position in logic.optionalPositions.keys) {
      final player = logic.optionalPositions[position];
      if (player == null || player.tableId != Global.tableId) continue;
      playerCards.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: MaskPlayerCard(
            avatarUrl: player.avatarUrl,
            nickname: player.nickname,
            position: position,
            width: 270.w,
            bFinish: bFinish,
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MirraIcons.getGameShowIconPath("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MirraAppBar(title: logic.game),
            Container(
              height: 300.w,
              alignment: Alignment.center,
              child: _CountDownTitle(
                bFinish: bFinish,
                onFinished: () {
                  setState(() {
                    bFinish = true;
                  });
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: playerCards,
              ),
            ),
            SizedBox(height: 150.w),
            if (!bFinish)
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    const BorderSide(
                      color: Color(0xff13efef),
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 200.w),
                  child: Text(
                    "BACK",
                    style: CustomTextStyles.button(
                      color: const Color(0xff13efef),
                      fontSize: 25.sp,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CountDownTitle extends StatelessWidget {
  const _CountDownTitle({required this.bFinish, required this.onFinished});
  final bool bFinish;
  final Function onFinished;
  @override
  Widget build(BuildContext context) {
    if (!bFinish) {
      return Countdown(
        seconds: 8,
        onFinished: onFinished,
        build: (BuildContext context, double time) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ready To Go",
                style: CustomTextStyles.title1(
                  color: Colors.white,
                  fontSize: 65.sp,
                ),
              ),
              Text(
                " (${time.toInt() + 1}s)",
                style: CustomTextStyles.title1(
                  color: const Color(0xffef7e00),
                  fontSize: 65.sp,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MirraIcons.getGifPath('vr_preparing.gif'),
            width: 150.w,
            fit: BoxFit.fitWidth,
          ),
          Text(
            "Headset Preparing",
            style: CustomTextStyles.title1(
              color: Colors.white,
              fontSize: 65.sp,
            ),
          ),
          SizedBox(width: 60.w),
        ],
      );
    }
  }
}
