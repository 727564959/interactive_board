import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common.dart';
import '../../widgets/game_title.dart';

import 'logic.dart';
import 'widgets/player_sticker.dart';
import 'widgets/player_selection_menu.dart';

class ChoosePlayerPage extends StatelessWidget {
  const ChoosePlayerPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Global.getAssetImageUrl("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            GameTitleWidget(gameName: "Block Party", width: 0.45.sw, bAnimate: true),
            const SizedBox(height: 80),
            PlayerSelectionMenu(width: 0.7.sw),
            // const SizedBox(height: 70),
            GetBuilder<ChoosePlayerLogic>(
              builder: (logic) {
                return PlayerSticker(width: 0.9.sw, players: logic.unselectedPlayers);
              },
            ),
            // PlayerSticker(width: 0.9.sw, players: logic.players),
          ],
        ),
      ),
    );
  }
}
