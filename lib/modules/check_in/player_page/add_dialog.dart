import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../terms_page/view.dart';

class AddDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.sw,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: Color(0xFF272727),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Other Members',
            textAlign: TextAlign.center,
            style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
          ),
          SizedBox(height: 50,),
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
  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 0.8.sw), //卡片大小
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
                    _NoThatAllBtn(width: 340.w),
                    SizedBox(width: 10,),
                    _AddNowBtn(width: 340.w),
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
        margin: EdgeInsets.only(top: 0.0, left: 30.0),
        constraints: BoxConstraints.tightFor(width: width, height: 70.h), //卡片大小
        child: Center(
          child: Text(
            "No, that' all",
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
        margin: EdgeInsets.only(top: 0.0, left: 30.0),
        constraints: BoxConstraints.tightFor(width: width, height: 70.h), //卡片大小
        child: Center(
          child: Text(
            "Add Now",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}