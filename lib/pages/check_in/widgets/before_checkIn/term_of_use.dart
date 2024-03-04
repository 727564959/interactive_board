import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../common.dart';
import '../add_player/add_player_info.dart';
import 'group_setting.dart';

class TermOfUsePage extends StatelessWidget {
  TermOfUsePage({Key? key}) : super(key: key);
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
                    height: 0.2.sh,
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 120.0),
                              child: SizedBox(
                                width: 0.24.sw,
                                child: Text(
                                  "Term of Use",
                                  style: TextStyle(
                                    fontSize: 60.sp,
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
                  SizedBox(
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 0.0, left: 120.0),
                              constraints: BoxConstraints.tightFor(width: 0.8.sw, height: 0.6.sh),//卡片大小
                              child: ListView(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(20.0),
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: Text('Welcome to Mirra game show, an exciting and immersive gaming experience, By accessing or using our game, you agree to abide by the following terms and conditions.',
                                      style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.deepOrange, letterSpacing: 3.sp,),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                      child: Text('1. Acceptance of Terms',
                                        style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                      ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                      child: Text('By accessing or using [Game Name], you acknowledge that you have read, understood, and agree to be bound by these terms of use. If you do not agree with any part of these terms, please do not use our game.',
                                        style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white38, letterSpacing: 3.sp,),
                                      ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                      child: Text('2. User Conduct',
                                        style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                      ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                      child: Text('You agree to use [Game Name] for lawful purposes and in a manner consistent with all applicable laws and regulations. You will not engage in any conduct that may disrupt the experience of other users or compromise the security and integrity of the game...',
                                        style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white38, letterSpacing: 3.sp,),
                                      ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                      child: Text('3. Intellectual Property...',
                                        style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                                      ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                      child: Text('You agree to use [Game Name] for lawful purposes and in a manner consistent with all applicable laws and regulations. You will not engage in any conduct that may disrupt the experience of other users or compromise the security and integrity of the game',
                                        style: TextStyle(fontSize: 35.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white38, letterSpacing: 3.sp,),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _AgreeButton(width: 800.w),
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
// 同意条款的按钮
class _AgreeButton extends StatelessWidget {
  _AgreeButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("agree_btn.png");

  final testTabId = Global.tableId;
  // final testTabId = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("接受了协议");
        print("54321 $testTabId");
        // 判断是否是初始进行checkin，是就跳转到groupsetting，反之跳转到用户信息录入
        // logic.isFirstCheckIn ? Get.to(() => GroupSettingPage(), arguments: Get.arguments) : Get.to(() => AddPlayerInfo(), arguments: Get.arguments);
        Get.to(() => AddPlayerInfo(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "agreeBtn",
        builder: (logic) {
          return Container(
            height: width * 0.3,
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