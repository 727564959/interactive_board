import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/game_over/logic.dart';
import 'package:interactive_board/pages/game_over/widgets/glory/wall_view.dart';

import '../../../common.dart';
import '../../../widgets/game_title.dart';
// import 'logic.dart';

class GameGloryPage extends StatelessWidget {
  GameGloryPage({Key? key}) : super(key: key);
  final logic = Get.find<GameOverLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: 1.0.sw,
            height: 1.0.sh,
            child: Image.asset(
              Global.getAssetImageUrl("background.png"),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 1.0.sw,
            height: 1.0.sh,
            child: Column(
              children: [
                const SizedBox(height: 50),
                GameTitleWidget(
                    gameName: logic.gameName, width: 0.45.sw, bAnimate: false),
                const SizedBox(height: 80),
              ],
            ),
          ),
          SizedBox(
            child: Image.asset(
              Global.getAssetImageUrl('glory_wall/glory_wall_bg.png'),
              width: 1.0.sw,
              height: 1.0.sh,
            ),
          ),
          // SizedBox(
          //   width: 1.0.sw,
          //   height: 1.0.sh,
          //   child: GetBuilder<GameOverLogic>(
          //     id: "page",
          //     builder: (logic) {
          //       return WallViewPage();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

// class _GloryWall extends StatelessWidget {
//   const _GloryWall({Key? key, required this.width, required this.bAnimate})
//       : super(key: key);
//   final double width;
//   final bool bAnimate;
//   @override
//   Widget build(BuildContext context) {
//     final decorate = Stack(
//       children: [
//         Align(
//           alignment: const Alignment(0.2, 1.1),
//           child: Image.asset(
//             Global.getAssetImageUrl('glory_wall/glory_wall_bg.png'),
//             width: width * 0.8,
//           ),
//         ),
//       ],
//     );
//     return decorate;
//     // return !bAnimate ? decorate : decorate.animate().moveX(begin: -70, end: 0, curve: Curves.easeOut, duration: 300.ms);
//   }
// }
