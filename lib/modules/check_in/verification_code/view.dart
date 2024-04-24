import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../mirra_style.dart';
import '../data/booking.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF233342),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                // alignment: Alignment.centerLeft,
                alignment: const Alignment(-0.6, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verification",
                      style: CustomTextStyles.title(color: Color(0xFFFFFFFF), fontSize: 48.sp, level: 2),
                    ),
                    // const SizedBox(height: 10),
                    Text(
                      "Enter Your Booking Information",
                      style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 36.sp, level: 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              _CheckInInput(title: "", controller: logic.codeController),
              const SizedBox(height: 100),
              CheckInButton(
                title: "NEXT",
                onPress: () async {
                  EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                  final code = logic.codeController.text;
                  try {
                    final bookingInfo = await logic.queryBookInfo(code);
                    EasyLoading.dismiss(animation: false);
                    // Get.dialog(Dialog(child: ConfirmationDialog(bookingInfo: bookingInfo, code: code)));
                    await Get.offAll(
                          () => ConfirmationPage(
                        bookingInfo: bookingInfo,
                        code: code,
                      ),
                    );
                  } on DioException catch (e) {
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
                    EasyLoading.dismiss();
                    // await Get.offAll(
                    //       () => ConfirmationPage(
                    //     bookingInfo: bookingInfoTest,
                    //     code: code,
                    //   ),
                    // );
                    if (e.response == null) EasyLoading.showError("Network Error!");
                    EasyLoading.showError(e.response?.data["error"]["message"]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckInInput extends StatelessWidget {
  const _CheckInInput({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);
  final TextEditingController controller;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          child: Text(title??''),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: 0.4.sw,
          // decoration: BoxDecoration(
          //   color: Color(0xFFDBE2E3), // 设置背景颜色
          //   borderRadius: BorderRadius.circular(10), // 设置圆角
          // ),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center, // 设置文本居中
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
            style: CustomTextStyles.verificationText(color: Color(0xFF000000), fontSize: 36.sp, letterSpacingVal: 40.sp),
          ),
        ),
      ],
    );
  }
}
