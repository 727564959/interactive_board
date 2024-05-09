import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../logic.dart';
import '../../../../widgets/player_card.dart';

class PlayerBottomBar extends StatelessWidget {
  PlayerBottomBar({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();

  late final animation = Tween<double>(begin: 0.4.sh, end: 0)
      .animate(CurvedAnimation(parent: logic.animationController, curve: Curves.easeOut));
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (logic.selectedPosition != null)
          Expanded(
            child: GestureDetector(
              onTapUp: (details) {
                logic.dismissBottomBar();
              },
              onPanStart: (details) {
                logic.dismissBottomBar();
              },
            ),
          ),
        if (logic.selectedPosition == null) Expanded(child: Container()),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 0.44.sh,
                child: ListView.builder(
                  itemCount: logic.unselectedPlayers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, idx) {
                    final cardAnimation =
                        Tween<double>(begin: 0 + idx * 100, end: 0).animate(logic.animationController);
                    final player = logic.unselectedPlayers[idx];
                    return Transform.translate(
                      offset: Offset(0, cardAnimation.value),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTapUp: (details) {
                            logic.updatePosition(player.id);
                          },
                          child: PlayerCard(
                            avatarUrl: player.avatarUrl,
                            width: 270.w,
                            nickname: player.nickname,
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
