import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:interactive_board/mirra_style.dart';
import '../logic.dart';
import 'player_target_card.dart';

class EventModeContent extends StatelessWidget {
  EventModeContent({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    final position = logic.optionalPositions.keys.first;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerTargetCard(position: position),
        const SizedBox(width: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1 Player",
              style: CustomTextStyles.display1(
                color: Colors.white,
                fontSize: 70,
              ),
            ),
            Text(
              "   in This Round",
              style: CustomTextStyles.display2(
                color: Colors.white,
                fontSize: 50,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class NormalModeContent extends StatelessWidget {
  NormalModeContent({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    final position1 = logic.optionalPositions.keys.first;
    final position2 = logic.optionalPositions.keys.last;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, -30),
          child: PlayerTargetCard(position: position1),
        ),
        const SizedBox(width: 20),
        PlayerTargetCard(position: position2),
        const SizedBox(width: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2 Player",
              style: CustomTextStyles.display1(
                color: Colors.white,
                fontSize: 70,
              ),
            ),
            Text(
              "   in This Round",
              style: CustomTextStyles.display2(
                color: Colors.white,
                fontSize: 50,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class Free4ModeContent extends StatelessWidget {
  Free4ModeContent({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "4 players in This Round",
          style: CustomTextStyles.title1(color: Colors.white, fontSize: 50),
        ),
        SizedBox(height: 40.w),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: logic.optionalPositions.keys.map((e) => PlayerTargetCard(position: e)).toList(),
        )
      ],
    );
  }
}
