import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import '../../../../widgets/player_card.dart';
import '../data/player.dart';
import '../logic.dart';

class BottomBarItem extends StatefulWidget {
  const BottomBarItem({Key? key, required this.player, this.bSelected = false}) : super(key: key);
  final PlayerInfo player;
  final bool bSelected;
  @override
  State<BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomBarItem> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(vsync: this, duration: 300.ms);
  late final animation = ColorTween(begin: baseColor, end: selectedColor).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  ));
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
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.bSelected ? controller.forward() : controller.reverse();
    return PlayerCard(
      avatarUrl: player.avatarUrl,
      width: 270.w,
      nickname: player.nickname,
      labelColor: animation.value,
    );
  }
}
