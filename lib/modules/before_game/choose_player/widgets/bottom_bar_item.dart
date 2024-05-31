import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import '../../../../widgets/player_card.dart';
import '../data/player.dart';
import '../logic.dart';

class BottomBarItem extends StatefulWidget {
  const BottomBarItem({Key? key, required this.player, required this.controller}) : super(key: key);
  final PlayerInfo player;

  final AnimationController controller;
  @override
  State<BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomBarItem> {
  PlayerInfo get player => widget.player;
  final logic = Get.find<ChoosePlayerLogic>();
  Color get baseColor => const Color(0xfff0f0f0);
  Color get selectedColor {
    if (Global.tableId == 1) {
      return const Color(0xffFFBD80);
    } else if (Global.tableId == 2) {
      return const Color(0xffEFB5FD);
    } else if (Global.tableId == 3) {
      return const Color(0xff9ED7F7);
    } else {
      return const Color(0xff8EE8BD);
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerCard(
      avatarUrl: player.avatarUrl,
      width: 270.w,
      nickname: player.nickname,
    ).animate(autoPlay: false, controller: widget.controller).scaleXY(duration: 150.ms, begin: 0.9, end: 1.0);
  }
}
