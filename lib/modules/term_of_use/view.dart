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
  final logic = Get.put(TermsOfUseLogic());

  @override
  Widget build(BuildContext context) {
    print("controller ${controller.isSignatureNotEmpty}");
    print("signatureController ${controller.signatureController}");
    return GetBuilder<TermsOfUseLogic>(
        id: "TermsOfUsePage",
        builder: (logic) {
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
                          width: 1.0.sw,
                          margin: EdgeInsets.only(top: 20.0, left: 40.0),
                          child: Row(
                            children: [
                              CommonIconButton(
                                onPress: () {
                                  // if(isAddPlayerClick) {
                                  //   if(isFlow == "checkIn") {
                                  //     Future.delayed(0.5.seconds).then((value) async {
                                  //       Get.offAll(() => PlayerSquadPage(),
                                  //           arguments: {
                                  //             "showInfo": showInfo,
                                  //             "customer": customer,
                                  //             "isAddPlayerClick": isAddPlayerClick,
                                  //             "isCountdownStart": true,
                                  //             "tableId": tableId,
                                  //           });
                                  //     });
                                  //     print("哈哈哈哈哈 ${Get.isRegistered<PlayerShowLogic>()}");
                                  //     if(Get.isRegistered<PlayerShowLogic>()) {
                                  //       Get.find<PlayerShowLogic>().isCountdownStart = true;
                                  //       Get.find<PlayerShowLogic>().getPlayerCardInfo(showInfo.showId);
                                  //     }
                                  //   }
                                  //   else if(isFlow == "tableCheck") {
                                  //     Get.back();
                                  //   }
                                  // }
                                  // else {
                                  //   Get.back();
                                  // }
                                  Get.back();
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
                        const SizedBox(height: 20.0,),
                        WaiverComponent(controller: controller),
                        const SizedBox(height: 15),
                        Container(
                          margin: EdgeInsets.only(left: 0.1.sw - 20),
                          child: _SelectedArea(clauseContent: "I have  read and agree to the agreement listed above", isSelected: logic.isSelectedOne, sign: 1),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 0.1.sw - 20),
                          child: _SelectedArea(clauseContent: "I agree to ESIGN Consent", isSelected: logic.isSelectedTwo, sign: 2),
                        ),
                        const SizedBox(height: 20,),
                        _BottomBtns(controller: controller),
                      ],
                    ),
                  ),
                ],
              ));
        },
    );
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
  int get userId => Get.arguments?["userId"] ?? -1;
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
                btnBgColor: Colors.transparent,
                // textColor: logic.isDisable ? Color(0xffFFFFFF).withOpacity(0.5) : Color(0xffFFFFFF),
                textColor:Color(0xffFFFFFF),
                disable: logic.isDisable,
                onPress: () async {
                  // print("isSignatureNotEmpty ${widget.controller.isSignatureNotEmpty}");
                  // print("isBottom ${widget.controller.isBottom}");
                  // print("signatureController ${widget.controller.signatureController}");
                  widget.controller.clearSignatureBar();
                  print("logic.isSelectedOne ${logic.isSelectedOne}");
                  print("logic.isSelectedTwo ${logic.isSelectedTwo}");
                },
                borderColor: Color(0xff13EFEF),
                changedBorderColor: Color(0xffA4EDF1),
                changedTextColor: Color(0xffA4EDF1),
                changedBgColor: Color(0xFF272727),
              ),
              const SizedBox(width: 20,),
              CommonButton(
                width: 600.w,
                height: 100.h,
                btnText: 'NEXT',
                btnBgColor: Color(0xff13EFEF),
                textColor: Colors.black,
                disable: logic.isDisable,
                onPress: () async {
                  print("接受了协议");
                  EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                  try {
                    EasyLoading.dismiss(animation: false);
                    Map singlePlayer = {};
                    String nameStr = "";
                    if(userId != -1) {
                      singlePlayer = await logic.fetchSingleUsers(userId);
                      nameStr = singlePlayer['firstName'] + " " + singlePlayer['lastName'];
                    }
                    else {
                      nameStr = customer.firstName + " " + customer.lastName;
                    }
                    print("nameStr ${nameStr}");
                    widget.controller.uploadSignature(nameStr);
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
                  } on DioException catch (e) {
                    EasyLoading.dismiss();
                    if (e.response == null) EasyLoading.showError("Network Error!");
                    EasyLoading.showError(e.response?.data["error"]["message"]);
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

// 勾选协议
class _SelectedArea extends StatefulWidget {
  _SelectedArea({
    Key? key,
    required this.clauseContent,
    this.isSelected = false,
    required this.sign,
  }) : super(key: key);
  final String clauseContent;
  bool isSelected;
  final int sign;

  @override
  State<_SelectedArea> createState() => _SelectedAreaState();
}

class _SelectedAreaState extends State<_SelectedArea> {
  final logic = Get.put(TermsOfUseLogic());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // // 单选框
        // Radio<bool>(
        //   value: true,
        //   groupValue: widget.isRadioSelected,
        //   onChanged: (bool? value) {
        //     setState(() {
        //       widget.isRadioSelected = value ?? false;
        //     });
        //   },
        // ),
        // 多选
        // Transform.scale(
        //   scale: 1.2, // 设置缩放比例为 1.5 倍
        //   child: Checkbox(
        //     value: widget.isSelected,
        //     onChanged: (bool? value) {
        //       setState(() {
        //         widget.isSelected = value!;
        //       });
        //     },
        //     activeColor: Colors.transparent, // 选中状态下颜色为透明
        //     checkColor: Color(0xff13EFEF), // 勾选图标颜色为蓝色
        //     side: BorderSide(
        //       color: widget.isSelected ? const Color(0xff13EFEF) : Colors.white,
        //       width: 2.0, // 边框宽度为 2.0
        //     ),
        //     // shape: RoundedRectangleBorder(
        //     //   borderRadius: BorderRadius.circular(4.0), // 设置复选框为圆角矩形
        //     // ),
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isSelected = !widget.isSelected;
              if(widget.sign == 1) {
                logic.isSelectedOne = widget.isSelected;
              }
              else if(widget.sign == 2) {
                logic.isSelectedTwo = widget.isSelected;
              }
              if(logic.isSelectedOne && logic.isSelectedTwo) {
                logic.isDisable = false;
                logic.refreshFun();
              } else {
                logic.isDisable = true;
                logic.refreshFun();
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: widget.isSelected ? Color(0xff13EFEF) : Colors.white, // 勾选后的边框颜色
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: widget.isSelected
                  ? Icon(Icons.check, color: Color(0xff13EFEF), size: 16.0)
                  : Icon(null, color: Colors.transparent, size: 16.0),
            ),
          ),
        ),
        const SizedBox(width: 15,),
        // 协议文字
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isSelected = !widget.isSelected;
              if(widget.sign == 1) {
                logic.isSelectedOne = widget.isSelected;
              }
              else if(widget.sign == 2) {
                logic.isSelectedTwo = widget.isSelected;
              }
              if(logic.isSelectedOne && logic.isSelectedTwo) {
                logic.isDisable = false;
                logic.refreshFun();
              } else {
                logic.isDisable = true;
                logic.refreshFun();
              }
            });
          },
          child: Text(
            widget.clauseContent,
            style: CustomTextStyles.textSmall(
                color: Colors.white, fontSize: 26.sp
            ),
          ),
        ),
      ],
    );
  }
}