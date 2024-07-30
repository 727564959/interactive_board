import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common.dart';
import '../../../mirra_style.dart';
import '../../../widgets/breathing_image.dart';
import '../../../widgets/common_button.dart';
import '../player_page/player_squad.dart';
import '../verification_code/confirmation_page.dart';
import 'booking_state.dart';
import 'confirmation_squad.dart';
import 'logic.dart';

class LandingCheckIn extends StatefulWidget {
  LandingCheckIn({Key? key}) : super(key: key);

  @override
  _LandingCheckInState createState() => _LandingCheckInState();
}

class _LandingCheckInState extends State<LandingCheckIn> {
  final logic = Get.put(HomeLogic());
  late final Timer timer;

  @override
  void initState() {
    // Future.delayed(1.seconds).then((value) {
      timer = Timer.periodic(5.seconds, (timer) async {
        print("定时计数");
        getBookingStatus();
      });
    // });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void getBookingStatus() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try {
      logic.bookingState = await logic.getBookingStatus();
      print("getBookingStatus ${logic.bookingState}");
      logic.refreshFun();
      EasyLoading.dismiss(animation: false);
      // WidgetsBinding.instance.addPostFrameCallback((d) => Get.back());
    } on DioException catch (e) {
      EasyLoading.dismiss();
      if (e.response == null) EasyLoading.showError("Network Error!");
      EasyLoading.showError(e.response?.data["error"]["message"]);
    }
  }

  String getBayString(tableId) {
    if (tableId == 1) {
      return "A";
    } else if (tableId == 2) {
      return "B";
    } else if (tableId == 3) {
      return "C";
    } else {
      return "D";
    }
  }

  Color getBgColor(tableId) {
    if (tableId == 1) {
      return const Color(0xFFFFBD80);
    } else if (tableId == 2) {
      return const Color(0xFFEFB5FD);
    } else if (tableId == 3) {
      return const Color(0xFF8EE8BD);
    } else if (tableId == 4) {
      return const Color(0xFF9ED7F7);
    } else {
      return const Color(0xffA4EDF1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      id: "landingCheckInPage",
      builder: (logic) {
        // print("object ${MediaQuery.of(context).size.height}");
        // print("object ${MediaQuery.of(context).size.width}");
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
                    Container(
                      margin: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        'Welcome On board',
                        style: CustomTextStyles.title(
                            color: Colors.white, fontSize: 48.sp, level: 2
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0.08.sh),
                      child: Column(
                        children: [
                          Text(
                            'Choose Your Name to Check in',
                            style: CustomTextStyles.textSmall(
                                color: Colors.white, fontSize: 26.sp
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 0.05.sh),
                            width: 0.8.sw,
                            height: 0.55.sh,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: logic.bookingState.length < 4 ? 4 : logic.bookingState.length,
                              itemBuilder: (context, index) {
                                print("index ${index}");
                                print("length ${logic.bookingState.length}");
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: 0.06.sh,
                                    bottom: 0.06.sh,
                                    left: index == 0 ? 0.005.sw : 0.01.sw,
                                  ),
                                  child: Container(
                                    width: 0.19.sw,
                                    height: 0.43.sh,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: index < logic.bookingState.length ? getBgColor(logic.bookingState[index].tableId) : Color(0xffA4EDF1),
                                    ),
                                    child: (index + 1) <= logic.bookingState.length
                                        ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 0.02.sw,
                                            right: 0.02.sw,
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            logic.bookingState[index].customer.firstName + " " + logic.bookingState[index].customer.lastName.substring(0, 1),
                                            style: CustomTextStyles.title(
                                                color: Colors.black, fontSize: 40.sp, level: 3
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   logic.bookingState[index].customer.lastName,
                                        //   style: CustomTextStyles.title(
                                        //       color: Colors.black, fontSize: 40.sp, level: 3
                                        //   ),
                                        // ),
                                        const SizedBox(height: 20,),
                                        if(logic.bookingState[index].status == "pending") CommonButton(
                                          width: 210.w,
                                          height: 63.h,
                                          btnText: "CHECK IN",
                                          btnBgColor: Colors.transparent,
                                          textColor: Color(0xff000000),
                                          onPress: () async {
                                            await Get.to(() => ConfirmationPage(), arguments: {"bookingState": logic.bookingState[index]},);
                                          },
                                          borderColor: Color(0xff000000),
                                          changedBorderColor: Color(0xff000000),
                                          changedTextColor: Color(0xff000000),
                                          changedBgColor: Color(0xFF13EFEF),
                                        ),
                                        if(logic.bookingState[index].status != "pending") CommonButton(
                                          width: 260.w,
                                          height: 63.h,
                                          btnText: "ADD PLAYER",
                                          btnBgColor: Colors.transparent,
                                          textColor: Color(0xff000000),
                                          onPress: () async {
                                            final showInfo = await logic.bookingTimeChecked(logic.bookingState[index].bookingTime, logic.bookingState[index].bookingDate);
                                            print("showInfo ${showInfo}");
                                            //  String jsonString2 = '''
                                            //      {
                                            //        "showId": 81,
                                            //        "startDate": "2024-07-25",
                                            //        "startTime": "17:00:00",
                                            //        "associatedUsers": [
                                            //            {
                                            //                "tableId": 3,
                                            //                "userIds": [
                                            //                    398
                                            //                ],
                                            //                "consumerId": 398
                                            //            }
                                            //        ]
                                            //    }
                                            // ''';
                                            //  Map<String, dynamic> jsonData2 = json.decode(jsonString2);
                                            await Get.to(() => ConfirmationSquadPage(), arguments: {
                                              "bookingState": logic.bookingState[index],
                                              "showInfo": showInfo,
                                            });
                                          },
                                          borderColor: Color(0xff000000),
                                          changedBorderColor: Color(0xff000000),
                                          changedTextColor: Color(0xff000000),
                                          changedBgColor: Color(0xFF13EFEF),
                                        ),
                                        const SizedBox(height: 20,),
                                        if(logic.bookingState[index].status != "pending") Text(
                                          "BAY" + getBayString(logic.bookingState[index].tableId),
                                          style: CustomTextStyles.textNormal(
                                              color: Colors.black, fontSize: 30.sp
                                          ),
                                        ),
                                      ],
                                    ) : Column(
                                      mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                                      children: [
                                        Text(
                                          "OPEN",
                                          style: CustomTextStyles.title(
                                              color: Colors.black, fontSize: 40.sp, level: 3
                                          ),
                                        ),
                                      ],
                                    ),
                                    // child: GestureDetector(
                                    //   onTap: (index + 1) <= logic.bookingState.length ? (
                                    //       logic.bookingState[index].status != "pending" ? () async {
                                    //         // 执行可点击时的操作
                                    //         print("点击了已签到的");
                                    //         final showInfo = await logic.bookingTimeChecked(logic.bookingState[index].bookingTime, logic.bookingState[index].bookingDate);
                                    //         print("showInfo ${showInfo}");
                                    //         // Get.offAll(() => PlayerSquadPage(),
                                    //         //     arguments: {
                                    //         //       'showInfo': showInfo,
                                    //         //       "bookingState": logic.bookingState[index],
                                    //         //       "isAddPlayerClick": true,
                                    //         //       "tableId": int.parse(logic.bookingState[index].tableId.toString()),
                                    //         //     });
                                    //         await Get.to(() => ConfirmationPage(), arguments: {"bookingState": logic.bookingState[index]},);
                                    //       } : null
                                    //   ) : null,
                                    //   child: (index + 1) <= logic.bookingState.length
                                    //       ? Column(
                                    //     mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                                    //     children: [
                                    //       Text(
                                    //         logic.bookingState[index].customer.firstName,
                                    //         style: CustomTextStyles.title(
                                    //             color: Colors.black, fontSize: 40.sp, level: 3
                                    //         ),
                                    //       ),
                                    //       Text(
                                    //         logic.bookingState[index].customer.lastName,
                                    //         style: CustomTextStyles.title(
                                    //             color: Colors.black, fontSize: 40.sp, level: 3
                                    //         ),
                                    //       ),
                                    //       const SizedBox(height: 20,),
                                    //       if(logic.bookingState[index].status == "pending") CommonButton(
                                    //         width: 200.w,
                                    //         height: 72.h,
                                    //         btnText: "CHECK IN",
                                    //         btnBgColor: Color(0xffA4EDF1),
                                    //         textColor: Color(0xff000000),
                                    //         onPress: () async {
                                    //           await Get.to(() => ConfirmationPage(), arguments: {"bookingState": logic.bookingState[index]},);
                                    //         },
                                    //         borderColor: Color(0xff000000),
                                    //         changedBorderColor: Color(0xff000000),
                                    //         changedTextColor: Color(0xff000000),
                                    //         changedBgColor: Color(0xFF13EFEF),
                                    //       ),
                                    //       if(logic.bookingState[index].status != "pending") Text(
                                    //         "BAY" + getBayString(logic.bookingState[index].tableId),
                                    //         style: CustomTextStyles.textNormal(
                                    //             color: Colors.black, fontSize: 30.sp
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ) : Column(
                                    //     mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                                    //     children: [
                                    //       Text(
                                    //         "TEST",
                                    //         style: CustomTextStyles.title(
                                    //             color: Colors.black, fontSize: 40.sp, level: 3
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ),
                                );
                              },
                            ),
                            // children: [
                            //   Container(
                            //     width: 0.19.sw,
                            //     height: 0.43.sh,
                            //     decoration: const BoxDecoration(
                            //       borderRadius: BorderRadius.all(Radius.circular(20)),
                            //       color: Color(0xffA4EDF1),
                            //     ),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                            //       children: [
                            //         if(bookingState.isEmpty) Text(
                            //           "TEST",
                            //           style: CustomTextStyles.title(
                            //               color: Colors.black, fontSize: 40.sp, level: 3
                            //           ),
                            //         ),
                            //         if(bookingState.isNotEmpty) Text(
                            //           bookingState[0].customer.firstName,
                            //           style: CustomTextStyles.title(
                            //               color: Colors.black, fontSize: 40.sp, level: 3
                            //           ),
                            //         ),
                            //         if(bookingState.isNotEmpty) Text(
                            //             bookingState[0].customer.lastName,
                            //           style: CustomTextStyles.title(
                            //               color: Colors.black, fontSize: 40.sp, level: 3
                            //           ),
                            //         ),
                            //         const SizedBox(height: 20,),
                            //         if(bookingState[0].status == "pending" && bookingState.isNotEmpty) CommonButton(
                            //           width: 200.w,
                            //           height: 72.h,
                            //           btnText: "CHECK IN",
                            //           btnBgColor: Color(0xffA4EDF1),
                            //           textColor: Color(0xff000000),
                            //           onPress: () async {
                            //             await Get.to(() => ConfirmationPage(), arguments: {"bookingState": bookingState},);
                            //           },
                            //           borderColor: Color(0xff000000),
                            //           changedBorderColor: Color(0xff000000),
                            //           changedTextColor: Color(0xff000000),
                            //           changedBgColor: Color(0xFF13EFEF),
                            //         ),
                            //         if(bookingState[0].status != "pending" && bookingState.isNotEmpty) Text(
                            //           "BAY" + bookingState[0].tableId.toString(),
                            //           style: CustomTextStyles.textNormal(
                            //               color: Colors.black, fontSize: 30.sp
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            //   const Spacer(),
                            //   Container(
                            //     width: 0.19.sw,
                            //     height: 0.43.sh,
                            //     decoration: const BoxDecoration(
                            //       borderRadius: BorderRadius.all(Radius.circular(20)),
                            //       color: Color(0xffA4EDF1),
                            //     ),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                            //       children: [
                            //         Text(
                            //           'MonetMob',
                            //           style: CustomTextStyles.title(
                            //               color: Colors.black, fontSize: 40.sp, level: 3
                            //           ),
                            //         ),
                            //         const SizedBox(height: 20,),
                            //         if(true) CommonButton(
                            //           width: 200.w,
                            //           height: 72.h,
                            //           btnText: "CHECK IN",
                            //           btnBgColor: Color(0xffA4EDF1),
                            //           textColor: Color(0xff000000),
                            //           onPress: () async {
                            //
                            //           },
                            //           borderColor: Color(0xff000000),
                            //           changedBorderColor: Color(0xff000000),
                            //           changedTextColor: Color(0xff000000),
                            //           changedBgColor: Color(0xFF13EFEF),
                            //         ),
                            //         if(false) Text(
                            //           'BAY A',
                            //           style: CustomTextStyles.textNormal(
                            //               color: Colors.black, fontSize: 30.sp
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            //   const Spacer(),
                            //   Container(
                            //     width: 0.19.sw,
                            //     height: 0.43.sh,
                            //     decoration: const BoxDecoration(
                            //         borderRadius: BorderRadius.all(Radius.circular(20)),
                            //         color: Color(0xffA4EDF1)
                            //     ),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                            //       children: [
                            //         Text(
                            //           'MonetMob',
                            //           style: CustomTextStyles.title(
                            //               color: Colors.black, fontSize: 40.sp, level: 3
                            //           ),
                            //         ),
                            //         const SizedBox(height: 20,),
                            //         if(true) CommonButton(
                            //           width: 200.w,
                            //           height: 72.h,
                            //           btnText: "CHECK IN",
                            //           btnBgColor: Color(0xffA4EDF1),
                            //           textColor: Color(0xff000000),
                            //           onPress: () async {
                            //
                            //           },
                            //           borderColor: Color(0xff000000),
                            //           changedBorderColor: Color(0xff000000),
                            //           changedTextColor: Color(0xff000000),
                            //           changedBgColor: Color(0xFF13EFEF),
                            //         ),
                            //         if(false) Text(
                            //           'BAY A',
                            //           style: CustomTextStyles.textNormal(
                            //               color: Colors.black, fontSize: 30.sp
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            //   const Spacer(),
                            //   Container(
                            //     width: 0.19.sw,
                            //     height: 0.43.sh,
                            //     decoration: const BoxDecoration(
                            //         borderRadius: BorderRadius.all(Radius.circular(20)),
                            //         color: Color(0xffA4EDF1)
                            //     ),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center, // 设置垂直方向上的对齐方式为居中
                            //       children: [
                            //         Text(
                            //           'MonetMob',
                            //           style: CustomTextStyles.title(
                            //               color: Colors.black, fontSize: 40.sp, level: 3
                            //           ),
                            //         ),
                            //         const SizedBox(height: 20,),
                            //         if(false) CommonButton(
                            //           width: 200.w,
                            //           height: 72.h,
                            //           btnText: "CHECK IN",
                            //           btnBgColor: Color(0xffA4EDF1),
                            //           textColor: Color(0xff000000),
                            //           onPress: () async {
                            //
                            //           },
                            //           borderColor: Color(0xff000000),
                            //           changedBorderColor: Color(0xff000000),
                            //           changedTextColor: Color(0xff000000),
                            //           changedBgColor: Color(0xFF13EFEF),
                            //         ),
                            //         if(true) Text(
                            //           'BAY A',
                            //           style: CustomTextStyles.textNormal(
                            //               color: Colors.black, fontSize: 30.sp
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // logo动图
              Positioned(
                left: 40.0,
                top: 25.0,
                child: Image.asset(
                  MirraIcons.getGifPath('logo_rotate.gif'),
                  width: 340.w,
                  height: 82.h,
                  fit: BoxFit.cover,
                ),
              ),
              // 蓝色星星
              Positioned(
                right: 0.27.sw,
                top: 0.18.sh,
                child: BreathingScaleImage(
                  imagePath: MirraIcons.getSetAvatarIconPath('blue_star.png'),
                  duration: 1200,
                  beginSize: 0.6,
                  endSize: 1.1,
                ),
              ),
              // 红色星星
              Positioned(
                left: 0.42.sw,
                bottom: 0.16.sh,
                child: BreathingScaleImage(
                  imagePath: MirraIcons.getSetAvatarIconPath('red_star.png'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}