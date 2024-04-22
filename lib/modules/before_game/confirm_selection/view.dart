import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../common.dart';
import '../../../mirra_style.dart';

import '../../../widgets/mirra_app_bar.dart';
import '../choose_player/logic.dart';

class ConfirmSelectionPage extends StatelessWidget {
  ConfirmSelectionPage({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    final confirmedPositions =
        logic.optionalPositions.keys.where((key) => logic.optionalPositions[key]?.tableId == Global.tableId);
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MirraIcons.getChooseTableIconPath("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MirraAppBar(title: "Choose Player"),
            _CountDownTitle(),
          ],
        ),
      ),
    );
  }
}

class _CountDownTitle extends StatefulWidget {
  const _CountDownTitle({Key? key}) : super(key: key);

  @override
  State<_CountDownTitle> createState() => _CountDownTitleState();
}

class _CountDownTitleState extends State<_CountDownTitle> {
  bool bFinish = false;
  @override
  Widget build(BuildContext context) {
    if (!bFinish) {
      return Countdown(
        seconds: 10,
        build: (BuildContext context, double time) {
          return Row(
            children: [
              Text(
                "Ready To Go",
                style: CustomTextStyles.title1(
                  color: Colors.white,
                  fontSize: 40.sp,
                ),
              ),
              Text(
                "(${time.toInt()})",
                style: CustomTextStyles.title1(
                  color: Colors.white,
                  fontSize: 40.sp,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Row(
        children: [
          Text(
            "Headset Preparing",
            style: CustomTextStyles.title1(
              color: Colors.white,
              fontSize: 40.sp,
            ),
          ),
        ],
      );
    }
  }
}
