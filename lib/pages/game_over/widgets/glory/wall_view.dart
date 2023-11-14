import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/game_over/logic.dart';

import '../../../../common.dart';

class WallViewPage extends StatelessWidget {
  WallViewPage({Key? key}) : super(key: key);
  final logic = Get.find<GameOverLogic>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Column(
        //   children: [
        //     Container(
        //       height: 1.0.sh,
        //       width: 0.3.sw,
        //       // margin: const EdgeInsets.only(top: 150.0, left: 50.0),
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage(
        //             Global.getAssetImageUrl('glory_wall/glory_wall_bg.png'),
        //           ),
        //           fit: BoxFit.fitWidth,
        //         ),
        //       ),
        //       child: Center(
        //         child: Text(
        //           "Glory wall",
        //           style: TextStyle(
        //             fontWeight: FontWeight.normal,
        //             fontSize: 40.sp,
        //             decoration: TextDecoration.none,
        //             fontFamily: 'Burbank',
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(
          child: Image.asset(
            Global.getAssetImageUrl('glory_wall/glory_wall_bg.png'),
            width: 0.3.sw,
          ),
        ),
        Text(
          "Glory wall",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 40.sp,
            decoration: TextDecoration.none,
            fontFamily: 'Burbank',
            color: Colors.white,
          ),
        ),
        // Positioned(
        //   left: 0.5.sw,
        //   top: 20,
        //   child: Text(
        //     "Glory wall",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 40.sp,
        //       decoration: TextDecoration.none,
        //       fontFamily: 'Burbank',
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
