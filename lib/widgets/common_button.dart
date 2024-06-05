import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../mirra_style.dart';

// class CommonButton extends StatelessWidget {
class CommonButton extends StatefulWidget {
  const CommonButton({
    Key? key,
    required this.width,
    required this.height,
    required this.btnText,
    this.btnBgColor,
    required this.textColor,
    required this.onPress,
    this.disable = false,
    this.borderColor,
    // this.isChangeBgColor = false,
    this.changedBgColor,
    this.changedBorderColor,
    this.changedTextColor,
  }) : super(key: key);
  final double width;
  final double height;
  final String btnText;
  final Color? btnBgColor;
  final Color textColor;
  final void Function() onPress;
  final bool disable;
  final Color? borderColor;
  // final bool isChangeBgColor;
  final Color? changedBgColor;
  final Color? changedBorderColor;
  final Color? changedTextColor;

  @override
  _CommonButtonState createState() => _CommonButtonState();

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     // 点击事件
  //     // onTapUp: (detail) => disable ? null : onPress(),
  //     onTapUp: (details) {
  //       if (disable == null || !disable!) {
  //         onPress();
  //       }
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         // color: disable ? Color(0xFF9B9B9B) : Color(0xFF13EFEF),
  //         color: disable!
  //             ? Color(0xFF9B9B9B)
  //             : (!isChangeBgColor!
  //             ? btnBgColor : changedBgColor!),
  //         border: borderColor != null ? new Border.all(color: borderColor!, width: 1) : null,
  //         borderRadius: BorderRadius.all(Radius.circular(50)),
  //       ),
  //       constraints: BoxConstraints.tightFor(width: width, height: height),
  //       child: Center(
  //         child: Text(
  //           btnText,
  //           textAlign: TextAlign.center,
  //           style: CustomTextStyles.button(color: textColor, fontSize: 28.sp),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class _CommonButtonState extends State<CommonButton> {
  double get width => widget.width;
  double get height => widget.height;
  String get btnText => widget.btnText;
  Color? get btnBgColor => widget.btnBgColor;
  Color get textColor => widget.textColor;
  bool get disable => widget.disable;
  Color? get borderColor => widget.borderColor;
  // bool get isChangeBgColor => widget.isChangeBgColor;
  Color? get changedBgColor => widget.changedBgColor;
  Color? get changedBorderColor => widget.changedBorderColor;
  Color? get changedTextColor => widget.changedTextColor;

  bool isChangeBgColor = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      // onTapUp: (detail) => disable ? null : widget.onPress(),
      onTapUp: (details) {
        if (!disable!) {
          setState(() {
            isChangeBgColor = false;
          });
          widget.onPress();
          // Future.delayed(0.5.seconds).then((value) async {});
        }
      },
      onTapDown: (details) {
        setState(() {
          isChangeBgColor = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          // color: disable ? Color(0xFF9B9B9B) : Color(0xFF13EFEF),
          color: disable! ? Color(0xFF9B9B9B)
                  : (btnBgColor != null ? (!isChangeBgColor! ? btnBgColor! : changedBgColor!) : null),
          border: borderColor != null ? new Border.all(color: !isChangeBgColor! ? borderColor! : changedBorderColor!, width: 1) : null,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        constraints: BoxConstraints.tightFor(width: width, height: height),
        child: Center(
          child: Text(
            btnText,
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: !isChangeBgColor! ? textColor : (changedTextColor == null ? textColor : changedTextColor!), fontSize: 28.sp),),
        ),
      ),
    );
  }
}