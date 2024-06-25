import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../mirra_style.dart';

import 'package:audioplayers/audioplayers.dart';

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

  // 创建音频播放器实例
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      // onTapUp: (detail) => disable ? null : widget.onPress(),
      onTapUp: (details) async {
        if (!disable!) {
          // 手指抬起时的处理逻辑
          print('onTapUp');
          setState(() {
            isChangeBgColor = false;
          });
          widget.onPress();
          // Future.delayed(0.5.seconds).then((value) async {});
        }
        await audioPlayer.release;
      },
      onTapDown: (details) async {
        if (!disable!) {
          // 手指按下时的处理逻辑
          print('onTapDown');
          setState(() {
            isChangeBgColor = true;
          });
        }
        // await audioPlayer.setVolume(2.0);
        await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("normal_click.wav")));
      },
      onTapCancel: () async {
        if (!disable!) {
          // 手指离开区域的处理逻辑
          print('onTapCancel');
          setState(() {
            isChangeBgColor = !isChangeBgColor;
          });
        }
        await audioPlayer.release;
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