import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common.dart';
import '../../widgets/game_title.dart';
import 'widgets/leaderboard.dart';
import 'widgets/player_display.dart';
import 'logic.dart';

class GamingRankPage extends StatelessWidget {
  GamingRankPage({Key? key}) : super(key: key);
  final logic = Get.find<GamingRankLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              child: GetBuilder<GamingRankLogic>(
                builder: (logic) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Leaderboard(width: 700.w),
                      PlayerDisplay(width: 580.w),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
