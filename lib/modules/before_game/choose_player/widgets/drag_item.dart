import 'package:flutter/material.dart';
import '../../../../widgets/hexagon_avatar.dart';
import '../../../../common.dart';
import '../data/player.dart';

class DragItem extends StatelessWidget {
  const DragItem({
    Key? key,
    required this.player,
    required this.width,
  }) : super(key: key);
  final double width;
  final PlayerInfo player;

  @override
  Widget build(BuildContext context) {
    return Draggable<PlayerInfo>(
      data: player,
      feedback: _PlayerWidget(
        nickname: player.nickname,
        joinedCount: player.joinedCount,
        avatarUrl: player.avatarUrl,
        width: width,
      ),
      childWhenDragging: Container(),
      child: _PlayerWidget(
        nickname: player.nickname,
        joinedCount: player.joinedCount,
        avatarUrl: player.avatarUrl,
        width: width,
      ),
    );
  }
}

class _PlayerWidget extends StatelessWidget {
  const _PlayerWidget({
    Key? key,
    required this.nickname,
    required this.joinedCount,
    required this.avatarUrl,
    required this.width,
  }) : super(key: key);
  final String nickname;
  final int joinedCount;
  final String avatarUrl;
  final double width;
  @override
  Widget build(BuildContext context) {
    final height = width * 0.93;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Align(
            alignment: const Alignment(0, 1.0),
            child: SizedBox(
              width: width,
              height: width * 0.6,
              child: Image.asset(
                Global.getAssetImageUrl('avatar/choose_card.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -1.0),
            child: HexagonAvatar(width: width * 0.5, avatarUrl: avatarUrl),
          ),
          Align(
            alignment: const Alignment(0, 0.55),
            child: Text(
              nickname,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.16,
                decoration: TextDecoration.none,
                fontFamily: 'BurbankBold',
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: _StarsBar(
              count: joinedCount,
              height: width * 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _StarsBar extends StatelessWidget {
  const _StarsBar({Key? key, required this.count, required this.height}) : super(key: key);
  final int count;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (index) => SizedBox(
          height: height,
          child: Image.asset(
            Global.getAssetImageUrl('avatar/star.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
