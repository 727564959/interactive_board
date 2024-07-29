import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../data/model/show_state.dart';
import '../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_icon_button.dart';
import '../../widgets/waiver_component.dart';
import '../add_player/view.dart';
import '../check_in/choose_table/view.dart';
import '../check_in/data/avatar_info.dart';
import '../check_in/data/show.dart';
import '../check_in/headgear_acquisition/view.dart';
import '../check_in/home_page/booking_state.dart';
import '../check_in/player_page/logic.dart';
import '../check_in/player_page/player_squad.dart';
import '../table_check/headgear/view.dart';
import '../table_check/player_show/view.dart';
import 'logic.dart';

class TermsOfUse extends StatelessWidget {
  TermsOfUse({
    Key? key,
  }) : super(key: key);
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments["tableId"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  String get isFlow => Get.arguments["isFlow"];
  ShowState get showState => Get.arguments?["showState"];

  final controller = WaiverController();

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
                            if(isAddPlayerClick) {
                              if(isFlow == "checkIn") {
                                Future.delayed(0.5.seconds).then((value) async {
                                  Get.offAll(() => PlayerSquadPage(),
                                      arguments: {
                                        "showInfo": showInfo,
                                        "customer": customer,
                                        "isAddPlayerClick": isAddPlayerClick,
                                        "isCountdownStart": true,
                                        "tableId": tableId,
                                      });
                                });
                                print("哈哈哈哈哈 ${Get.isRegistered<PlayerShowLogic>()}");
                                if(Get.isRegistered<PlayerShowLogic>()) {
                                  Get.find<PlayerShowLogic>().isCountdownStart = true;
                                  Get.find<PlayerShowLogic>().getPlayerCardInfo(showInfo.showId);
                                }
                              }
                              else if(isFlow == "tableCheck") {
                                Get.back();
                              }
                            }
                            else {
                              Get.back();
                            }
                          },
                        ),
                        SizedBox(width: 0.1.sw - 48 - 40,),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  "Sign the Release Waiver",
                                  style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Please read and sign the waiver below",
                                  style: CustomTextStyles.textSmall(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 26.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  WaiverComponent(controller: controller),
                  SizedBox(height: 40),
                  _BottomBtns(controller: controller),
                ],
              ),
            ),
          ],
        ));
  }
}

// 底部的功能按钮区域
class _BottomBtns extends StatefulWidget {
  const _BottomBtns({
    Key? key,
    required this.controller
  }) : super(key: key);
  final WaiverController controller;

  @override
  State<_BottomBtns> createState() => _BottomBtnsState();
}

class _BottomBtnsState extends State<_BottomBtns> {
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments?["tableId"];
  BookingState get bookingState => Get.arguments?["bookingState"];
  Customer get customer => bookingState.customer;
  String get isFlow => Get.arguments["isFlow"];
  int get userId => Get.arguments?["userId"];
  ShowState get showState => Get.arguments?["showState"];

  final logic = Get.put(TermsOfUseLogic());

  @override
  Widget build(BuildContext context) {
    // print("isBottom ${widget.controller.isBottom}");
    final content = Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButton(
                width: 600.w,
                height: 100.h,
                btnText: "CLEAR",
                btnBgColor: Color(0xFF272727),
                textColor: Color(0xffFFFFFF),
                onPress: () async {
                  // print("isSignatureNotEmpty ${widget.controller.isSignatureNotEmpty}");
                  // print("isBottom ${widget.controller.isBottom}");
                  // print("signatureController ${widget.controller.signatureController}");
                  widget.controller.clearSignatureBar();
                },
                borderColor: Color(0xff13EFEF),
                changedBorderColor: Color(0xffA4EDF1),
                changedTextColor: Color(0xffA4EDF1),
                changedBgColor: Color(0xFF272727),
              ),
              SizedBox(width: 20,),
              CommonButton(
                width: 600.w,
                height: 100.h,
                btnText: 'NEXT',
                btnBgColor: Color(0xff13EFEF),
                textColor: Colors.black,
                // disable: !widget.controller.isSignatureNotEmpty,
                onPress: () async {
                  print("接受了协议");
                  // 是新增点击则去新增页面，反之去选桌
                  if (isAddPlayerClick) {
                    List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(userId);
                    if(isFlow == "checkIn") {
                      if(headgearObj.isEmpty) {
                        Get.offAll(() => PlayerSquadPage(),
                            arguments: {
                              'showInfo': showInfo,
                              "bookingState": bookingState,
                              "isAddPlayerClick": isAddPlayerClick,
                              "tableId": tableId,
                            });
                      }
                      else {
                        Get.offAll(() => HeadgearAcquisitionPage(),
                          arguments: {
                            'showInfo': showInfo,
                            "bookingState": bookingState,
                            'headgearObj': headgearObj,
                            'userId': userId,
                            "isAddPlayerClick": isAddPlayerClick,
                            "tableId": tableId,
                          },
                        );
                      }
                    }
                    else if(isFlow == "tableCheck") {
                      if(headgearObj.isEmpty) {
                        Get.offAll(() => PlayerShowPage(),
                            arguments: {
                              'showState': showState,
                            });
                      }
                      else {
                        Get.offAll(() => HeadgearPage(),
                          arguments: {
                            'showState': showState,
                            'headgearObj': headgearObj,
                            'userId': userId,
                          },
                        );
                      }
                    }
                  } else {
                    if(isFlow == "checkIn") {
                      EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                      try {
                        EasyLoading.dismiss(animation: false);
                        await Get.to(() => ChooseTablePage(),
                                            arguments: {
                                              "showInfo": showInfo,
                                              "isAddPlayerClick": isAddPlayerClick,
                                              "bookingState": bookingState});
                        // WidgetsBinding.instance.addPostFrameCallback((d) => Get.back());
                      } on DioException catch (e) {
                        EasyLoading.dismiss();
                        if (e.response == null) EasyLoading.showError("Network Error!");
                        EasyLoading.showError(e.response?.data["error"]["message"]);
                      }
                    }
                    else if(isFlow == "tableCheck") {

                    }
                  }
                },
                changedBgColor: Color(0xffA4EDF1),
              ),
            ],
          )
        ],
      ),
    );
    return content;
  }
}