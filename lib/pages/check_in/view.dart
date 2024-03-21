import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../common.dart';
import '../../data/model/show_state.dart';
import 'welcome_page.dart';
import 'widgets/after_checkIn/player_info_show.dart';

class CheckInPage extends StatelessWidget {
  CheckInPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GetBuilder<CheckInLogic>(builder: (logic) {
          if (Get.arguments.status == ShowStatus.gamePreparing || Get.arguments.status == ShowStatus.gaming) {
            print("添加玩家");
            return PlayerInfoShow();
          } else {
            print("默认初始化");
            return WelcomePage();
          }
        }),
      ],
    ));
  }
}