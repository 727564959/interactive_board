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
                            child: logic.bAlreadyJoinedPlayer
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
          ],
        ),
      ),
    );
  }
}
