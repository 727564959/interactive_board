import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mirra_style.dart';

import 'package:audioplayers/audioplayers.dart';

class CommonIconButton extends StatefulWidget {
  const CommonIconButton({
    Key? key,
    required this.onPress,
    this.disable = false,
  }) : super(key: key);
  final void Function() onPress;
  final bool disable;

  @override
  _CommonIconButtonState createState() => _CommonIconButtonState();
}

class _CommonIconButtonState extends State<CommonIconButton> {
  bool get disable => widget.disable;

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
      child: Image.asset(
        !isChangeBgColor!
            ? MirraIcons.getSetAvatarIconPath("back_icon_default.png")
            : MirraIcons.getSetAvatarIconPath("back_icon_select.png"),
        width: 48,
        height: 48,
      ),
    );
  }
}