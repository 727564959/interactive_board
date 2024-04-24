import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../before_checkIn/term_of_use.dart';

class HintDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.5.sw,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Save Your Progress!',
              textAlign: TextAlign.center,
              style: CustomTextStyles.notice(color: Colors.black, fontSize: 48.sp),
            ),
            SizedBox(height: 50,),
            Text(
              'Want to keep your avatar and achievements?',
              textAlign: TextAlign.center,
              style: CustomTextStyles.notice(color: Colors.black, fontSize: 30.sp),
            ),
            SizedBox(height: 10,),
            Text(
              'Sign up for a free account and never lose them!',
              textAlign: TextAlign.center,
              style: CustomTextStyles.notice(color: Colors.black, fontSize: 30.sp),
            ),
            SizedBox(height: 50,),
            _BottomBtns(),
          ],
        ),
    );
    // return AlertDialog(
    //   backgroundColor: Colors.yellow, // 设置背景颜色为黄色
    //   contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
    //   title: Text('Save Your Progress!'),
    //   content: Text('Want to keep your avatar and achievements? Sign up for a free account and never lose them!'),
    //   actions: [
    //     TextButton(
    //       child: Text('Cancel'),
    //       onPressed: () {
    //         // 取消按钮的操作逻辑
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //     ElevatedButton(
    //       child: Text('Sign Up'),
    //       onPressed: () {
    //         // Sign Up按钮的操作逻辑
    //         Navigator.of(context).pop();
    //         // 添加其他操作逻辑，比如导航到注册页面
    //       },
    //     ),
    //   ],
    // );
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
                    _MaybeLatterBtn(width: 300.w),
                    SizedBox(width: 10,),
                    _SignUpBtn(width: 300.w),
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

class _MaybeLatterBtn extends StatelessWidget {
  _MaybeLatterBtn({
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
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 30.0),
        constraints: BoxConstraints.tightFor(width: width, height: 80.h), //卡片大小
        child: Center(
          child: Text(
            "Maybe Latter",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}

class _SignUpBtn extends StatelessWidget {
  _SignUpBtn({
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
        Get.to(() => TermOfUsePage(), arguments: Get.arguments);
      },
      child: Container(
        decoration: BoxDecoration(
          //设置边框
          border: new Border.all(color: Color(0xff13EFEF), width: 1),
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 30.0),
        constraints: BoxConstraints.tightFor(width: width, height: 80.h), //卡片大小
        child: Center(
          child: Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff13EFEF), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}