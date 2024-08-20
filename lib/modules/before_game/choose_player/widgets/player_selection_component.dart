import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/before_game/choose_player/widgets/free_mode_target_card.dart';
import '../logic.dart';
import 'player_target_card.dart';

class EventModeContent extends StatelessWidget {
  EventModeContent({super.key});
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    final position = logic.optionalPositions.keys.first;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerTargetCard(position: position),
        SizedBox(width: 30.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              logic.game,
              style: CustomTextStyles.display1(
                color: Colors.white,
                fontSize: 90.sp,
              ),
            ),
            SizedBox(height: 20.w),
            Text(
              "   1 Player in This Round",
              style: CustomTextStyles.display2(
                color: Colors.white,
                fontSize: 60.sp,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class NormalModeContent extends StatelessWidget {
  NormalModeContent({super.key});
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    final position1 = logic.optionalPositions.keys.first;
    final position2 = logic.optionalPositions.keys.last;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerTargetCard(position: position1),
        SizedBox(width: 30.w),
        PlayerTargetCard(position: position2, delay: 400.ms),
      ],
    );
  }
}

class FreeModeContent extends StatelessWidget {
  FreeModeContent({super.key});
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3, 4]
              .map((e) => FreeModeTargetCard(
                    position: e,
                    bShowError: logic.bShowPlayerSelectException && e == logic.selectedPosition,
                  ))
              .toList(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [5, 6, 7, 8]
              .map((e) => FreeModeTargetCard(
                    position: e,
                    bShowError: logic.bShowPlayerSelectException && e == logic.selectedPosition,
                  ))
              .toList(),
        )
      ],
    );
  }
}
