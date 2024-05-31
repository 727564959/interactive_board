import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/before_game/choose_player/widgets/bottom_bar_item.dart';

import '../logic.dart';

class PlayerBottomBar extends StatefulWidget {
  const PlayerBottomBar({Key? key}) : super(key: key);

  @override
  State<PlayerBottomBar> createState() => _PlayerBottomBarState();
}

class _PlayerBottomBarState extends State<PlayerBottomBar> with TickerProviderStateMixin {
  final logic = Get.find<ChoosePlayerLogic>();
  late final animation = Tween<double>(begin: 0.5.sh, end: 0)
      .animate(CurvedAnimation(parent: logic.animationController, curve: Curves.easeOut));
  late final delayAnimation = Tween<double>(begin: 100, end: 0).animate(logic.delayController);
  int? selectIndex;

  void dismiss() async {
    logic.dismissBottomBar();
    await logic.animationController.reverse();
    selectIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!logic.animationController.isDismissed)
          Expanded(
            child: GestureDetector(
              onTapUp: (_) => dismiss(),
              onPanStart: (_) => dismiss(),
            ),
          ),
        if (logic.animationController.isDismissed) Expanded(child: Container()),
        Transform.translate(
          offset: Offset(0, animation.value),
          child: Stack(
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.4.sh,
                    alignment: Alignment.center,
                    color: const Color(0x665E6F9A),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, delayAnimation.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 0.4.sh,
                  child: ListView.builder(
                    itemCount: logic.bottomBarPlayers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) {
                      final tapController = AnimationController(value: 1.0, vsync: this, duration: 150.ms);

                      final player = logic.bottomBarPlayers[idx];
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTapUp: (details) async {
                            if (selectIndex != null) return;
                            selectIndex = idx;
                            await tapController.reverse();
                            await tapController.forward();
                            logic.updatePosition(player.id);
                            dismiss();
                          },
                          child: BottomBarItem(
                            player: player,
                            controller: tapController,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
