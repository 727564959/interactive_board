import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../common.dart';
import 'widgets/add_player/add_player_info.dart';
import 'widgets/before_checkIn/check_in_home.dart';
import 'widgets/before_checkIn/term_of_use.dart';
import 'widgets/update_currentTime.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(
                      width: 1.0.sw,
                      height: 0.1.sh,
                      child: GetBuilder<CheckInLogic>(
                          builder: (logic) {
                            return Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20.0, left: 0.8.sw),
                                  child: SizedBox(
                                    width: 0.08.sw,
                                    child: KmTimer(),
                                    // child: Text(
                                    //   "09:56",
                                    //   style: TextStyle(
                                    //     fontSize: 32.sp,
                                    //     decoration: TextDecoration.none,
                                    //     fontFamily: 'BurbankBold',
                                    //     color: Colors.white,
                                    //     letterSpacing: 3.sp,
                                    //   ),
                                    // ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20.0, left: 0.0),
                                  child: SizedBox(
                                    width: 0.12.sw,
                                    child: Text(
                                      "Table " + Global.tableId.toString(),
                                      style: TextStyle(
                                        fontSize: 32.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'BurbankBold',
                                        color: Colors.deepOrange,
                                        letterSpacing: 3.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      )
                  ),
                  SizedBox(
                    width: 1.0.sw,
                    height: 0.25.sh,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0, right: 0.65.sw),
                      child: Image.asset(
                        Global.getSetAvatarImageUrl('welcome_icon.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.0.sw,
                    height: 0.45.sh,
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 0.0),
                              child: SizedBox(
                                width: 0.8.sw,
                                child: Text(
                                  "Welcome",
                                  style: TextStyle(
                                    fontSize: 150.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.0, left: 0.0),
                              child: SizedBox(
                                width: 0.8.sw,
                                child: Text(
                                  "Sophia Davis !",
                                  // logic.singlePlayer.length > 0 ? logic.singlePlayer['nickname'] : "",
                                  // logic.userList.length > 0 ? logic.userList[0].nickname + " !" : "",
                                  style: TextStyle(
                                    fontSize: 130.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 0.0),
                              child: SizedBox(
                                width: 0.8.sw,
                                child: Text(
                                  "Your Games will start at 18:15",
                                  style: TextStyle(
                                    fontSize: 50.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _EnterButton(width: 300.w),
                ],
              ),
            ),
            GetBuilder<CheckInLogic>(builder: (logic) {
              return Container();
            }),
          ],
        ));
  }
}

// 进入签到页面的按钮
class _EnterButton extends StatelessWidget {
  _EnterButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("enter_btn.png");

  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        // 判断是否是初始进行checkin，是就跳转到groupsetting，反之跳转到用户信息录入
        Get.to(() => CheckInHomePage(), arguments: Get.arguments);
        // Get.to(() => TermOfUsePage(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "enetrBtn",
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(top: 0.0, right: 0.65.sw),
            height: width * 0.35,
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