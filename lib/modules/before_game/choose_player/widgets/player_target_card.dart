import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import '../data/player.dart';
import '../logic.dart';
import '../../../../widgets/player_card.dart';
import '../../../../mirra_style.dart';

class PlayerTargetCard extends StatefulWidget {
  const PlayerTargetCard({Key? key, required this.position}) : super(key: key);
  final int position;
  @override
  State<PlayerTargetCard> createState() => _PlayerTargetCardState();
}

class _PlayerTargetCardState extends State<PlayerTargetCard> with SingleTickerProviderStateMixin {
  // late final AnimationController controller = AnimationController(vsync: this, duration: 300.ms);
  final logic = Get.find<ChoosePlayerLogic>();
  int get position => widget.position;
  double get width => 270.w;
  PlayerInfo? get player => logic.optionalPositions[position];
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
          title: "Player name",
          subTitle: Global.getDeviceName(position),
          width: width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  MirraIcons.getGameShowIconPath("player_add${Global.tableId}.png"),
                  width: 50.w,
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
