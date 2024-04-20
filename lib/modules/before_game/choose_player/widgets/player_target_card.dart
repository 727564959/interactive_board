import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/before_game/choose_player/data/player.dart';
import 'package:interactive_board/modules/before_game/choose_player/logic.dart';
import 'package:interactive_board/modules/before_game/choose_player/widgets/player_card.dart';

String getDeviceName(int position) {
  final char = ascii.decode([0x40 + (position + 1) ~/ 2]);
  return "Device $char${(position + 1) % 2 + 1}";
}

class PlayerTargetCard extends StatelessWidget {
  PlayerTargetCard({Key? key, required this.position}) : super(key: key);
  final int position;
  final logic = Get.find<ChoosePlayerLogic>();
  PlayerInfo? get player => logic.optionalPositions[position];
  String get deviceName => getDeviceName(position);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GestureDetector(
        onTapUp: (details) {
          logic.showBottomBar(position);
        },
        child: PlayerCard(
          avatarUrl: player?.avatarUrl,
          nickname: player?.nickname ?? "Player name",
          device: deviceName,
          width: 210,
        ),
      ),
    );
  }
}
