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

class _TargetItemState extends State<TargetItem> with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController nullTargetController;
  late final AnimationController changeController;
  late final AnimationController changeController1;
  late final AnimationController selectedController;
  late final AnimationController tagController;
  final logic = Get.find<ChoosePlayerLogic>();
  int get index => widget.index;
  PlayerInfo? get player => logic.selectedPlayers[index];
  @override
  void initState() {
    super.initState();
    nullTargetController = AnimationController(vsync: this);
    selectedController = AnimationController(vsync: this);
    changeController = AnimationController(vsync: this);
    changeController1 = AnimationController(vsync: this);
    tagController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    nullTargetController.dispose();
    changeController.dispose();
    selectedController.dispose();
    tagController.dispose();
    changeController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    final height = widget.width * 1.5;

    return DragTarget<PlayerInfo>(
      onWillAccept: (data) {
        if (player == null) {
          nullTargetController.forward();
          tagController.reverse();
        } else {
          changeController.forward();
          changeController1.forward();
          tagController.reverse();
        }
        return true;
      },
      onLeave: (data) {
        if (player == data) {
          tagController.reset();
          tagController.forward();
          logic.removePlayer(index);
          nullTargetController.reverse();
          changeController.reset();
          changeController1.reset();
        } else if (player == null) {
          tagController.reset();
          tagController.forward();
          nullTargetController.reverse();
          tagController.forward();
          changeController.reset();
          changeController1.reset();
        } else {
          changeController.reverse();
          changeController1.reverse();
          tagController.forward();
        }
      },
      onAccept: (data) {
        if (player == null) {
          logic.choosePosition(index, data.username);
          selectedController.reset();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            selectedController.forward();
            tagController.forward();
          });
        } else {
          logic.choosePosition(index, data.username);
          selectedController.reset();
          changeController.reset();
          changeController1.reset();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            selectedController.forward();
            tagController.forward();
          });
        }
      },
      builder: (context, candidateData, rejectedData) {
        Widget content;
        final tagIcon = player == null ? "avatar/vr_icon.png" : "avatar/vr_icon_light.png";
        if (player == null) {
          content = _NullTargetItem(
            width: width,
            height: height,
          ).animate(autoPlay: false, controller: nullTargetController).scale(
                duration: 100.ms,
                // curve: Curves.decelerate,
                begin: const Offset(1.0, 1.0),
                end: const Offset(0.7, 0.7),
              );
        } else {
          content = Stack(
            children: [
              _NullTargetItem(
                width: width,
                height: height,
              ).animate(autoPlay: false, controller: changeController1).scale(
                    delay: 100.ms,
                    duration: 200.ms,
                    begin: const Offset(0, 0),
                    end: const Offset(0.7, 0.7),
                  ),
              _PlayerTargetItem(
                width: width,
                height: height,
                player: player!,
                index: index,
              )
                  .animate(autoPlay: false, controller: selectedController)
                  .scale(
                    duration: 500.ms,
                    curve: Curves.elasticOut,
                    begin: const Offset(0, 0),
                    end: const Offset(1.0, 1.0),
                  )
                  .animate(autoPlay: false, controller: changeController)
                  .scale(
                    duration: 100.ms,
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(0, 0),
                  ),
            ],
          );
        }
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              content,
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: width * 0.43,
                  height: height * 0.17,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Global.getAssetImageUrl(tagIcon)),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.deviceId,
                        style: Global.getNormalTextStyle(width * 0.11),
                      ),
                    ),
                  ).animate(autoPlay: false, controller: tagController, target: 1.0).scale(
                        duration: 100.ms,
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(1.0, 1.0),
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PlayerTargetItem extends StatelessWidget {
  _PlayerTargetItem({
    Key? key,
    required this.width,
    required this.height,
    required this.player,
    required this.index,
  }) : super(key: key);

  final double width;
  final double height;
  final PlayerInfo player;
  final int index;

  final logic = Get.find<ChoosePlayerLogic>();
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: player,
      onDraggableCanceled: (velocity, offset) {
        logic.update();
      },
      onDragCompleted: () {
        logic.update();
      },
      feedback: HexagonAvatar(
        width: width,
        avatarUrl: player.avatarUrl,
        tag: player.nickname,
      ),
      childWhenDragging: Container(),
      child: HexagonAvatar(
        width: width,
        avatarUrl: player.avatarUrl,
        tag: player.nickname,
      ),
    );
  }
}

class _NullTargetItem extends StatelessWidget {
  const _NullTargetItem({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Image.asset(
        Global.getAssetImageUrl('avatar/no_one.png'),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
