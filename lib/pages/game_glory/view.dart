import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common.dart';
import '../../widgets/game_title.dart';
// import 'logic.dart';

class GameGloryPage extends StatelessWidget {
  const GameGloryPage({Key? key}) : super(key: key);
  // final logic = Get.find<GamingRankLogic>();
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
            GameTitleWidget(
                gameName: "Block Party", width: 0.45.sw, bAnimate: true),
            const SizedBox(height: 80),
            _GloryWall(width: 0.8.sw, bAnimate: false),
          ],
        ),
      ),
    );
  }
}

class _GloryWall extends StatelessWidget {
  const _GloryWall({Key? key, required this.width, required this.bAnimate})
      : super(key: key);
  final double width;
  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final decorate = Stack(
      children: [
        Align(
          alignment: const Alignment(0.2, 1.1),
          child: Image.asset(
            Global.getAssetImageUrl('glory_wall/glory_wall_bg.png'),
            width: width * 0.8,
          ),
        ),
      ],
    );
    return decorate;
    // return !bAnimate ? decorate : decorate.animate().moveX(begin: -70, end: 0, curve: Curves.easeOut, duration: 300.ms);
  }
}
