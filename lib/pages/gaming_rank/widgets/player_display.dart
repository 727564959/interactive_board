import 'package:flutter/material.dart';
import 'player_card.dart';

class PlayerDisplay extends StatelessWidget {
  const PlayerDisplay({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.cyan,
      width: width,
      height: width,
      child: PlayerCard(
        parentWidth: width,
        avatarUrl: 'https://tse1-mm.cn.bing.net/th/id/OIP-C.zo3iWUdNdza7idmxdY97wAHaDa?pid=ImgDet&rs=1',
        nickname: 'abc',
        position: 5,
        size: PlayerCardSize.small,
      ),
    );
  }
}
