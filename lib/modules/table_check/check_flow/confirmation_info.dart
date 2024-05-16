import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../data/model/show_state.dart';
import 'group_set.dart';

class ConfirmationInfo extends StatelessWidget {
  ConfirmationInfo({Key? key}) : super(key: key);
  Map get singlePlayer => Get.arguments["singlePlayer"];

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
                          margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
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
                          margin: EdgeInsets.only(top: 50.0, left: 0.1.sw),
                          child: SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              singlePlayer['name'],
                              style: CustomTextStyles.title(color: Color(0xFFFFFFFF), fontSize: 36.sp, level: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFDBE2E3),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(top: 10.0, left: 0.1.sw),
                          constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 40.0),
                                  child: Text(
                                    "First Name",
                                    style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 0.0),
                                  child: Text(
                                    singlePlayer['name'],
                                    style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 5),
                                  ),
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
                          constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 40.0),
                                  child: Text(
                                    "Last Name",
                                    style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 0.0),
                                  child: Text(
                                    singlePlayer['name'],
                                    style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 5),
                                  ),
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
                          margin: EdgeInsets.only(top: 15.0, left: 0.1.sw),
                          constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                // heightFactor: 3,
                                // alignment: const Alignment(-0.8, 0.0),
                                // child: Text(
                                //   "Email",
                                //   style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                // ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 40.0),
                                  child: Text(
                                    "Email",
                                    style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 0.0),
                                  child: Text(
                                    singlePlayer['email'],
                                    style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 5),
                                  ),
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
                          constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h), //卡片大小
                          alignment: Alignment.center, //卡片内文字居中
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 40.0),
                                  child: Text(
                                    "Phone Number",
                                    style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 0.0),
                                  child: Text(
                                    singlePlayer['phone'],
                                    style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Color(0xFFDBE2E3),
                  //           borderRadius: BorderRadius.all(Radius.circular(10)),
                  //         ),
                  //         margin: EdgeInsets.only(top: 10.0, left: 0.1.sw),
                  //         constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h), //卡片大小
                  //         alignment: Alignment.center, //卡片内文字居中
                  //         child: Column(
                  //           children: [
                  //             Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Container(
                  //                 margin: EdgeInsets.only(left: 30.0, top: 40.0),
                  //                 child: Text(
                  //                   "Birthday",
                  //                   style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                  //                 ),
                  //               ),
                  //             ),
                  //             Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Container(
                  //                 margin: EdgeInsets.only(left: 30.0, top: 0.0),
                  //                 child: Text(
                  //                   DateFormat("dd/MM/yyyy - kka").format(
                  //                     bookingInfo.bookingTime.add(8.hours),
                  //                   ),
                  //                   style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 4),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Color(0xFFDBE2E3),
                  //           borderRadius: BorderRadius.all(Radius.circular(10)),
                  //         ),
                  //         margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  //         constraints: BoxConstraints.tightFor(width: 750.w, height: 201.h), //卡片大小
                  //         alignment: Alignment.center, //卡片内文字居中
                  //         child: Column(
                  //           children: [
                  //             Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Container(
                  //                 margin: EdgeInsets.only(left: 30.0, top: 40.0),
                  //                 child: Text(
                  //                   "Game Show Time",
                  //                   style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 28.sp, level: 6),
                  //                 ),
                  //               ),
                  //             ),
                  //             Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Container(
                  //                 margin: EdgeInsets.only(left: 30.0, top: 0.0),
                  //                 child: Text(
                  //                   DateFormat("dd/MM/yyyy - kka").format(
                  //                     bookingInfo.bookingTime.add(8.hours),
                  //                   ),
                  //                   style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 4),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 0.1.sh,),
                  _NoProblemButton(width: 600.w),
                  // SizedBox(height: 30.0,),
                  // _BackButton(),
                ],
              ),
            ),
          ],
        ));
  }
}

// 确认没问题的按钮
class _NoProblemButton extends StatelessWidget {
  _NoProblemButton({Key? key, required this.width}) : super(key: key);
  final double width;
  ShowState get showState => Get.arguments["showState"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
        try {
          EasyLoading.dismiss(animation: false);
          await Get.to(() => GroupSetIconPage(), arguments: {"showState": showState});
          WidgetsBinding.instance.addPostFrameCallback((d) => Get.back());
        } on DioException catch (e) {
          EasyLoading.dismiss();
          if (e.response == null) EasyLoading.showError("Network Error!");
          EasyLoading.showError(e.response?.data["error"]["message"]);
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
            "NO PROBLEM",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Colors.black, fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}
// 返回到addPlayer页面
class _BackButton extends StatelessWidget {
  _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Get.back();
      },
      child: Text(
        "Back",
        style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
      ),
    );
  }
}
