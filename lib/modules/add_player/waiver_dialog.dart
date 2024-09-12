import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../../data/model/show_state.dart';
import '../check_in/data/show.dart';
import '../check_in/home_page/booking_state.dart';
import 'logic.dart';
import 'old_user.dart';
import 'user_selection.dart';

class WaiverDialog extends StatelessWidget {
  final logic = Get.put(UserRegistrationLogic());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.48.sw,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFF272727),
        border: Border.all(
          color: Color(0xFF5A5858),    // 边框颜色
          width: 2.0,           // 边框宽度
          style: BorderStyle.solid,  // 边框样式
        ),
      ),
      child: Obx(() {
        // 使用 Obx 监听 isExist 变化
        return Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 30,),
            if(!logic.isExist.value) Text(
              'Please read and sign the waiver below',
              textAlign: TextAlign.center,
              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
            ),
            if(logic.isExist.value) Text(
              'Unable to Find Signed Waiver',
              textAlign: TextAlign.center,
              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
            ),
            SizedBox(height: 20,),
            if(!logic.isExist.value) Image.asset(
              MirraIcons.getSetAvatarIconPath('waiver_QRcode.png'),
              width: 0.11.sw,
              height: 0.11.sw,
              fit: BoxFit.cover,
            ),
            if(logic.isExist.value) Text(
              "We couldn't find your signed waiver.",
              textAlign: TextAlign.center,
              style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
            ),
            if(logic.isExist.value) Text(
              "Please resign the waiver or contact the onsite support.",
              textAlign: TextAlign.center,
              style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
            ),
            SizedBox(height: 30,),
            _BottomBtns(),
            SizedBox(height: 30,),
          ],
        );
      }),

    );
  }
}

// 底部的功能按钮区域
class _BottomBtns extends StatelessWidget {
  _BottomBtns({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(UserRegistrationLogic());
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  int get tableId => Get.arguments["tableId"];
  String get isFlow => Get.arguments["isFlow"];
  ShowState get showState => Get.arguments?["showState"];

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 0.7.sw), //卡片大小
      alignment: Alignment.center,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 0.0, left: 0.0),
                child: Row(
                  children: [
                    CommonButton(
                      width: 340.w,
                      height: 70.h,
                      btnText: "CANCEL",
                      btnBgColor: Color(0xFF272727),
                      textColor: Color(0xff13EFEF),
                      onPress: () async {
                        logic.updateState(false);
                        Navigator.of(context).pop();
                      },
                      borderColor: Color(0xff13EFEF),
                      changedBorderColor: Color(0xffA4EDF1),
                      changedTextColor: Color(0xffA4EDF1),
                      changedBgColor: Color(0xFF272727),
                    ),
                    SizedBox(width: 10,),
                    if(!logic.isExist.value) CommonButton(
                      width: 340.w,
                      height: 70.h,
                      btnText: 'DONE',
                      btnBgColor: Color(0xff13EFEF),
                      textColor: Colors.black,
                      onPress: () async {
                        EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                        try {
                          // 同步邮箱信息
                          await logic.syncRemote(email: logic.emailController.text);
                          // 校验邮箱
                          List<dynamic> checkingUser = await logic.checkingPlayer(logic.emailController.text);
                          // print("是否存在用户 ${checkingUser.isEmpty}");
                          EasyLoading.dismiss(animation: false);
                          // 为空不存在及新增，反之去old user页面
                          if(checkingUser.length <= 0) {
                            logic.updateState(true);
                          }
                          else {
                            // user selection展示页面
                            if(isFlow == "checkIn") {
                              await Get.to(() => UserSelectionPage(), arguments: {
                                "showInfo": showInfo,
                                "bookingState": bookingState,
                                "isAddPlayerClick": true,
                                "tableId": tableId,
                                "checkingUser": checkingUser,
                                "isFlow": isFlow,
                              });
                            }
                            else if(isFlow == "tableCheck") {
                              await Get.to(() => UserSelectionPage(), arguments: {
                                "bookingState": bookingState,
                                "isAddPlayerClick": true,
                                "tableId": tableId,
                                "checkingUser": checkingUser,
                                "showState": showState,
                                "isFlow": isFlow,
                              });
                            }
                            // print("参数 ${checkingUser['userId']}");
                            // try {
                            //   EasyLoading.dismiss(animation: false);
                            //   Map singlePlayer = await logic.fetchSingleUsers(checkingUser['userId']);
                            //   print("singlePlayer ${singlePlayer}");
                            //   // old user展示页面
                            //   if(isFlow == "checkIn") {
                            //     await Get.to(() => OldUserPage(), arguments: {
                            //       "showInfo": showInfo,
                            //       "bookingState": bookingState,
                            //       "isAddPlayerClick": true,
                            //       "tableId": tableId,
                            //       "singlePlayer": singlePlayer,
                            //       "isFlow": isFlow,
                            //     });
                            //   }
                            //   else if(isFlow == "tableCheck") {
                            //     await Get.to(() => OldUserPage(), arguments: {
                            //       "bookingState": bookingState,
                            //       "isAddPlayerClick": true,
                            //       "tableId": tableId,
                            //       "singlePlayer": singlePlayer,
                            //       "showState": showState,
                            //       "isFlow": isFlow,
                            //     });
                            //   }
                            // } on DioException catch (e) {
                            //   EasyLoading.dismiss();
                            //   if (e.response == null) EasyLoading.showError("Network Error!");
                            //   EasyLoading.showError(e.response?.data["error"]["message"]);
                            // }
                          }
                        } on DioException catch (e) {
                          EasyLoading.dismiss();
                          if (e.response == null) EasyLoading.showError("Network Error!");
                          EasyLoading.showError(e.response?.data["error"]["message"]);
                        }
                      },
                      changedBgColor: Color(0xffA4EDF1),
                    ),
                    if(logic.isExist.value) CommonButton(
                      width: 340.w,
                      height: 70.h,
                      btnText: 'RESIGN',
                      btnBgColor: Color(0xff13EFEF),
                      textColor: Colors.black,
                      onPress: () async {
                        logic.updateState(false);
                      },
                      changedBgColor: Color(0xffA4EDF1),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
    return content;
  }
}