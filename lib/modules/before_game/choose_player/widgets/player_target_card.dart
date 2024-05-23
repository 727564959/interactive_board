import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:interactive_board/common.dart';
import '../data/player.dart';
import '../logic.dart';
import '../../../../widgets/player_card.dart';
import '../../../../mirra_style.dart';

class PlayerTargetCard extends StatefulWidget {
  const PlayerTargetCard({Key? key, required this.position, this.delay}) : super(key: key);
  final int position;
  final Duration? delay;
  @override
  State<PlayerTargetCard> createState() => _PlayerTargetCardState();
}

class _PlayerTargetCardState extends State<PlayerTargetCard> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(value: 1.0, vsync: this, duration: 200.ms);
  late final GifController gifController = GifController(autoPlay: false, loop: false);
  late final Timer timer;

  final logic = Get.find<ChoosePlayerLogic>();

  int get position => widget.position;
  double get width => 270.w;
  PlayerInfo? get player => logic.optionalPositions[position];
  Duration get delay => widget.delay ?? 200.ms;
  Duration get periodicTime => 1200.ms;

  @override
  void initState() {
    Future.delayed(delay).then((value) {
      controller.forward().then((value) => controller.reverse());
      timer = Timer.periodic(periodicTime, (timer) async {
        if (player == null && position != logic.selectedPosition) {
          gifController.play();
          await controller.forward();
          await controller.reverse();
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    gifController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration? duration;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GestureDetector(
        onTapUp: (details) {
          logic.showBottomBar(position);
        },
        onPanStart: (detail) {
          duration = detail.sourceTimeStamp;
        },
        onPanUpdate: (detail) {
          if (duration != null && detail.sourceTimeStamp != null) {
            final tapSpace = detail.sourceTimeStamp! - duration!;
            if (tapSpace > 300.ms) return;
          }
          if (detail.delta.dy < -10 && detail.delta.dx.abs() < 5) {
            logic.removePlayer(position);
          }
        },
        child: AvatarCard(
          labelColor: const Color(0xfff0f0f0),
          title: player?.nickname ?? "Player name",
          subTitle: Global.getDeviceName(position),
          width: width,
          child: Stack(
            children: [
              if (player == null)
                Align(
                  alignment: Alignment.center,
                  child: GifView.asset(
                    MirraIcons.getGifPath("add_player.gif"),
                    fadeDuration: 0.ms,
                    width: 100.w,
                    fit: BoxFit.fitWidth,
                    frameRate: 60,
                    controller: gifController,
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
            ],
          ),
        ),
      ),
    ).animate(autoPlay: false, controller: controller).moveY(curve: Curves.easeOut, end: -20);
  }
}
