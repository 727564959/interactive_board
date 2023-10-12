import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../data/player.dart';

import '../logic.dart';
import 'player_card.dart';

class PlayerDisplay extends StatelessWidget {
  PlayerDisplay({Key? key, required this.width}) : super(key: key);
  final double width;
  final logic = Get.find<GamingRankLogic>();
  List<PlayerInfo> get players => logic.showPlayers;
  PlayerCardSize get size {
    if (players.length == 1) {
      return PlayerCardSize.large;
    } else if (players.length == 2) {
      return PlayerCardSize.middle;
    } else {
      return PlayerCardSize.small;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: width * 1.2,
        child: Column(
          mainAxisAlignment: players.length > 2 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: players.length > 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
              children: [
                if (players.isNotEmpty)
                  PlayerCard(
                    parentWidth: width,
                    avatarUrl: players[0].avatarUrl,
                    nickname: players[0].nickname,
                    position: players[0].position,
                    size: size,
                  ),
                if (players.length > 1)
                  PlayerCard(
                    parentWidth: width,
                    avatarUrl: players[1].avatarUrl,
                    nickname: players[1].nickname,
                    position: players[1].position,
                    size: size,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: players.length > 3 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
              children: [
                if (players.length > 2)
                  PlayerCard(
                    parentWidth: width,
                    avatarUrl: players[2].avatarUrl,
                    nickname: players[2].nickname,
                    position: players[2].position,
                    size: size,
                  ),
                if (players.length > 3)
                  PlayerCard(
                    parentWidth: width,
                    avatarUrl: players[3].avatarUrl,
                    nickname: players[3].nickname,
                    position: players[3].position,
                    size: size,
                  ),
              ],
            ),
          ],
        ));
  }
}
