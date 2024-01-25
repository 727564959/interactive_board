import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:interactive_board/modules/before_game/comfirm_selection/view.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../common.dart';
import '../../../widgets/game_title.dart';

import 'logic.dart';
import 'widgets/player_sticker.dart';
import 'widgets/player_selection_menu.dart';

class ChoosePlayerPage extends StatelessWidget {
  ChoosePlayerPage({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
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
                SizedBox(height: 60.h),
                GameTitleWidget(gameName: logic.showState.game, width: 0.3.sw, bAnimate: true),
                SizedBox(height: 50.h),
                SizedBox(
                  height: 0.6.sw * 0.16 * 1.5 * 2 + 20.w,
                  child: PlayerSelectionMenu(width: 0.6.sw),
                ),
                SizedBox(height: 20.h),
                GetBuilder<ChoosePlayerLogic>(
                  builder: (logic) {
                    return PlayerSticker(width: 0.8.sw, players: logic.unselectedPlayers);
                  },
                ),
                GetBuilder<ChoosePlayerLogic>(
                  builder: (logic) {
                    if (logic.bSelectComplete) {
                      return Countdown(
                        interval: 100.ms,
                        seconds: 1,
                        build: (context, time) => Container(),
                        onFinished: () {
                          Get.to(() => ConfirmSelectionPage(), arguments: Get.arguments);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
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
          Positioned(
            right: 20,
            top: 20,
            child: _SetAvatarButton(
              width: 230.w,
            ),
          ),
        ],
      ),
    );
  }
}

class _SetAvatarButton extends StatelessWidget {
  _SetAvatarButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<ChoosePlayerLogic>();
  String get backgroundUri => Global.team == 0
      ? Global.getCheckInImageUrl("set_avatar_btn_red.png")
      : Global.getCheckInImageUrl("set_avatar_btn_blue.png");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        await Get.toNamed(AppRoutes.checkIn);
        logic.updatePlayerInfo();
      },
      child: GetBuilder<ChoosePlayerLogic>(
        id: "setAvatar",
        builder: (logic) {
          return Container(
            height: width / 3,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}
