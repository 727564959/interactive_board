import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../mirra_style.dart';
import '../data/booking.dart';
import '../player_page/logic.dart';
import '../player_page/player_squad.dart';
import 'confirmation_page.dart';
import 'logic.dart';
import '../../../common.dart';
import '../widget/button.dart';
import 'confirmation_diglog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({Key? key}) : super(key: key);
  // final codeController = TextEditingController();
  final logic = Get.put(VerificationCodeLogic());
  int get tableId => Get.arguments["tableId"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<VerificationCodeLogic>(
            id: "verificationPage",
            builder: (logic) {
              return Container(
                width: 1.0.sw,
                height: 1.0.sh,
                color: Color(0xFF233342),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 1.0.sw,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
                              child: SizedBox(
                                width: 0.8.sw,
                                child: Text(
                                  "Hey there, let’s get you in!",
                                  style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Align(
                      //   // alignment: Alignment.centerLeft,
                      //   alignment: const Alignment(-0.6, 0.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "Verification",
                      //         style: CustomTextStyles.title(color: Color(0xFFFFFFFF), fontSize: 48.sp, level: 2),
                      //       ),
                      //       // const SizedBox(height: 10),
                      //       Text(
                      //         "Enter Your Booking Information",
                      //         style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 36.sp, level: 4),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Enter yourcode to check in 30 minutes before your game.",
                          style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                        ),
                      ),
                      const SizedBox(height: 40),
                      _CheckInInput(title: "", controller: logic.codeController),
                      const SizedBox(height: 100),
                      if(logic.isButtonShow) CheckInButton(
                        title: "NEXT",
                        onPress: () async {
                          EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                          final code = logic.codeController.text;
                          try {
                            final bookingInfo = await logic.queryBookInfo(code);
                            EasyLoading.dismiss(animation: false);
                            // 如果签过到，直接去形象设计
                            if(bookingInfo.status == "completed") {
                              final showInfo = await logic.bookingTimeChecked(bookingInfo.bookingTime);
                              print("showInfo ${showInfo}");
                              Get.offAll(() => PlayerSquadPage(),
                                  arguments: {
                                    'showInfo': showInfo,
                                    'customer': bookingInfo.customer,
                                    "isAddPlayerClick": true,
                                    "tableId": int.parse(bookingInfo.tableId.toString()),
                                  });
                            }
                            else {
                              await Get.offAll(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                            }
                          } on DioException catch (e) {
                            EasyLoading.dismiss();

                            // String jsonString = '''
                            //     {
                            //       "booking": {
                            //         "time": "2024-04-16T06:00:00.248Z"
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
                            //       () => ConfirmationPage(
                            //     bookingInfo: bookingInfoTest,
                            //     code: code,
                            //   ),
                            // );

                            if (e.response == null) EasyLoading.showError("Network Error!");
                            EasyLoading.showError(e.response?.data["error"]["message"]);
                            logic.codeController.clear();
                          }
                        },
                        disable: logic.codeController.text.length < 6 ? true : false,
                      ),
                    ],
                  ),
                ),

              );
            },
          ),
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
            textAlign: TextAlign.center, // 设置文本居中
            // maxLength: 6,
            inputFormatters: [
              LengthLimitingTextInputFormatter(6), // 设置最大长度为6
            ],
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
                  // 如果签过到，直接去形象设计
                  if(bookingInfo.status == "completed") {
                    final showInfo = await logic.bookingTimeChecked(bookingInfo.bookingTime);
                    print("showInfo ${showInfo}");
                    Get.offAll(() => PlayerSquadPage(),
                        arguments: {
                          'showInfo': showInfo,
                          'customer': bookingInfo.customer,
                          "isAddPlayerClick": true,
                          "tableId": int.parse(bookingInfo.tableId.toString()),
                        });
                  }
                  else {
                    await Get.offAll(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                  }
                  // await Get.offAll(() => ConfirmationPage(), arguments: {"bookingInfo": bookingInfo, "code": code},);
                } on DioException catch (e) {
                  print("哈哈哈哈 ${e}");
                  EasyLoading.dismiss();
                  if (e.response == null) EasyLoading.showError("Network Error!");
                  EasyLoading.showError(e.response?.data["error"]["message"]);
                  logic.updateStateFun(true);
                }
              }
              else if (value.length < 6 && value.length >= 1) {
                print("1-6之间");
                logic.updateStateFun(true);
              }
              else {
                print("为空");
                logic.updateStateFun(false);
              }
            },
            decoration: const InputDecoration(
              fillColor: Color(0xFFDBE2E3),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
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
