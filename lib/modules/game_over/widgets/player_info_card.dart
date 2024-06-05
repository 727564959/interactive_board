import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/mirra_style.dart';

class PlayerInfoCard extends StatelessWidget {
  const PlayerInfoCard({
    Key? key,
    required this.avatarUrl,
    required this.nickname,
    required this.width,
    this.position,
  }) : super(key: key);
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
      child: CachedNetworkImage(
        fadeInDuration: 0.ms,
        imageUrl: avatarUrl,
        width: width,
        fit: BoxFit.fitWidth,
      ),
      // child: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: CachedNetworkImage(
      //     fadeInDuration: 0.ms,
      //     imageUrl: avatarUrl,
      //     // width: width,
      //     // fit: BoxFit.fitWidth,
      //     height: width,
      //     fit: BoxFit.fitHeight,
      //   ),
      // ),
    );
  }
}

class AvatarCard extends StatefulWidget {
  const AvatarCard({Key? key, required this.child, required this.title, this.subTitle, required this.width})
      : super(key: key);
  final Widget child;
  Color get labelColor {
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

  final String title;
  final String? subTitle;
  final double width;

  @override
  State<AvatarCard> createState() => _AvatarCardState();

  // @override
  // Widget build(BuildContext context) {
  //   late final Widget bottomLabel;
  //   if (subTitle == null) {
  //     bottomLabel = Padding(
  //       padding: EdgeInsets.only(top: 7.w, bottom: 15.w),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Text(
  //           title,
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //           style: CustomTextStyles.title5(
  //             color: Colors.black,
  //             fontSize: 32.sp,
  //           ),
  //         ),
  //       ),
  //     );
  //   } else {
  //     bottomLabel = Padding(
  //       padding: EdgeInsets.only(top: 7.w, bottom: 10.w),
  //       child: Column(mainAxisSize: MainAxisSize.min, children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 10),
  //           child: Text(
  //             title,
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //             style: CustomTextStyles.title5(
  //               color: Colors.black,
  //               fontSize: 30.sp,
  //             ),
  //           ),
  //         ),
  //         Transform.translate(
  //           offset: const Offset(0, -5),
  //           child: Text(
  //             subTitle!,
  //             style: CustomTextStyles.title6(
  //               color: const Color(0xff5a5858),
  //               fontSize: 23.sp,
  //             ),
  //           ),
  //         ),
  //       ]),
  //     );
  //   }
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: Container(
  //       width: width,
  //       height: width * 1.4,
  //       color: labelColor,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           SizedBox(
  //             width: width,
  //             height: width,
  //             child: Stack(
  //               children: [
  //                 SizedBox(
  //                   width: width,
  //                   height: width,
  //                   child: Image.asset(
  //                     MirraIcons.getGameShowIconPath("avatar_placeholder${Global.tableId}.png"),
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //                 child,
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 1.5,
  //             color: Colors.white,
  //           ),
  //           bottomLabel,
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class _AvatarCardState extends State<AvatarCard> {
  double get width => widget.width;
  Widget get child => widget.child;
  String get title => widget.title;
  String? get subTitle => widget.subTitle;
  late final controller = FlipCardController();
  Color get color {
    if (Global.tableId == 1) {
      // background: #FFBD80;
      return const Color(0xFFFFBD80);
    } else if (Global.tableId == 2) {
      // background: #EFB5FD;
      return const Color(0xFFEFB5FD);
    } else if (Global.tableId == 3) {
      // background: #8EE8BD;
      return const Color(0xFF8EE8BD);
    } else {
      // background: #9ED7F7;
      return const Color(0xFF9ED7F7);
    }
  }
  Color get labelColor {
    if (Global.tableId == 1) {
      return const Color(0xFFE6BC9C);
    } else if (Global.tableId == 2) {
      return const Color(0xFFE8B6E0);
    } else if (Global.tableId == 3) {
      return const Color(0xFFBCDBBC);
    } else {
      return const Color(0xFFC5D4E6);
    }
  }

  Color get backgroundColor {
    if (Global.tableId == 1) {
      return const Color(0xFFCB8C5E);
    } else if (Global.tableId == 2) {
      return const Color(0xFFBB7EB1);
    } else if (Global.tableId == 3) {
      return const Color(0xFF81AE81);
    } else {
      return const Color(0xFF85AEDE);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        padding: EdgeInsets.only(top: 7.w, bottom: 10.w),
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
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: width * 1.35,
              decoration: BoxDecoration(
                // color: backgroundColor,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.5,
                  colors: [
                    labelColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
                    backgroundColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: child,
            ),
            Container(
              height: 4,
              color: Colors.white,
            ),
            bottomLabel,
          ],
        ),
      ),
    );
  }
}
