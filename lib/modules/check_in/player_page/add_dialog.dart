import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../terms_page/view.dart';

class AddDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 20,),
          Text(
            'Assemble the Squad.',
            textAlign: TextAlign.center,
            style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          ),
          SizedBox(height: 10,),
          Text(
            'Anyone Else Needing to Join?',
            textAlign: TextAlign.center,
            style: CustomTextStyles.notice(color: Colors.white, fontSize: 24.sp),
          ),
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
  const _BottomBtns({
    Key? key,
  }) : super(key: key);
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  int get tableId => Get.arguments["tableId"];

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
                      btnText: "NO, THAT'S ALL",
                      btnBgColor: Color(0xFF272727),
                      textColor: Color(0xff13EFEF),
                      onPress: () async {
                        Get.back();
                      },
                      borderColor: Color(0xff13EFEF),
                      changedBorderColor: Color(0xffA4EDF1),
                      changedTextColor: Color(0xffA4EDF1),
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
                        await Get.to(() => TermsOfUsePage(),
                            arguments: {
                              "isAddPlayerClick": true,
                              "showInfo": showInfo,
                              "customer": customer,
                              "tableId": tableId,
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

class _AddNowBtn extends StatelessWidget {
  _AddNowBtn({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        await Get.to(() => TermsOfUsePage(),
            arguments: {
              "isAddPlayerClick": true,
              "showInfo": showInfo,
              "customer": customer,
              "tableId": tableId,
            });
      },
      child: Container(
        decoration: BoxDecoration(
          //设置边框
          color: Color(0xFF13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 70.h), //卡片大小
        child: Center(
          child: Text(
            "ADD NOW",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}