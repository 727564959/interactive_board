import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/mirra_style.dart';

class PlayerBayCard extends StatelessWidget {
  const PlayerBayCard({
    Key? key,
    required this.avatarUrl,
    required this.nickname,
    required this.width,
    this.position,
    this.bayNum,
  }) : super(key: key);
  final String avatarUrl;
  final String nickname;
  final double width;
  final int? position;
  final int? bayNum;

  @override
  Widget build(BuildContext context) {
    return AvatarCard(
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
      bayNum: bayNum,
    );
  }
}

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.child, required this.title, this.subTitle, required this.width, this.bayNum})
      : super(key: key);
  final Widget child;
  final int? bayNum;
  Color get labelColor {
    if(bayNum != null) {
      if (bayNum == 1) {
        return const Color(0xFFFFBD80);
      } else if (bayNum == 2) {
        return const Color(0xFFEFB5FD);
      } else if (bayNum == 3) {
        return const Color(0xFF8EE8BD);
      } else {
        return const Color(0xFF9ED7F7);
      }
    }
    else {
      if (Global.tableId == 1) {
        return const Color(0xFFFFBD80);
      } else if (Global.tableId == 2) {
        return const Color(0xFFEFB5FD);
      } else if (Global.tableId == 3) {
        return const Color(0xFF8EE8BD);
      } else {
        return const Color(0xFF9ED7F7);
      }
    }
  }

  final String title;
  final String? subTitle;
  final double width;
  @override
  Widget build(BuildContext context) {
    late final Widget bottomLabel;
    if (subTitle == null) {
      bottomLabel = Padding(
        padding: EdgeInsets.only(top: 7.w, bottom: 15.w),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.title5(
              color: Colors.black,
              fontSize: 32.sp,
            ),
          ),
        ),
      );
    } else {
      bottomLabel = Padding(
        padding: EdgeInsets.only(top: 15.w, bottom: 15.w),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.title5(
                color: Colors.black,
                fontSize: 30.sp,
              ),
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
                      MirraIcons.getGameShowIconPath("avatar_placeholder${bayNum != null ? bayNum : Global.tableId}.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child,
                ],
              ),
            ),
            Container(
              height: 1.5,
              color: Colors.white,
            ),
            bottomLabel,
          ],
        ),
      ),
    );
  }
}
