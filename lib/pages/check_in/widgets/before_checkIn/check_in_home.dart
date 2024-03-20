import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:interactive_board/pages/check_in/widgets/before_checkIn/term_of_use.dart';

import '../../../../common.dart';

class CheckInHomePage extends StatelessWidget {
  CheckInHomePage({Key? key}) : super(key: key);
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
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 120.0),
                              child: SizedBox(
                                width: 0.24.sw,
                                child: Text(
                                  "Confirmation",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
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
                    // width: 1.0.sw,
                    // height: 0.2.sh,
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 60.0, left: 120.0),
                              constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Align(
                                    heightFactor: 3,
                                    alignment: const Alignment(-0.8, 0.0),
                                    child: Text(
                                      "Nick Name",
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 35.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'BurbankBold',
                                        color: Colors.white60,
                                        letterSpacing: 3.sp,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(-0.8, 0.0),
                                    child: Text(
                                      logic.singlePlayer.length > 0 ? logic.singlePlayer['nickname'] : "",
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 60.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'BurbankBold',
                                        color: Colors.white,
                                        letterSpacing: 5.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 60.0, left: 10.0),
                              constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Align(
                                    heightFactor: 3,
                                    alignment: const Alignment(-0.8, 0.0),
                                    child: Text(
                                      "Game Show",
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 35.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'BurbankBold',
                                        color: Colors.white60,
                                        letterSpacing: 3.sp,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(-0.8, 0.0),
                                    child: Text(
                                      logic.showStartTime,
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 50.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'BurbankBold',
                                        color: Colors.white,
                                        letterSpacing: 5.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                  SizedBox(
                    // width: 1.0.sw,
                    // height: 0.2.sh,
                    child: GetBuilder<CheckInLogic>(
                        builder: (logic) {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                margin: EdgeInsets.only(top: 10.0, left: 120.0),
                                constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h),//卡片大小
                                alignment: Alignment.center, //卡片内文字居中
                                child: Column(
                                  children: [
                                    Align(
                                      heightFactor: 3,
                                      alignment: const Alignment(-0.8, 0.0),
                                      child: Text(
                                        "Phone Number",
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 35.sp,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'BurbankBold',
                                          color: Colors.white60,
                                          letterSpacing: 3.sp,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(-0.8, 0.0),
                                      child: Text(
                                        logic.singlePlayer.length > 0 ? logic.singlePlayer['phone'] : "",
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 60.sp,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'BurbankBold',
                                          color: Colors.white,
                                          letterSpacing: 5.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h),//卡片大小
                                alignment: Alignment.center, //卡片内文字居中
                                child: Column(
                                  children: [
                                    Align(
                                      heightFactor: 3,
                                      alignment: const Alignment(-0.8, 0.0),
                                      child: Text(
                                        "Email",
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 35.sp,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'BurbankBold',
                                          color: Colors.white60,
                                          letterSpacing: 3.sp,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const Alignment(-0.8, 0.0),
                                      child: Text(
                                        logic.singlePlayer.length > 0 ? logic.singlePlayer['email'] : "",
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 60.sp,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'BurbankBold',
                                          color: Colors.white,
                                          letterSpacing: 5.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                  _NoProblemButton(width: 800.w),
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
// 确认没问题的按钮
class _NoProblemButton extends StatelessWidget {
  _NoProblemButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("no_problem_btn.png");

  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("跳转到隐私条款页面");
        print("54321 $testTabId");
        Get.to(() => TermOfUsePage(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "noProblemBtn",
        builder: (logic) {
          return Container(
            height: width * 0.5,
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