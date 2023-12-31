import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../common.dart';
import '../../widgets/game_title.dart';

import 'logic.dart';
import 'widgets/player_sticker.dart';
import 'widgets/player_selection_menu.dart';

class ChoosePlayerPage extends StatelessWidget {
  ChoosePlayerPage({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    GifCache();
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
              GameTitleWidget(gameName: logic.gameName, width: 0.45.sw, bAnimate: true),
              SizedBox(
                height: 130.h,
                child: GetBuilder<ChoosePlayerLogic>(
                  id: "countdown",
                  builder: (logic) {
                    if (logic.bSelectComplete) {
                      return Center(
                        child: Countdown(
                          key: UniqueKey(),
                          seconds: 9,
                          onFinished: () {
                            Get.toNamed(AppRoutes.gamingRank);
                          },
                          build: (context, time) {
                            return Text(
                              "Confirm Select At ${time.toInt() + 1} seconds",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 60.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              PlayerSelectionMenu(width: 0.7.sw),
              SizedBox(height: 30.h),
              GetBuilder<ChoosePlayerLogic>(
                builder: (logic) {
                  return PlayerSticker(width: 0.9.sw, players: logic.unselectedPlayers);
                },
              ),
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
          // child: IconButton(
          //   iconSize: 100,
          //   icon: const Icon(Icons.accessibility_outlined),
          //   onPressed: () {
          //     Get.toNamed(AppRoutes.checkIn);
          //   },
          // )
        ),
      ],
    ));
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
        print("进入checkin");
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
