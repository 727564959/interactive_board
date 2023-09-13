import 'package:flutter/material.dart';
import 'package:get/get.dart' hide AnimationExtension;
import 'package:interactive_board/common.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:interactive_board/pages/choose_player/logic.dart';
import '../../../data/model/player.dart';
import '../../../widgets/hexagon_avatar.dart';

class TargetItem extends StatefulWidget {
  const TargetItem({
    Key? key,
    required this.width,
    required this.deviceId,
    required this.index,
  }) : super(key: key);
  final double width;
  final String deviceId;
  final int index;
  @override
  State<TargetItem> createState() => _TargetItemState();
}

class _TargetItemState extends State<TargetItem> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final logic = Get.find<ChoosePlayerLogic>();
  int get index => widget.index;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.width * 1.45;
    return DragTarget<PlayerInfo>(
      onWillAccept: (data) {
        controller.forward();
        return true;
      },
      onLeave: (data) {
        controller.reverse();
      },
      onAccept: (data) {
        logic.choosePosition(index, data.username);
      },
      builder: (context, candidateData, rejectedData) {
        final player = logic.selectedPlayers[index];
        if (player == null) {
          return _NullTargetItem(
            width: widget.width,
            height: height,
            deviceId: widget.deviceId,
            controller: controller,
          );
        } else {
          return _PlayerTargetItem(
            width: widget.width,
            height: height,
            deviceId: widget.deviceId,
            nickname: player.nickname,
            avatarUrl: player.avatarUrl,
          );
        }
      },
    );
  }
}

class _PlayerTargetItem extends StatelessWidget {
  const _PlayerTargetItem({
    Key? key,
    required this.deviceId,
    required this.width,
    required this.height,
    required this.avatarUrl,
    required this.nickname,
  }) : super(key: key);
  final String deviceId;
  final double width;
  final double height;
  final String avatarUrl;
  final String nickname;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          HexagonAvatar(
            width: width,
            avatarUrl: avatarUrl,
            tag: nickname,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: width * 0.43,
              height: height * 0.17,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Global.getAssetImageUrl("avatar/vr_icon.png")),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Text(
                    deviceId,
                    style: Global.getNormalTextStyle(width * 0.11),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NullTargetItem extends StatelessWidget {
  const _NullTargetItem({
    Key? key,
    required this.deviceId,
    required this.width,
    required this.height,
    required this.controller,
  }) : super(key: key);
  final String deviceId;
  final double width;
  final double height;
  final AnimationController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          SizedBox(
            width: width,
            child: Image.asset(
              Global.getAssetImageUrl('avatar/no_one.png'),
              fit: BoxFit.fitWidth,
            ),
          ).animate(autoPlay: false, controller: controller).scale(
                duration: 100.ms,
                // curve: Curves.decelerate,
                begin: const Offset(1.0, 1.0),
                end: const Offset(0.7, 0.7),
              ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: width * 0.43,
              height: height * 0.17,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Global.getAssetImageUrl("avatar/vr_icon.png")),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Text(
                    deviceId,
                    style: Global.getNormalTextStyle(width * 0.11),
                  ),
                ),
              ).animate(autoPlay: false, controller: controller).scale(
                    duration: 100.ms,
                    // curve: Curves.decelerate,
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
