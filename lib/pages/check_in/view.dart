import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../common.dart';
import 'widgets/avatar_design.dart';

class CheckInPage extends StatelessWidget {
  CheckInPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // print("12345 ${dateTime.toString().substring(0, 19)}");
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
                height: 1.0.sh,
                child: GetBuilder<CheckInLogic>(
                  builder: (logic) {
                    return Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _LeftImage(width: 640.w, height: 1.0.sh),
                        _RightInfoView(
                            logic: logic,
                            width: 0.65.sw,
                            height: 1.0.sh,
                            dateTime: dateTime.toString().substring(0, 7)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        GetBuilder<CheckInLogic>(builder: (logic) {
          if (!logic.isCheckIn) {
            print("默认");
            return Container();
          } else {
            print("设计");
            return AvatarDeaignPage();
          }
        }),
        // Positioned(
        //   left: 20,
        //   top: 20,
        //   child: Text(
        //     "Table ${Global.tableId}",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 80.sp,
        //       decoration: TextDecoration.none,
        //       fontFamily: 'Burbank',
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.topLeft,
          child: _GoBackButton(
            width: 143.w,
          ),
        ),
      ],
    ));
  }
}

class _LeftImage extends StatelessWidget {
  const _LeftImage({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final content = Image.asset(
        width: width,
        height: height,
        fit: BoxFit.fitHeight,
        Global.getCheckInImageUrl("home_cover.png"));
    return content;
  }
}

class _RightInfoView extends StatelessWidget {
  const _RightInfoView(
      {Key? key,
      required this.logic,
      required this.width,
      required this.height,
      required this.dateTime})
      : super(key: key);
  final logic;
  final double width;
  final double height;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: const Alignment(0.1, -0.6),
            child: Text(
              // "WELCOME ABOARD ON\n\n MIRRA GAME SHOW",
              "WELCOME ABOARD ON",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.sp,
                decoration: TextDecoration.none,
                fontFamily: 'BurbankBold',
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.1, -0.4),
            child: Text(
              "MIRRA GAME SHOW",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.sp,
                decoration: TextDecoration.none,
                fontFamily: 'BurbankBold',
                color: Colors.white,
              ),
            ),
          ),
          _CheckInButton(width: 666.w, logic: logic),
          Align(
            alignment: const Alignment(0.8, 0.75),
            child: Text(
              dateTime,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.sp,
                decoration: TextDecoration.none,
                fontFamily: 'BurbankBold',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckInButton extends StatelessWidget {
  const _CheckInButton({
    Key? key,
    required this.width,
    required this.logic,
  }) : super(key: key);
  final double width;
  final logic;
  String get backgroundUri => logic.checkinBtnIsDown
      ? Global.getCheckInImageUrl("check_in_btn_selected.png")
      : Global.getCheckInImageUrl("check_in_btn_default.png");

  Widget get content {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: width * 0.1,
      decoration: TextDecoration.none,
      fontFamily: 'Burbank',
      color: Colors.black,
      textBaseline: TextBaseline.ideographic,
    );
    return Text("Check in", textAlign: TextAlign.center, style: style);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 按下
      onTapDown: (details) {
        print("按下");
        logic.checkinBtnDown(true);
      },
      // 抬起
      onTapUp: (details) {
        print("抬起");
        logic.checkinBtnDown(false);
      },
      // 点击事件
      onTap: () {
        print("单击");
        logic.checkInFun(true);
      },
      child: GetBuilder<CheckInLogic>(
        id: "checkIn",
        builder: (logic) {
          return Container(
            height: width * 0.18,
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
      // child: GetBuilder<CheckInLogic>(
      //   id: "checkIn",
      //   builder: (logic) {
      //     return Container(
      //       height: width / 2,
      //       width: width,
      //       // padding: EdgeInsets.only(left: width * 0.15),
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: AssetImage(backgroundUri),
      //           fit: BoxFit.fitWidth,
      //         ),
      //       ),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Transform.translate(
      //             // offset: Offset(0, -width * 0.02),
      //             offset: const Offset(0, 0),
      //             child: Icon(
      //               Icons.play_arrow,
      //               size: width * 0.18,
      //               color: const Color(0xFFFFE350),
      //             ),
      //           ),
      //           SizedBox(width: width * 0.05),
      //           content,
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class _GoBackButton extends StatelessWidget {
  _GoBackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getCheckInImageUrl("back_btn.png");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        Get.back();
      },
      child: GetBuilder<CheckInLogic>(
        id: "goBack",
        builder: (logic) {
          return Container(
            height: width / 2,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
            // child: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Transform.translate(
            //       offset: const Offset(0, 0),
            //       child: Icon(
            //         Icons.play_arrow,
            //         size: width * 0.18,
            //         color: const Color(0xFFFFE350),
            //       ),
            //     ),
            //     SizedBox(width: width * 0.05),
            //     // content,
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
