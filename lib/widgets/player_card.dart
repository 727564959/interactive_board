import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/mirra_style.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    Key? key,
    required this.avatarUrl,
    required this.nickname,
    required this.width,
    this.position,
    this.labelColor,
  }) : super(key: key);
  final String avatarUrl;
  final String nickname;
  final double width;
  final int? position;
  final Color? labelColor;
  @override
  Widget build(BuildContext context) {
    return AvatarCard(
      labelColor: labelColor ?? const Color(0xfff0f0f0),
      title: nickname,
      subTitle: position == null ? null : Global.getDeviceName(position!),
      width: width,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: CachedNetworkImage(
          fadeInDuration: 0.ms,
          imageUrl: avatarUrl,
          height: width,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class AvatarCard extends StatelessWidget {
  const AvatarCard(
      {Key? key,
      required this.child,
      required this.labelColor,
      required this.title,
      this.subTitle,
      required this.width})
      : super(key: key);
  final Widget child;
  final Color labelColor;
  final String title;
  final String? subTitle;
  final double width;
  @override
  Widget build(BuildContext context) {
    late final Widget bottomLabel;
    if (subTitle == null) {
      bottomLabel = Padding(
        padding: EdgeInsets.only(top: 7.w, bottom: 15.w),
        child: Text(
          title,
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
            title,
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
              subTitle!,
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
        color: labelColor,
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
                  child,
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
