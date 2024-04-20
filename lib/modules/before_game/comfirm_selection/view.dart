import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../app_routes.dart';
import '../../../common.dart';
import '../../../widgets/hexagon_avatar.dart';
import '../choose_player/logic.dart';

class ConfirmSelectionPage extends StatelessWidget {
  ConfirmSelectionPage({Key? key}) : super(key: key);
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    final confirmedPositions =
        logic.optionalPositions.keys.where((key) => logic.optionalPositions[key]?.tableId == Global.tableId);
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
                SizedBox(height: 300.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: confirmedPositions.map((position) {
                    final player = logic.optionalPositions[position];
                    final width = 250.w;
                    final height = width * 1.5;
                    final deviceId = ascii.decode([0x40 + position]);
                    return SizedBox(
                      width: width,
                      height: height,
                      child: Stack(
                        children: [
                          HexagonAvatar(
                            width: width,
                            avatarUrl: player!.avatarUrl,
                            tag: player.nickname,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: width * 0.43,
                              height: height * 0.17,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Global.getAssetImageUrl("avatar/vr_icon_light.png")),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    deviceId,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: width * 0.11,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'BurbankBold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Countdown(
                  seconds: 10,
                  build: (context, time) => TextButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.gamingRank, arguments: Get.arguments);
                      },
                      child: Text(
                        "Confirm (${time.toInt()})",
                        style: const TextStyle(fontSize: 30, color: Colors.white),
                      )),
                  onFinished: () {
                    Get.offAllNamed(AppRoutes.gamingRank, arguments: Get.arguments);
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
            left: 20,
            top: 100,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
