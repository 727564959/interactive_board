import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:interactive_board/widgets/player_card.dart';

import '../logic.dart';

class PlayerDisplay extends StatelessWidget {
  PlayerDisplay({Key? key}) : super(key: key);
  final logic = Get.find<GamingRankLogic>();

  List<Widget> get playerCards => logic.showPlayers
      .map(
        (e) => Padding(
          padding: EdgeInsets.symmetric(horizontal: logic.details.mode == 'normal' ? 20.w : 5.w),
          child: PlayerCard(
            avatarUrl: e.avatarUrl,
            nickname: e.nickname,
            position: e.position,
            width: logic.details.mode != 'free-4' ? 400.w : 250.w,
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GamingRankLogic>(
      builder: (logic) {
        if (logic.details.mode == 'normal') {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (playerCards.isNotEmpty) playerCards[0],
              if (playerCards.length > 1)
                Transform.translate(
                  offset: Offset(0, 80.w),
                  child: playerCards[1],
                )
            ],
          );
        } else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: playerCards,
          );
        }
      },
    );
  }
}
