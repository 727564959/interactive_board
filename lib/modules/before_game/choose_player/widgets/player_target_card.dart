import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/modules/before_game/choose_player/data/player.dart';
import 'package:interactive_board/modules/before_game/choose_player/logic.dart';
import 'package:interactive_board/widgets/player_card.dart';
import '../../../../mirra_style.dart';

class PlayerTargetCard extends StatelessWidget {
  PlayerTargetCard({Key? key, required this.position}) : super(key: key);
  final int position;
  final logic = Get.find<ChoosePlayerLogic>();
  PlayerInfo? get player => logic.optionalPositions[position];
  @override
  Widget build(BuildContext context) {
    late final Widget child;
    if (player == null) {
      child = AvatarCard(
        labelColor: const Color(0xfff0f0f0),
        title: "Player name",
        subTitle: Global.getDeviceName(position),
        width: 270.w,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            MirraIcons.getGameShowIconPath("player_add1.png"),
            width: 50.w,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    } else {
      child = PlayerCard(
        avatarUrl: player!.avatarUrl,
        nickname: player!.nickname ?? "Player name",
        position: position,
        width: 270.w,
      );
    }
    Duration? duration;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GestureDetector(
        onTapUp: (details) {
          logic.showBottomBar(position);
        },
        onPanStart: (detail) {
          duration = detail.sourceTimeStamp;
        },
        onPanUpdate: (detail) {
          if (duration != null && detail.sourceTimeStamp != null) {
            final tapSpace = detail.sourceTimeStamp! - duration!;
            if (tapSpace > 300.ms) return;
          }
          if (detail.delta.dy < -10 && detail.delta.dx.abs() < 5) {
            logic.removePlayer(position);
          }
        },
        child: child,
      ),
    );
  }
}
