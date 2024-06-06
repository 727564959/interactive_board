import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../mirra_style.dart';

class CommonTextButton extends StatefulWidget {
  const CommonTextButton({
    Key? key,
    required this.btnText,
    required this.textColor,
    required this.onPress,
    this.disable = false,
    this.changedTextColor,
  }) : super(key: key);
  final String btnText;
  final Color textColor;
  final void Function() onPress;
  final bool disable;
  final Color? changedTextColor;

  @override
  _CommonTextButtonState createState() => _CommonTextButtonState();
}

class _CommonTextButtonState extends State<CommonTextButton> {
  String get btnText => widget.btnText;
  Color get textColor => widget.textColor;
  bool get disable => widget.disable;
  Color? get changedTextColor => widget.changedTextColor;

  bool isChangeBgColor = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      // onTapUp: (detail) => disable ? null : widget.onPress(),
      onTapUp: (details) {
        if (!disable!) {
          // 手指抬起时的处理逻辑
          print('onTapUp');
          setState(() {
            isChangeBgColor = false;
          });
          widget.onPress();
          // Future.delayed(0.5.seconds).then((value) async {});
        }
      },
      onTapDown: (details) {
        if (!disable!) {
          // 手指按下时的处理逻辑
          print('onTapDown');
          setState(() {
            isChangeBgColor = true;
          });
        }
      },
      onTapCancel: () {
        if (!disable!) {
          // 手指离开区域的处理逻辑
          print('onTapCancel');
          setState(() {
            isChangeBgColor = !isChangeBgColor;
          });
        }
      },
      child: Text(
        btnText,
        style: CustomTextStyles.button(
            color: disable!
                    ? Color(0xFF9B9B9B)
                    : (!isChangeBgColor! ? textColor! : changedTextColor!),
                  fontSize: 28.sp),
      ),
    );
  }
}