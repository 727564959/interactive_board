import 'package:flutter/material.dart';
import '../../common.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hexagon_avatar.dart';

class ChoosePlayerPage extends StatelessWidget {
  const ChoosePlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Global.getAssetImageUrl("background.png")),
          fit: BoxFit.cover,
        ),
      ),
      child: const Column(
        children: [
          SizedBox(
            height: 50,
          ),
          GameTitleWidget(
            gameName: "Block Party",
            width: 600,
            bAnimate: true,
          ),
          HexagonAvatar(avatarUrl: "http://10.1.4.13:1337/uploads/_f56cfd3ac5.png", size: 300, tag: "asdhuw"),
        ],
      ),
    );
  }
}
