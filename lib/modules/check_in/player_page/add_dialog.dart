import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../../add_player/view.dart';
import '../add_player/view.dart';
import '../data/show.dart';
import '../home_page/booking_state.dart';
import '../terms_page/view.dart';
import 'logic.dart';

class AddDialog extends StatelessWidget {
  BookingState get bookingState => Get.arguments["bookingState"];
  final logic = Get.put(PlayerShowLogic());

  @override
  Widget build(BuildContext context) {
    print("logic.casualUser.length ${logic.casualUser.length}");
    print("bookingState.quantity ${bookingState.quantity}");
    return Container(
      width: 0.4.sw,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Text(
            'Add Other Members',
            textAlign: TextAlign.center,
            style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
          ),
          // if(logic.casualUser.length < bookingState.quantity) Text(
          //   'Add Other Members',
          //   textAlign: TextAlign.center,
          //   style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
          // ),
          // if(logic.casualUser.length >= bookingState.quantity) Text(
          //   'Guests Over Limit',
          //   textAlign: TextAlign.center,
          //   style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
          // ),
          SizedBox(height: 20,),
          Text(
            'Assemble the Squad.',
            textAlign: TextAlign.center,
            style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          ),
          // if(logic.casualUser.length < bookingState.quantity) Text(
          //   'Assemble the Squad.',
          //   textAlign: TextAlign.center,
          //   style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          // ),
          // if(logic.casualUser.length >= bookingState.quantity) Text(
          //   'Your reservation is for ' + bookingState.quantity.toString() + ' people.',
          //   textAlign: TextAlign.center,
          //   style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          // ),
          SizedBox(height: 10,),
          Text(
            'Anyone Else Needing to Join?',
            textAlign: TextAlign.center,
            style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          ),
          // if(logic.casualUser.length < bookingState.quantity) Text(
          //   'Anyone Else Needing to Join?',
          //   textAlign: TextAlign.center,
          //   style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          // ),
          // if(logic.casualUser.length >= bookingState.quantity) Text(
          //   'Please buy extra tickets if you have more guests.',
          //   textAlign: TextAlign.center,
          //   style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          // ),
          SizedBox(height: 30,),
          _BottomBtns(),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}

// 底部的功能按钮区域
class _BottomBtns extends StatelessWidget {
  _BottomBtns({
    Key? key,
  }) : super(key: key);
  ShowInfo get showInfo => Get.arguments["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  int get tableId => Get.arguments["tableId"];
  final logic = Get.put(PlayerShowLogic());

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
                    // _NoThatAllBtn(width: 340.w),
                    CommonButton(
                      width: 340.w,
                      height: 70.h,
                      // btnText: logic.casualUser.length < bookingState.quantity ? "NO, THAT'S ALL" : "CANCEL",
                      btnText: "NO, THAT'S ALL",
                      btnBgColor: Color(0xFF272727),
                      textColor: Color(0xff13EFEF),
                      onPress: () async {
                        // Get.back();
                        Navigator.of(context).pop();
                      },
                      borderColor: Color(0xff13EFEF),
                      changedBorderColor: Color(0xffA4EDF1),
                      changedTextColor: Color(0xffA4EDF1),
                      changedBgColor: Color(0xFF272727),
                    ),
                    SizedBox(width: 10,),
                    // _AddNowBtn(width: 340.w),
                    CommonButton(
                      width: 340.w,
                      height: 70.h,
                      btnText: 'ADD NOW',
                      btnBgColor: Color(0xff13EFEF),
                      textColor: Colors.black,
                      onPress: () async {
                        // await Get.to(() => TermsOfUsePage(),
                        //     arguments: {
                        //       "isAddPlayerClick": true,
                        //       "showInfo": showInfo,
                        //       "customer": customer,
                        //       "tableId": tableId,
                        //     });
                        // await Get.to(() => AddPlayerPage(),
                        //     arguments: {
                        //       "showInfo": showInfo,
                        //       "bookingState": bookingState,
                        //       "isAddPlayerClick": true,
                        //       "tableId": tableId,
                        //       "isFlow": "checkIn",
                        //     });
                        await Get.offAll(() => UserAuthenticator(),
                            arguments: {
                              "isAddPlayerClick": true,
                              "showInfo": showInfo,
                              "bookingState": bookingState,
                              "tableId": tableId,
                              "isFlow": "checkIn",
                            });
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

class _NoThatAllBtn extends StatelessWidget {
  _NoThatAllBtn({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          //设置边框
          border: new Border.all(color: Color(0xff13EFEF), width: 1),
          color: Color(0xFF272727),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 70.h), //卡片大小
        child: Center(
          child: Text(
            "NO, THAT'S ALL",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}