import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide AnimationExtension;

import '../../common.dart';
import 'logic.dart';
import 'widgets/game_text.dart';
import 'widgets/statistics_view.dart';
import 'widgets/glory_view.dart';

class GameOverPage extends StatelessWidget {
  GameOverPage({Key? key}) : super(key: key);
  final logic = Get.find<GameOverLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   color: Colors.black,
          // ),
          // Transform.scale(
          //   scale: 2,
          //   child: SizedBox(
          //     width: 1.0.sw,
          //     child: Image.asset(
          //       Global.getAssetImageUrl('background.png'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // .animate(onPlay: (controller) => controller.repeat())
          // .rotate(duration: 30.seconds, begin: 0, end: 1.0),
          Container(
            width: 1.0.sw,
            // height: 1080,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Global.getAssetImageUrl("background.png")),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 1.0.sw,
            height: 1.0.sh,
            child: GetBuilder<GameOverLogic>(
              id: "page",
              builder: (logic) {
                print("logic ${logic.pageState}");
                if (logic.pageState == PageState.winnerText) {
                  return GameTextPage(key: UniqueKey());
                } else if (logic.pageState == PageState.statistics) {
                  return StatisticsView(key: UniqueKey());
                } else {
                  return GameGloryPage(key: UniqueKey());
                }
              },
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Text(
              "Table ${Global.tableId}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.sp,
                decoration: TextDecoration.none,
                fontFamily: 'Burbank',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
