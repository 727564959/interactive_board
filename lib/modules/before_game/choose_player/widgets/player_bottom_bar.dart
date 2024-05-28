import 'dart:async';
import 'dart:math';
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

class _PlayerBottomBarState extends State<PlayerBottomBar> {
  final logic = Get.find<ChoosePlayerLogic>();

  late final animation = Tween<double>(begin: 0.5.sh, end: 0)
      .animate(CurvedAnimation(parent: logic.animationController, curve: Curves.easeOut));

  int? selectIndex;
  Timer? timer;
  void dismiss() async {
    timer?.cancel();
    logic.dismissBottomBar();
    await logic.animationController.reverse();
    selectIndex = null;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
                    height: 0.5.sh,
                    alignment: Alignment.center,
                    color: const Color(0x665E6F9A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 0.5.sh,
                child: ListView.builder(
                  itemCount: logic.bottomBarPlayers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, idx) {
                    // 选中的item增加下移距离
                    late final double transactionY;
                    if (selectIndex == idx) {
                      transactionY = 100.0 * max(logic.bottomBarPlayers.length, 6);
                    } else {
                      transactionY = 100.0 * idx;
                    }
                    final cardAnimation = Tween<double>(begin: transactionY, end: 0).animate(logic.animationController);
                    final player = logic.bottomBarPlayers[idx];
                    return Transform.translate(
                      offset: Offset(0, cardAnimation.value),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTapUp: (details) {
                            if (timer != null && timer!.isActive) return;
                            timer?.cancel();
                            timer = Timer(400.ms, () async {
                              logic.updatePosition(player.id);
                              await Future.delayed(100.ms);
                              dismiss();
                            });
                            setState(() {
                              selectIndex = idx;
                            });
                          },
                          child: BottomBarItem(
                            player: player,
                            bSelected: selectIndex == idx,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
