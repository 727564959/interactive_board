import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_board/mirra_style.dart';

String getDeviceName(int position) {
  final char = ascii.decode([0x40 + (position + 1) ~/ 2]);
  return "Device $char${(position + 1) % 2 + 1}";
}

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    Key? key,
    required this.avatarUrl,
    required this.nickname,
    required this.width,
    this.position,
  }) : super(key: key);
  final String? avatarUrl;
  final String nickname;
  final double width;
  final int? position;
  @override
  Widget build(BuildContext context) {
    late final Widget avatarImage;
    late final Widget bottomLabel;
    if (avatarUrl == null) {
      avatarImage = SizedBox(
        width: width,
        height: width,
        child: Image.asset(
          MirraIcons.getGameShowIconPath("avatar_placeholder1.png"),
          fit: BoxFit.fill,
        ),
      );
    } else {
      avatarImage = _PlayerAvatar(avatarUrl: avatarUrl!, width: width);
    }
    if (position == null) {
      bottomLabel = Padding(
        padding: EdgeInsets.only(top: 7.w, bottom: 15.w),
        child: Text(
          nickname,
          style: CustomTextStyles.title5(
            color: Colors.black,
            fontSize: 32.sp,
          ),
        ),
      );
    } else {
      bottomLabel = Padding(
        padding: EdgeInsets.only(top: 7.w, bottom: 10.w),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            nickname,
            style: CustomTextStyles.title5(
              color: Colors.black,
              fontSize: 32.sp,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -5),
            child: Text(
              getDeviceName(position!),
              style: CustomTextStyles.title6(
                color: const Color(0xff5a5858),
                fontSize: 23.sp,
              ),
            ),
          ),
        ]),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        color: const Color(0xfff0f0f0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            avatarImage,
            bottomLabel,
          ],
        ),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  const _PlayerAvatar({
    Key? key,
    required this.avatarUrl,
    required this.width,
  }) : super(key: key);
  final String avatarUrl;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: width,
            child: Image.asset(
              MirraIcons.getGameShowIconPath("player_card_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.network(
              avatarUrl,
              width: width,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
