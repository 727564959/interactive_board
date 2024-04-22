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
  // final String? device;
  final double width;
  final int? position;
  @override
  Widget build(BuildContext context) {
    late final Widget avatarImage;
    if (avatarUrl == null) {
      avatarImage = SizedBox(
        width: width,
        height: width,
        child: Image.asset(
          MirraIcons.getChooseTableIconPath("avatar_placeholder1.png"),
          fit: BoxFit.fill,
        ),
      );
    } else {
      avatarImage = _PlayerAvatar(avatarUrl: avatarUrl!, width: width);
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
            const SizedBox(height: 5),
            Text(
              nickname,
              style: CustomTextStyles.title5(
                color: Colors.black,
                fontSize: 32.sp,
              ),
            ),
            if (position == null) const SizedBox(height: 5),
            if (position != null)
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
            if (position != null) const SizedBox(height: 3),
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
              MirraIcons.getChooseTableIconPath("player_card_bg.png"),
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
