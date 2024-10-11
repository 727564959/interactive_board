import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/before_game/choose_player/widgets/player_selection_component.dart';
import 'package:interactive_board/widgets/mirra_app_bar.dart';

import 'widgets/player_bottom_bar.dart';
import 'logic.dart';

class ChoosePlayerPage extends StatelessWidget {
  ChoosePlayerPage({super.key});
  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MirraIcons.getGameShowIconPath("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                MirraAppBar(title: "Choose Player", middleString: logic.game),
                GetBuilder<ChoosePlayerLogic>(
                  builder: (logic) {
                    if (logic.mode == "normal") {
                      return Padding(
                        padding: EdgeInsets.only(top: 200.w),
                        child: NormalModeContent(),
                      );
                    } else if (logic.mode == "event") {
                      return Padding(
                        padding: EdgeInsets.only(top: 200.w),
                        child: EventModeContent(),
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            height: 150.w,
                            alignment: Alignment.center,
                            child: logic.bAlreadyJoined
                                ? Text(
                                    "Please go to the arena after selecting your players",
                                    style: CustomTextStyles.notice(color: Colors.white, fontSize: 37.sp),
                                  ).animate(onPlay: (controller) => controller.repeat(reverse: false)).shimmer(
                                      duration: 1400.ms,
                                      color: const Color(0xFF80DDFF),
                                    )
                                : Container(),
                          ),
                          FreeModeContent(),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
            GetBuilder<ChoosePlayerLogic>(
              builder: (logic) => PlayerBottomBar(),
            ),
            Positioned(
              top: 120, // 距离顶部的距离
              left: ((1.0.sw - 830.w) / 2), // 距离左侧的距离
              right: ((1.0.sw - 830.w) / 2), // 可选，确保有左右间距
              child: Container(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center, // 水平居中
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (logic.game == "Hyper Rhythm" || logic.game == "Hyper Rhythm Vol2" || logic.game == "Treasure Dash" || logic.game == "Hockey Smash" || logic.game == "Laser Room")
                      SizedBox(
                        width: 400.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end, // 将内容靠右对齐
                          children: [
                            Image.asset(
                              MirraIcons.getSetAvatarIconPath('active.png'),
                              width: 60, // 设置宽度
                              height: 60, // 设置高度
                              fit: BoxFit.cover, // 根据需要选择其他 fit 值
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "ACTIVE",
                              style: TextStyle(
                                fontFamily: 'Anton',
                                fontSize: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (logic.game == "Hyper Rhythm" || logic.game == "Hyper Rhythm Vol2" || logic.game == "Treasure Dash" || logic.game == "Hockey Smash" || logic.game == "Laser Room")
                      SizedBox(width: 30.w), // 添加间隔
                    if (logic.game == "Jackpot in pairs" || logic.game == "Hockey Smash" || logic.game == "Bubble boom" || logic.game == "Laser Room")
                      SizedBox(
                        width: 400.w,
                        child: Row(
                          mainAxisAlignment: (logic.game == "Jackpot in pairs" || logic.game == "Bubble boom") ? MainAxisAlignment.end : MainAxisAlignment.start, // 将内容靠右对齐
                          children: [
                            Image.asset(
                              MirraIcons.getSetAvatarIconPath('teamwork.png'),
                              width: 60, // 设置宽度
                              height: 60, // 设置高度
                              fit: BoxFit.cover, // 根据需要选择其他 fit 值
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "TEAMWORK",
                              style: TextStyle(
                                fontFamily: 'Anton',
                                fontSize: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (logic.game == "Jackpot in pairs" || logic.game == "Hockey Smash" || logic.game == "Bubble boom" || logic.game == "Laser Room")
                      SizedBox(width: 30.w), // 添加间隔
                    if (logic.game == "Hyper Rhythm" || logic.game == "Hyper Rhythm Vol2" || logic.game == "Treasure Dash" || logic.game == "Jackpot in pairs" || logic.game == "Bubble boom")
                      SizedBox(
                        width: 400.w,
                        child: Row(
                          children: [
                            Image.asset(
                              MirraIcons.getSetAvatarIconPath('strategy.png'),
                              width: 60, // 设置宽度
                              height: 60, // 设置高度
                              fit: BoxFit.cover, // 根据需要选择其他 fit 值
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "STRATEGY",
                              style: TextStyle(
                                fontFamily: 'Anton',
                                fontSize: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
