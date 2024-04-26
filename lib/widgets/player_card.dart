import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    this.bMask = false,
  }) : super(key: key);
  final String? avatarUrl;
  final String nickname;
  final double width;
  final int? position;
  final bool bMask;
  @override
  Widget build(BuildContext context) {
    late final Widget bottomLabel;
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.title5(
              color: Colors.black,
              fontSize: 30.sp,
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
            SizedBox(
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
                  if (avatarUrl != null)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CachedNetworkImage(
                        fadeInDuration: 0.ms,
                        imageUrl: avatarUrl!,
                        height: width,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  if (avatarUrl == null)
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        MirraIcons.getGameShowIconPath("player_add1.png"),
                        width: 50.w,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  if (bMask)
                    Container(
                      width: width,
                      height: width,
                      color: const Color(0x907B7B7B),
                    )
                ],
              ),
            ),
            bottomLabel,
          ],
        ),
      ),
    );
  }
}
