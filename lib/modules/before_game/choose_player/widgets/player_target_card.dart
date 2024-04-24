import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/before_game/choose_player/data/player.dart';
import 'package:interactive_board/modules/before_game/choose_player/logic.dart';
import 'package:interactive_board/widgets/player_card.dart';

class PlayerTargetCard extends StatelessWidget {
  PlayerTargetCard({Key? key, required this.position}) : super(key: key);
  final int position;
  final logic = Get.find<ChoosePlayerLogic>();
  PlayerInfo? get player => logic.optionalPositions[position];
  String get deviceName => getDeviceName(position);
  @override
  Widget build(BuildContext context) {
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
        child: PlayerCard(
          avatarUrl: player?.avatarUrl,
          nickname: player?.nickname ?? "Player name",
          position: position,
          width: 270.w,
        ),
      ),
    );
  }
}
