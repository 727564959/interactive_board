import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../widgets/common_Text_button.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_icon_button.dart';
import '../../term_of_use/view.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../home_page/booking_state.dart';
import '../terms_page/view.dart';
import 'logic.dart';

class ConfirmationPage extends StatelessWidget {
  ConfirmationPage({Key? key}) : super(key: key);
  BookingState get bookingState => Get.arguments["bookingState"];
  // String get code => Get.arguments["code"];
  final logic = Get.put(VerificationCodeLogic());

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
                  Container(
                    width: 1.0.sw,
                    margin: EdgeInsets.only(top: 20.0, left: 40.0),
                    child: Row(
                      children: [
                        CommonIconButton(
                          onPress: () {
                            Get.back();
                          },
                        ),
                        SizedBox(width: 0.1.sw - 48 - 40,),
                        Container(
                          // margin: EdgeInsets.only(top: 20.0, left: 40.0),
                          child: SizedBox(
                            // width: 0.24.sw,
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
                              // "Game Show Time : " + DateFormat("dd/MM/yyyy, kka").format(
                              //   bookingState.bookingTime.add(8.hours),
                              // ),
                              // "Game Show Time : " + DateFormat("dd/MM/yyyy, hh a").format(
                              //   bookingState.bookingTime.add(8.hours),
                              // ),
                              "Game Show Time : " + DateFormat("dd/MM/yyyy, hh:mm a").format(
                                  DateTime.parse(bookingState.bookingDate + " " + bookingState.bookingTime),
                              ),
                              style: CustomTextStyles.title(color: Color(0xFF13EFEF), fontSize: 36.sp, level: 2),
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
                                    bookingState.customer.firstName,
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
                                    bookingState.customer.lastName,
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
                                // alignment: const Alignment(-0.8, 0.0),
                                // child: Text(
                                //   bookingState.customer.email,
                                //   style: CustomTextStyles.title(color: Colors.black, fontSize: 36.sp, level: 4),
                                // ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30.0, top: 0.0),
                                  child: Text(
                                    bookingState.customer.email,
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
                                    bookingState.customer.phone,
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
                  //                     bookingState.bookingTime.add(8.hours),
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
                  //                     bookingState.bookingTime.add(8.hours),
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
                  // _NoProblemButton(width: 600.w, bookingState: bookingState, code: code),
                  CommonButton(
                    width: 600.w,
                    height: 100.h,
                    btnText: 'NO PROBLEM',
                    btnBgColor: Color(0xff13EFEF),
                    textColor: Colors.black,
                    onPress: () async {
                      EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                      try {
                        print("bookingState.bookingTime ${bookingState.bookingTime}");
                        print("bookingState.bookingDate ${bookingState.bookingDate}");
                        final showInfo = await logic.bookingTimeChecked(bookingState.bookingTime, bookingState.bookingDate);
                        EasyLoading.dismiss(animation: false);
                        // await Get.to(() => TermsOfUsePage(), arguments: {"isAddPlayerClick": false, "showInfo": showInfo, "customer": bookingState.customer, "code": code, "bookingState": bookingState});
                        print("showInfo ${showInfo}");
                        await Get.to(() => TermsOfUse(),
                                          arguments: {
                                            "isAddPlayerClick": false,
                                            "showInfo": showInfo,
                                            "bookingState": bookingState,
                                            "isFlow": "checkIn"});

                        // WidgetsBinding.instance.addPostFrameCallback((d) => Get.back());
                        // logic.codeController.clear();
                      } on DioException catch (e) {
                        EasyLoading.dismiss();
                        if (e.response == null) EasyLoading.showError("Network Error!");
                        EasyLoading.showError(e.response?.data["error"]["message"]);
                      }
                    },
                    changedBgColor: Color(0xffA4EDF1),
                  ),
                  SizedBox(height: 30.0,),
                  // _BackButton(),
                  // CommonTextButton(
                  //   btnText: "BACK",
                  //   textColor: Color(0xff13EFEF),
                  //   onPress: () {
                  //     Get.back();
                  //   },
                  //   changedTextColor: Color(0xffA4EDF1),
                  // ),
                ],
              ),
            ),
          ],
    ));
  }
}
