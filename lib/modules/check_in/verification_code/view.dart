import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app_routes.dart';
import '../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../data/booking.dart';
import '../player_page/logic.dart';
import '../player_page/player_squad.dart';
import 'confirmation_page.dart';
import 'logic.dart';
import '../../../common.dart';
import '../widget/button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({Key? key}) : super(key: key);
  // final codeController = TextEditingController();
  final logic = Get.put(VerificationCodeLogic());
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    const fontVariations_TitleH1 = [
      FontVariation("GRAD", -71),
      FontVariation.width(151),
      FontVariation.slant(0),
      FontVariation("XOPQ", 96),
      FontVariation("YOPQ", 89),
      FontVariation("XTRA", 538),
      FontVariation("YTUC", 528),
      FontVariation("YTLC", 483),
      FontVariation("YTAS", 649),
      FontVariation("YTDE", -203),
      FontVariation("YTFI", 606),
      FontVariation.opticalSize(14),
      FontVariation.weight(877),
    ];

    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<VerificationCodeLogic>(
            id: "verificationPage",
            builder: (logic) {
              print("logic.focusNode.hasFocus ${logic.focusNode.hasFocus}");
              return Container(
                width: 1.0.sw,
                height: 1.0.sh,
                color: Color(0xFF233342),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0, left: 40.0),
                        constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Hey there, let’s get you in!',
                                style: CustomTextStyles.title(
                                    color: Colors.white, fontSize: 48.sp, level: 2),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Enter your code to check in 30 minutes before your game.',
                                style: CustomTextStyles.textSmall(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 26.sp,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 1.0.sw,
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
                      //         child: SizedBox(
                      //           width: 0.8.sw,
                      //           child: Text(
                      //             "Hey there, let’s get you in!",
                      //             style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // // Align(
                      // //   // alignment: Alignment.centerLeft,
                      // //   alignment: const Alignment(-0.6, 0.0),
                      // //   child: Column(
                      // //     crossAxisAlignment: CrossAxisAlignment.start,
                      // //     children: [
                      // //       Text(
                      // //         "Verification",
                      // //         style: CustomTextStyles.title(color: Color(0xFFFFFFFF), fontSize: 48.sp, level: 2),
                      // //       ),
                      // //       // const SizedBox(height: 10),
                      // //       Text(
                      // //         "Enter Your Booking Information",
                      // //         style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 36.sp, level: 4),
                      // //       ),
                      // //     ],
                      // //   ),
                      // // ),
                      // const SizedBox(height: 50),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Text(
                      //     "Enter your code to check in 30 minutes before your game.",
                      //     style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                      //   ),
                      // ),
                      const SizedBox(height: 60),
                      _CheckInInput(title: "", controller: logic.codeController),
                      SizedBox(height: logic.isStateShow == 0 ? 30 : 50),
                      if(logic.isStateShow == 0) _BackButton(),
                      if(logic.isStateShow == -1) Container(
                        margin: EdgeInsets.only(left: 0.1.sw),
                        width: 0.9.sw,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Code check in failed, Please review your information.',
                              style: CustomTextStyles.title(
                                  color: Color(0xFFFF4848),
                                  fontSize: 74.sp,
                                  level: 1),
                            ),
                            SizedBox(height: 180.0,),
                            Container(
                              margin: EdgeInsets.only(left: (1.0.sw - 600)/2),
                              // child: _ConfirmButton(width: 600.w, btnText: "OK"),
                              child: CommonButton(
                                width: 600.w,
                                height: 100.h,
                                btnText: 'OK',
                                btnBgColor: Color(0xff13EFEF),
                                textColor: Colors.black,
                                onPress: () {
                                  // 如果是早到、晚到这两种状态，直接回到首页
                                  if(logic.isStateShow == 1 || logic.isStateShow == 2) {
                                    logic.updateStateShowFun(0);
                                    logic.codeController.clear();
                                    // 跳转回首页
                                    Get.offAllNamed(AppRoutes.landingPage);
                                  }
                                  else {
                                    logic.updateStateShowFun(0);
                                    logic.codeController.clear();
                                    // 获取焦点到 focusNode
                                    FocusScope.of(context).requestFocus(logic.focusNode);
                                  }
                                },
                                changedBgColor: Color(0xffA4EDF1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(logic.isStateShow == 1) Container(
                        margin: EdgeInsets.only(left: 0.1.sw),
                        width: 0.9.sw,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Uh oh, your booking for",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "game show " + DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(logic.bookingTime)) + " ",
                                // style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                                style: TextStyle(
                                  fontSize: 74.sp,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'RobotoFlex',
                                  color: Colors.white,
                                  fontVariations: fontVariations_TitleH1,
                                ),
                                children: [
                                  TextSpan(
                                    text: "isn't valid",
                                    style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "anymore.",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                            ),
                            SizedBox(height: 30,),
                            Text(
                              "Don't miss out! Browse similar events or contact us for assistance!",
                              style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 30.sp, level: 1),
                            ),
                            SizedBox(height: 60.0,),
                            Container(
                              margin: EdgeInsets.only(left: (1.0.sw - 600)/2),
                              child: CommonButton(
                                width: 600.w,
                                height: 100.h,
                                btnText: 'CLOSE',
                                btnBgColor: Color(0xff13EFEF),
                                textColor: Colors.black,
                                onPress: () {
                                  // 如果是早到、晚到这两种状态，直接回到首页
                                  if(logic.isStateShow == 1 || logic.isStateShow == 2) {
                                    logic.updateStateShowFun(0);
                                    logic.codeController.clear();
                                    // 跳转回首页
                                    Get.offAllNamed(AppRoutes.landingPage);
                                  }
                                  else {
                                    logic.updateStateShowFun(0);
                                    logic.codeController.clear();
                                    // 获取焦点到 focusNode
                                    FocusScope.of(context).requestFocus(logic.focusNode);
                                  }
                                },
                                changedBgColor: Color(0xffA4EDF1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(logic.isStateShow == 2) Container(
                        margin: EdgeInsets.only(left: 0.1.sw),
                        width: 0.9.sw,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check-in for the",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "game show " + DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(logic.bookingTime)) + " ",
                                // style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                                style: TextStyle(
                                  fontSize: 74.sp,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'RobotoFlex',
                                  color: Colors.white,
                                  fontVariations: fontVariations_TitleH1,
                                ),
                                children: [
                                  TextSpan(
                                    text: "will start at",
                                    style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Text(
                              DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(logic.bookingTime).subtract(Duration(hours: 1))),
                              style: CustomTextStyles.title(color: const Color(0xffEF7E00), fontSize: 74.sp, level: 1),
                            ),
                            SizedBox(height: 90.0,),
                            Container(
                              margin: EdgeInsets.only(left: (1.0.sw - 600)/2),
                              child: CommonButton(
                                width: 600.w,
                                height: 100.h,
                                btnText: 'CLOSE',
                                btnBgColor: Color(0xff13EFEF),
                                textColor: Colors.black,
                                onPress: () {
                                  // 如果是早到、晚到这两种状态，直接回到首页
                                  if(logic.isStateShow == 1 || logic.isStateShow == 2) {
                                    logic.updateStateShowFun(0);
                                    logic.codeController.clear();
                                    // 跳转回首页
                                    Get.offAllNamed(AppRoutes.landingPage);
                                  }
                                  else {
                                    logic.updateStateShowFun(0);
                                    logic.codeController.clear();
                                    // 获取焦点到 focusNode
                                    FocusScope.of(context).requestFocus(logic.focusNode);
                                  }
                                },
                                changedBgColor: Color(0xffA4EDF1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 100),
                      // if(logic.isButtonShow) CheckInButton(
                      //   title: "NEXT",
                      //   onPress: () async {
                      //     EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                      //     final code = logic.codeController.text;
                      //     try {
                      //       final bookingInfo = await logic.queryBookInfo(code);
                      //       EasyLoading.dismiss(animation: false);
                      //       // 如果签过到，直接去形象设计
                      //       if(bookingInfo.status == "completed") {
                      //         final showInfo = await logic.bookingTimeChecked(bookingInfo.bookingTime);
                      //         print("showInfo ${showInfo}");
                      //         Get.offAll(() => PlayerSquadPage(),
                      //             arguments: {
                      //               'showInfo': showInfo,
                      //               'customer': bookingInfo.customer,
                      //               "isAddPlayerClick": true,
                      //               "tableId": int.parse(bookingInfo.tableId.toString()),
                      //             });
                      //       }
                      //       else {
                      //         await Get.to(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                      //         // await Get.offAll(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                      //       }
                      //     } on DioException catch (e) {
                      //       EasyLoading.dismiss();
                      //
                      //       // String jsonString = '''
                      //       //     {
                      //       //       "booking": {
                      //       //         "time": "2024-04-16T06:00:00.248Z"
                      //       //       },
                      //       //       "customer":
                      //       //         {
                      //       //           "name": "M Zq",
                      //       //           "email": "mu15215217793@gmail.com",
                      //       //           "phone": "7678678676"
                      //       //         }
                      //       //     }
                      //       //   ''';
                      //       // Map<String, dynamic> jsonData = json.decode(jsonString);
                      //       // BookingInfo bookingInfoTest = BookingInfo.fromJson(jsonData);
                      //       // await Get.offAll(
                      //       //       () => ConfirmationPage(
                      //       //     bookingInfo: bookingInfoTest,
                      //       //     code: code,
                      //       //   ),
                      //       // );
                      //
                      //       if (e.response == null) EasyLoading.showError("Network Error!");
                      //       EasyLoading.showError(e.response?.data["error"]["message"]);
                      //       logic.codeController.clear();
                      //     }
                      //   },
                      //   disable: logic.codeController.text.length < 6 ? true : false,
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
          // // 错误信息的全屏蒙版
          // GetBuilder<VerificationCodeLogic>(
          //   id: "verificationMasking",
          //   builder: (logic) {
          //     if(logic.isShowMasking == 1 || logic.isShowMasking == 2) {
          //       return Positioned.fill(
          //         child: GestureDetector(
          //           onTap: () async {
          //             logic.updatePageFun(0);
          //             logic.codeController.clear();
          //             // 获取焦点到 focusNode
          //             FocusScope.of(context).requestFocus(logic.focusNode);
          //           },
          //           child: Container(
          //             color: Colors.black54,
          //             child: Container(
          //               margin: EdgeInsets.only(left: 0.1.sw, top: 0.4.sh),
          //               child: logic.isShowMasking == 1
          //                   ? Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         "Uh oh, your booking for",
          //                         style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
          //                       ),
          //                       RichText(
          //                         text: TextSpan(
          //                           text: "game show " + DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(logic.bookingTime)) + " ",
          //                           // style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
          //                           style: TextStyle(
          //                             fontSize: 74.sp,
          //                             decoration: TextDecoration.underline,
          //                             fontFamily: 'RobotoFlex',
          //                             color: Colors.white,
          //                             fontVariations: fontVariations_TitleH1,
          //                           ),
          //                           children: [
          //                             TextSpan(
          //                               text: "isn't valid",
          //                               style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                       Text(
          //                         "anymore.",
          //                         style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
          //                       ),
          //                       SizedBox(height: 30,),
          //                       Text(
          //                         "Don't miss out! Browse similar events or contact us for assistance!",
          //                         style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 30.sp, level: 1),
          //                       ),
          //                     ],
          //                   )
          //                   : Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         "Check-in for the",
          //                         style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
          //                       ),
          //                       RichText(
          //                         text: TextSpan(
          //                           text: "game show " + DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(logic.bookingTime)) + " ",
          //                           // style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
          //                           style: TextStyle(
          //                             fontSize: 74.sp,
          //                             decoration: TextDecoration.underline,
          //                             fontFamily: 'RobotoFlex',
          //                             color: Colors.white,
          //                             fontVariations: fontVariations_TitleH1,
          //                           ),
          //                           children: [
          //                             TextSpan(
          //                               text: "will start at",
          //                               style: CustomTextStyles.title(color: Colors.white, fontSize: 74.sp, level: 1),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                       SizedBox(height: 30,),
          //                       Text(
          //                         DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(logic.bookingTime).subtract(Duration(hours: 1))),
          //                         style: CustomTextStyles.title(color: Colors.orange, fontSize: 74.sp, level: 1),
          //                       ),
          //                     ],
          //                   ),
          //             ),
          //           ),
          //         ),
          //       );
          //     }
          //     else {
          //       return Container();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

class _CheckInInput extends StatelessWidget {
  _CheckInInput({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);
  final TextEditingController controller;
  final String? title;

  final logic = Get.put(VerificationCodeLogic());
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // SizedBox(
        //   width: 100,
        //   child: Text(title ?? ''),
        // ),
        SizedBox(
          // padding: const EdgeInsets.symmetric(vertical: 10),
          width: 0.4.sw,
          // decoration: BoxDecoration(
          //   color: Color(0xFFDBE2E3), // 设置背景颜色
          //   borderRadius: BorderRadius.circular(10), // 设置圆角
          // ),
          child: TextField(
            autofocus: true,
            controller: controller,
            cursorWidth: 5.0,          // 光标粗细
            cursorRadius: Radius.circular(3.0), // 使用Radius.circular设置圆形半径
            cursorColor: Colors.black,   // 光标颜色
            cursorHeight: 48.0, // 设置光标的高度，与文字的字体大小一致
            textAlign: TextAlign.center, // 设置文本居中
            inputFormatters: [
              LengthLimitingTextInputFormatter(6), // 设置最大长度为6
            ],
            focusNode: logic.focusNode,
            onChanged: (value) async {
              if (value.length >= 6) {
                // 当输入6个字符后自动失去焦点退出
                // FocusScope.of(context).unfocus();
                print("到六个字符了");
                EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                final code = value;
                // String jsonString = '''
                //     {
                //       "booking": {
                //         "time": "2024-05-09T11:00:00.307Z"
                //       },
                //       "customer":
                //         {
                //           "name": "M Zq",
                //           "email": "mu15215217793@gmail.com",
                //           "phone": "7678678676"
                //         }
                //     }
                //   ''';
                // Map<String, dynamic> jsonData = json.decode(jsonString);
                // BookingInfo bookingInfoTest = BookingInfo.fromJson(jsonData);
                // await Get.offAll(
                //       () => ConfirmationPage(),
                //   arguments: {"bookingInfo": bookingInfoTest, "code": code},
                // );
                print("code ${code}");
                try {
                  final bookingInfo = await logic.queryBookInfo(code);
                  EasyLoading.dismiss(animation: false);

                  logic.updateStateShowFun(0);
                  // logic.updateStateFun(false);
                  // // 点击空白处时请求取消焦点
                  // logic.focusNode.unfocus();

                  logic.bookingDate = bookingInfo.bookingDate;
                  logic.bookingTime = bookingInfo.bookingTime;
                  logic.bookingEnd = bookingInfo.bookingEnd;

                  // 获取当前时间
                  DateTime currentDateTime = DateTime.now();
                  // 解析开始时间
                  DateTime targetDateTime = DateTime.parse(bookingInfo.bookingDate + " " + bookingInfo.bookingTime);
                  // targetDateTime = targetDateTime.add(1.hours);
                  // targetDateTime = targetDateTime.subtract(Duration(hours: 3));
                  // 解析结束时间时间
                  DateTime targetDateTime1 = DateTime.parse(bookingInfo.bookingDate + " " + bookingInfo.bookingEnd);
                  // targetDateTime1 = targetDateTime1.add(1.hours);
                  // targetDateTime1 = targetDateTime1.subtract(Duration(hours: 3));
                  // 计算时间差
                  Duration difference = targetDateTime.difference(currentDateTime);
                  // 计算开始时间和结束时间的时间差
                  Duration difference1 = targetDateTime.difference(targetDateTime1);
                  print("difference ${difference}");
                  print("difference1 ${difference1}");
                  // 判断时间差是否小于等于1小时
                  // if (difference <= Duration(hours: 1) && difference >= Duration(hours: 0) && !currentDateTime.isAfter(targetDateTime1)) {
                  if (difference <= Duration(hours: 1) && difference >= difference1 && !currentDateTime.isAfter(targetDateTime1)) {
                    print('当前时间比目标时间小于等于一个小时');
                    print('开始走正常流程');
                    // 如果签过到，直接去形象设计
                    if(bookingInfo.status == "completed") {
                      // final showInfo = await logic.bookingTimeChecked(bookingInfo.bookingTime);
                      final showInfo = await logic.bookingTimeChecked(bookingInfo.bookingTime, bookingInfo.bookingDate);
                      print("showInfo ${showInfo}");
                      Get.offAll(() => PlayerSquadPage(),
                          arguments: {
                            'showInfo': showInfo,
                            'customer': bookingInfo.customer,
                            "isAddPlayerClick": true,
                            "tableId": int.parse(bookingInfo.tableId.toString()),
                          });
                      // await Get.to(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                    }
                    else {
                      await Get.to(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                      // await Get.offAll(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                    }
                  } else {
                    if(currentDateTime.isAfter(targetDateTime1)) {
                      print('当前时间大于目标时间');
                      logic.updateStateShowFun(1);
                      // logic.updatePageFun(1);
                      // Future.delayed(5.seconds).then((value) async {
                      //   print("自动关闭蒙版");
                      //   logic.updatePageFun(0);
                      //   logic.codeController.clear();
                      //   // 获取焦点到 focusNode
                      //   FocusScope.of(context).requestFocus(logic.focusNode);
                      // });
                    }
                    else {
                      print('当前时间与目标时间的时间差大于一个小时');
                      logic.updateStateShowFun(2);
                      // logic.updatePageFun(2);
                      // Future.delayed(5.seconds).then((value) async {
                      //   print("自动关闭蒙版");
                      //   logic.updatePageFun(0);
                      //   logic.codeController.clear();
                      //   // 获取焦点到 focusNode
                      //   FocusScope.of(context).requestFocus(logic.focusNode);
                      // });
                    }
                  }
                } on DioException catch (e) {
                  // print("哈哈哈哈 ${e}");
                  print("哈哈哈哈 ${e.response}");
                  EasyLoading.dismiss();
                  if (e.response == null) EasyLoading.showError("Network Error!");
                  // EasyLoading.showError(e.response?.data["error"]["message"]);
                  // logic.updateStateFun(true);
                  logic.updateStateShowFun(-1);
                }
              }
              else if (value.length < 6 && value.length >= 1) {
                print("1-6之间");
                // logic.updateStateFun(true);
              }
              else {
                print("为空");
                // logic.updateStateFun(false);
                logic.updateStateShowFun(0);
              }
            },
            decoration: InputDecoration(
              fillColor: Color(0xFFDBE2E3),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
            style: CustomTextStyles.verificationText(color: Color(0xFF000000), fontSize: 48.sp, letterSpacingVal: 40.sp),
          ),
        ),
      ],
    );
  }
}

// 下一步的按钮
class _ConfirmButton extends StatelessWidget {
  _ConfirmButton({
    Key? key,
    required this.width,
    required this.btnText,
  }) : super(key: key);
  final double width;
  final String btnText;
  final logic = Get.put(VerificationCodeLogic());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        // 如果是早到、晚到这两种状态，直接回到首页
        if(logic.isStateShow == 1 || logic.isStateShow == 2) {
          logic.updateStateShowFun(0);
          logic.codeController.clear();
          // 跳转回首页
          Get.offAllNamed(AppRoutes.landingPage);
        }
        else {
          logic.updateStateShowFun(0);
          logic.codeController.clear();
          // 获取焦点到 focusNode
          FocusScope.of(context).requestFocus(logic.focusNode);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
        child: Center(
          child: Text(
            btnText,
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  _BackButton({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(VerificationCodeLogic());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        logic.focusNode.unfocus();
        Future.delayed(0.3.seconds).then((value) async {
          Get.back();
        });
      },
      child: Text(
        "BACK",
        style: CustomTextStyles.button(color: Color(0xFF13EFEF), fontSize: 28.sp),
      ),
    );
  }
}
