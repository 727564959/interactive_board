import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common.dart';
import '../../../mirra_style.dart';
import '../../../widgets/player_card.dart';

String getDeviceId(int position) {
  final char = ascii.decode([0x40 + (position + 1) ~/ 2]);
  return "$char${(position + 1) % 2 + 1}";
}

class MaskPlayerCard extends StatelessWidget {
  const MaskPlayerCard({
    super.key,
    required this.avatarUrl,
    required this.nickname,
    required this.width,
    required this.position,
    required this.bFinish,
  });
  final String avatarUrl;
  final String nickname;
  final double width;
  final int position;
  final bool bFinish;
  int get tableId => (position + 1) ~/ 2;
  @override
  Widget build(BuildContext context) {
    return bFinish
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    MirraIcons.getGameShowIconPath("avatar_placeholder$tableId.png"),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  CachedNetworkImage(
                    fadeInDuration: 0.ms,
                    imageUrl: avatarUrl,
                    height: width * 0.9,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                      nickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.title5(
                        color: Colors.black,
                        fontSize: 32.sp,
                      ),
                    ),
                  ),
                  Text(
                    getDeviceId(position),
                    style: CustomTextStyles.display3(
                      color: Colors.black,
                      fontSize: 60.sp,
                    ),
                  ),
                  SizedBox(
                    height: 25.w,
                  )
                ],
              ),
            ),
          )
        : AvatarCard(
            title: nickname,
            subTitle: Global.getDeviceName(position),
            width: width,
            tableId: tableId,
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
