import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../terms_page/view.dart';
import 'logic.dart';

class ConfirmationPage extends StatelessWidget {
  ConfirmationPage({Key? key, required this.bookingInfo, required this.code}) : super(key: key);
  final BookingInfo bookingInfo;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Color(0xFF233342),
              child: Column(
                children: [
                  SizedBox(
                    width: 1.0.sw,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.0, left: 120.0),
                          child: SizedBox(
                            width: 0.24.sw,
                            child: Text(
                              "Confirmation",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1.0.sw,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50.0, left: 120.0),
                          child: SizedBox(
                            width: 0.24.sw,
                            child: Text(
                              bookingInfo.customer.name,
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // color: Colors.white24,
                            color: Color(0xFFDBE2E3),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(top: 15.0, left: 120.0),
                          constraints: BoxConstraints.tightFor(
                              width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                heightFactor: 3,
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  "Email",
                                  style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  bookingInfo.customer.email,
                                  style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFDBE2E3),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(top: 15.0, left: 10.0),
                          constraints: BoxConstraints.tightFor(
                              width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                heightFactor: 3,
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  "Phone Number",
                                  style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  bookingInfo.customer.phone,
                                  style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFDBE2E3),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(top: 10.0, left: 120.0),
                          constraints: BoxConstraints.tightFor(
                              width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                heightFactor: 3,
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  "Birthday",
                                  style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  DateFormat("dd/MM/yyyy - kka").format(
                                    bookingInfo.bookingTime.add(8.hours),
                                  ),
                                  style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFDBE2E3),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(top: 10.0, left: 10.0),
                          constraints: BoxConstraints.tightFor(
                              width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                heightFactor: 3,
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  "Game Show Time",
                                  style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  DateFormat("dd/MM/yyyy - kka").format(
                                    bookingInfo.bookingTime.add(8.hours),
                                  ),
                                  style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _NoProblemButton(width: 800.w, bookingInfo: bookingInfo, code: code),
                ],
              ),
            ),
          ],
        ));
  }
}

// 确认没问题的按钮
class _NoProblemButton extends StatelessWidget {
  _NoProblemButton({
    Key? key,
    required this.width,
    required this.bookingInfo,
    required this.code
  }) : super(key: key);
  final double width;
  final BookingInfo bookingInfo;
  final String code;

  String get backgroundUri => Global.getSetAvatarImageUrl("no_problem_btn.png");
  final logic = Get.put(VerificationCodeLogic());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
        try {
          final showInfo = await logic.ticketValidation(code, bookingInfo.bookingTime);
          EasyLoading.dismiss(animation: false);
          await Get.to(() => TermsOfUsePage(isAddPlayerClick: false, showInfo: showInfo, customer: bookingInfo.customer));
          WidgetsBinding.instance.addPostFrameCallback((d) => Get.back());
          logic.codeController.clear();
        } on DioException catch (e) {
          EasyLoading.dismiss();

          // String jsonString = '''
          //           {
          //             "startTime": "2024-04-16T06:00:00.248Z",
          //             "showId": 13,
          //             "associatedUsers": [
          //               {
          //                 "tableId": 2
          //               },
          //               {
          //                 "tableId": 3
          //               }
          //             ]
          //           }
          //         ''';
          // Map<String, dynamic> jsonData = json.decode(jsonString);
          // ShowInfo showInfoTest = ShowInfo.fromJson(jsonData);
          // print("哈哈哈哈哈: ${bookingInfo.customer}");
          // print("哈哈哈哈哈: ${showInfoTest}");
          // await Get.to(() => TermsOfUsePage(isAddPlayerClick: false, showInfo: showInfoTest, customer: bookingInfo.customer));

          if (e.response == null) EasyLoading.showError("Network Error!");
          EasyLoading.showError(e.response?.data["error"]["message"]);
        }
      },
      child: Container(
        height: width * 0.5,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundUri),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
