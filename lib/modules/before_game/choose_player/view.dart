import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/before_game/choose_player/widgets/player_selection_component.dart';
import 'package:interactive_board/widgets/mirra_app_bar.dart';

import 'widgets/player_bottom_bar.dart';
import 'logic.dart';

class ChoosePlayerPage extends StatelessWidget {
  ChoosePlayerPage({Key? key}) : super(key: key);
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
                      return Padding(
                        padding: EdgeInsets.only(top: 150.w),
                        child: FreeModeContent(),
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
