import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../data/player.dart';
import '../logic.dart';
import '../../../../widgets/player_card.dart';
import '../../../../mirra_style.dart';

class FreeModeTargetCard extends StatefulWidget {
  const FreeModeTargetCard({super.key, required this.position, required this.bShowError});
  final int position;
  final bool bShowError;

  @override
  State<FreeModeTargetCard> createState() => _FreeModeTargetCardState();
}

class _FreeModeTargetCardState extends State<FreeModeTargetCard> with TickerProviderStateMixin {
  late final AnimationController tapController = AnimationController(value: 1.0, vsync: this, duration: 200.ms);
  final logic = Get.find<ChoosePlayerLogic>();

  int get position => widget.position;
  double get width => 270.w;
  PlayerInfo? get player => logic.optionalPositions[position];
  Duration get periodicTime => 1200.ms;
  bool bSwipeOver = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration? duration;
    return GestureDetector(
      onTapDown: (_) async {
        logic.cancelTimer();
        await tapController.reverse();
        await tapController.forward();
        try {
          await logic.showBottomBar(position);
        } on DioException {
          logic.showPlayerSelectException();
        }
      },
      onPanStart: (detail) {
        bSwipeOver = false;
        duration = detail.sourceTimeStamp;
      },
      onPanUpdate: (detail) async {
        if (player == null) return;
        if (bSwipeOver) return;
        if (duration != null && detail.sourceTimeStamp != null) {
          final tapSpace = detail.sourceTimeStamp! - duration!;
          if (tapSpace > 300.ms) return;
        }
        if (detail.delta.dy < -10 && detail.delta.dx.abs() < 5) {
          try {
            await logic.removePlayer(position);
          } on DioException {
            logic.showPlayerSelectException();
          }
          bSwipeOver = true;
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 7.w),
        child: AvatarCard(
          title: player?.nickname ?? "Player $position",
          width: width,
          tableId: player?.tableId,
          child: Stack(
            children: [
              if (player == null)
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    MirraIcons.getGameShowIconPath("add_player.png"),
                    width: 43.w,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              if (player != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CachedNetworkImage(
                    fadeInDuration: 0.ms,
                    fadeOutDuration: 0.ms,
                    imageUrl: player!.avatarUrl,
                    height: width,
                    fit: BoxFit.fitHeight,
                  ),
                ).animate().scaleXY(duration: 300.ms),
              if (widget.bShowError)
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    MirraIcons.getGameShowIconPath("player_selected_error.png"),
                    width: 100.w,
                  ),
                ),
            ],
          ),
        ).animate(autoPlay: false, controller: tapController).scaleXY(duration: 150.ms, begin: 0.9, end: 1.0),
      ),
    );
  }
}
