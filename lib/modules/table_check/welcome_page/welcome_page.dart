import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common.dart';
import '../../../mirra_style.dart';
import '../../../widgets/check_in_title.dart';
import '../check_flow/confirmation_info.dart';
import 'logic.dart';

class WelcomePlayerPage extends StatelessWidget {
  WelcomePlayerPage({Key? key}) : super(key: key);
  final logic = Get.put(TableLogicLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
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
                        child: GetBuilder<TableLogicLogic>(
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
                                            text: logic.singlePlayer.length > 0 ? (logic.singlePlayer['firstName'] + " !") : "",
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
                                            // text: "${DateFormat('kk:mm').format(logic.startTime.add(8.hours))}",
                                            text: "${DateFormat('kk:mm').format(logic.startTime)}",
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
            GetBuilder<TableLogicLogic>(builder: (logic) {
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
  final logic = Get.find<TableLogicLogic>();
  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        Get.to(() => ConfirmationInfo(), arguments: {
          "singlePlayer": logic.singlePlayer,
          "showState": Get.arguments});
      },
      child: GetBuilder<TableLogicLogic>(
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
