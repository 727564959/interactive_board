import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../logic.dart';
import 'player_card.dart';

class PlayerBottomBar extends StatelessWidget {
  PlayerBottomBar({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: GestureDetector(
          onTapUp: (detail) {
            logic.dismissBottomBar();
          },
        )),
        Stack(
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
                  final player = logic.unselectedPlayers[idx];
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTapUp: (details) {
                        logic.updatePosition(player.id);
                      },
                      child: PlayerCard(
                        avatarUrl: player.avatarUrl,
                        width: 210,
                        nickname: player.nickname,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
