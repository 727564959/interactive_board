import 'package:flutter/material.dart';

import '../../../common.dart';
import '../../../data/model/player.dart';
import 'drag_item.dart';

class PlayerSticker extends StatelessWidget {
  const PlayerSticker({
    Key? key,
    required this.width,
    required this.players,
  }) : super(key: key);
  final double width;
  final List<PlayerInfo> players;
  @override
  Widget build(BuildContext context) {
    final height = width * 0.22;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Global.getAssetImageUrl("player_sticker.png")),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: players
              .map(
                (e) => SizedBox(
                  width: width * 0.145,
                  child: DragItem(
                    nickname: e.nickname,
                    joinedCount: e.joinedCount,
                    avatarUrl: e.avatarUrl,
                    width: width * 0.12,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
