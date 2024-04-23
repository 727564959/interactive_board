import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../mirra_style.dart';
import '../../../common.dart';

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.disable = false,
  }) : super(key: key);
  final String title;
  final void Function() onPress;
  final bool disable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (detail) => disable ? null : onPress(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 80),
        decoration: BoxDecoration(
          color: disable ? Color(0xFF9B9B9B) : Color(0xFF13EFEF),
          borderRadius: const BorderRadius.all(Radius.circular(26.5)),
        ),
        child: Text(
          title,
          style: CustomTextStyles.button(color: Colors.black, fontSize: 28.sp),
        ),
      ),
    );
  }
}
