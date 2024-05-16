import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../mirra_style.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HeadgearFlipCard extends StatefulWidget {
  const HeadgearFlipCard(
      {Key? key,
      required this.width,
      required this.tableId,
      required this.url,
      required this.level,
      this.bSelected,
      this.delay})
      : super(key: key);
  final double width;
  final int tableId;
  final String url;
  final int level;
  final bool? bSelected;
  final Duration? delay;
  @override
  State<HeadgearFlipCard> createState() => _HeadgearFlipCardState();
}

class _HeadgearFlipCardState extends State<HeadgearFlipCard> {
  double get width => widget.width;
  late final controller = FlipCardController();
  Color get labelColor {
    if (widget.bSelected ?? false) return const Color(0xFF13EFEF);
    if (widget.tableId == 1) {
      return const Color(0xFFE6BC9C);
    } else if (widget.tableId == 2) {
      return const Color(0xFFE8B6E0);
    } else if (widget.tableId == 3) {
      return const Color(0xFFBCDBBC);
    } else {
      return const Color(0xFFC5D4E6);
    }
  }

  Color get backgroundColor {
    if (widget.bSelected ?? false) return const Color(0xff13EFEF);
    if (widget.tableId == 1) {
      return const Color(0xFFCB8C5E);
    } else if (widget.tableId == 2) {
      return const Color(0xFFBB7EB1);
    } else if (widget.tableId == 3) {
      return const Color(0xFF81AE81);
    } else {
      return const Color(0xFF85AEDE);
    }
  }

  @override
  void initState() {
    Future.wait([
      DefaultCacheManager().downloadFile(widget.url),
      Future.delayed(widget.delay ?? 0.ms),
    ]).then((value) => controller.toggleCard());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stars = <Widget>[];
    for (int i = 0; i < widget.level; i++) {
      stars.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Image.asset(
            MirraIcons.getSetAvatarIconPath('level_star_icon.png'),
            fit: BoxFit.fitWidth,
            width: 35.w,
          ),
        ),
      );
    }
    return FlipCard(
      flipOnTouch: false,
      controller: controller,
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.BACK,
      front: Container(
        decoration: BoxDecoration(
          color: labelColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: width * 1.05,
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
              child: CachedNetworkImage(
                fadeInDuration: 0.ms,
                imageUrl: widget.url,
                width: width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 4,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.w, bottom: 18.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: stars,
              ),
            ),
          ],
        ),
      ),
      back: Image.asset(
        MirraIcons.getSetAvatarIconPath('pageage_icon.png'),
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
