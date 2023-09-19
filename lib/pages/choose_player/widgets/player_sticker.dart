import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
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
  double get itemWidth => width * 0.12;
  double get height => width * 0.22;
  double get itemPadding => itemWidth * 0.2;
  double get left => (width - (itemPadding * (players.length - 1) + players.length * itemWidth)) / 2;
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final count = players.length;

    for (int i = 0; i < count; i++) {
      children.add(
        AnimatedPositioned(
          key: ObjectKey(players[i]),
          left: left + i * (itemWidth + itemPadding),
          duration: 100.ms,
          child: FadeInUp(
            delay: 50.ms,
            duration: 100.ms,
            from: 50,
            child: DragItem(
              player: players[i],
              width: itemWidth,
            ),
          ),
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Global.getAssetImageUrl("player_sticker.png")),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: children,
      ),
    );
  }
}
