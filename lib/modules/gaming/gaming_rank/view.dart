import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../widgets/game_title.dart';
import 'widgets/leaderboard.dart';
import 'widgets/waiting_mask.dart';
import 'widgets/player_display.dart';
import 'logic.dart';

class GamingRankPage extends StatelessWidget {
  GamingRankPage({Key? key}) : super(key: key);
  final logic = Get.find<GamingRankLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: 1.0.sw,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Global.getAssetImageUrl("background.png")),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              GameTitleWidget(gameName: logic.gameName, width: 0.45.sw),
              const SizedBox(height: 50),
              SizedBox(
                width: 0.85.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<GamingRankLogic>(
                      id: "leaderboard",
                      builder: (logic) => Leaderboard(width: 700.w),
                    ),
                    GetBuilder<GamingRankLogic>(
                      id: "player_card",
                      builder: (logic) => PlayerDisplay(key: UniqueKey(), width: 580.w),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GetBuilder<GamingRankLogic>(
            id: "mask",
            builder: (logic) {
              if (logic.bGameStart) {
                return Container();
              } else {
                return const WaitingMask();
              }
            }),
        Positioned(
          left: 20,
          top: 20,
          child: Text(
            "Table ${Global.tableId}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 80.sp,
              decoration: TextDecoration.none,
              fontFamily: 'Burbank',
              color: Colors.white,
            ),
          ),
        ),
      ],
    ));
  }
}
