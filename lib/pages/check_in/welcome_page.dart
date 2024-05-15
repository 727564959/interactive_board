import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:intl/intl.dart';

import '../../../../common.dart';
import '../../mirra_style.dart';
import '../../widgets/check_in_title.dart';
// import '../../widgets/debouncer.dart';
import 'widgets/before_checkIn/check_in_home.dart';

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
              // color: Colors.black,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  // 顶部文本信息
                  CheckInTitlePage(titleText: ""),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.08.sw),
                      child: SizedBox(
                        height: 0.25.sh,
                        child: Image.asset(
                          Global.getGifUrl('Welcome.gif'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.1.sw),
                      child: SizedBox(
                        height: 0.35.sh,
                        child: GetBuilder<CheckInLogic>(
                          builder: (logic) {
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10.0, left: 0.0),
                                  child: SizedBox(
                                    width: 0.8.sw,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Welcome, ',
                                        style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 2),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: logic.singlePlayer.length > 0 ? (logic.singlePlayer['name'] + " !") : "",
                                            style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0, left: 0.0),
                                  child: SizedBox(
                                    width: 0.8.sw,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Your Games will start at ',
                                        style: CustomTextStyles.display(color: Colors.white, fontSize: 48.sp, level: 5),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "${DateFormat('kk:mm').format(logic.startTime.add(8.hours))}",
                                            style: CustomTextStyles.display(color: Color(0xFF00F5FF), fontSize: 48.sp, level: 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.1.sw),
                      child: SizedBox(
                        child: _EnterButton(width: 300.w),
                      ),
                    ),
                  ),
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

  final testTabId = Global.tableId;

  // final debouncer = Debouncer(delay: Duration(seconds: 2));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("当前桌： $testTabId");
        // 判断是否是初始进行checkin，是就跳转到groupsetting，反之跳转到用户信息录入
        Get.to(() => CheckInHomePage(), arguments: Get.arguments);
        // Get.to(() => TermOfUsePage(), arguments: Get.arguments);
        // 使用防抖工具，确保点击事件在2秒内只执行一次
        // debouncer.run(() {
        //   print('Button Clicked!');
        // });
      },
      child: GetBuilder<CheckInLogic>(
        id: "enetrBtn",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff13EFEF),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            margin: EdgeInsets.only(top: 0.0, left: 0.0),
            constraints: BoxConstraints.tightFor(width: width, height: 100.h),
            child: Center(
              child: Text(
                "On board",
                textAlign: TextAlign.center,
                style: CustomTextStyles.button(color: Colors.black, fontSize: 28.sp),
              ),
            ),
          );
        },
      ),
    );
  }
}
