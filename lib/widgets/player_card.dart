import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/mirra_style.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
    required this.avatarUrl,
    required this.nickname,
    required this.width,
    this.position,
  });
  final String avatarUrl;
  final String nickname;
  final double width;
  final int? position;

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
    );
  }
}

class AvatarCard extends StatelessWidget {
  const AvatarCard(
      {super.key, required this.child, required this.title, this.subTitle, required this.width, this.tableId});
  final Widget child;
  Color get labelColor {
    int tableId = this.tableId ?? Global.tableId;
    if (tableId == 1) {
      return const Color(0xFFFFBD80);
    } else if (tableId == 2) {
      return const Color(0xFFEFB5FD);
    } else if (tableId == 3) {
      return const Color(0xFF8EE8BD);
    } else {
      return const Color(0xFF9ED7F7);
    }
  }

  final String title;
  final String? subTitle;
  final double width;
  final int? tableId;
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
                      MirraIcons.getGameShowIconPath("avatar_placeholder${tableId ?? Global.tableId}.png"),
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
