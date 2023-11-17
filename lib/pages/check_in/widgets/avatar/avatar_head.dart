import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../data/avatar_info.dart';

class AvatarHeadPage extends StatelessWidget {
  AvatarHeadPage({Key? key, required this.width, required this.avatarUrl})
      : super(key: key);
  final double width;
  final String avatarUrl;
  final logic = Get.find<CheckInLogic>();
  List<AvatarInfo> get avatarInfo => logic.avatarInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/Cat.png'),
                    width: width,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/ChipsHead.png'),
                    width: width,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/Muiscbox.png'),
                    width: width,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/Panda.png'),
                    width: width,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/Pineapple.png'),
                    width: width,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/Shark.png'),
                    width: width,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/Tiger.png'),
                    width: width,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/TV.png'),
                    width: width,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Global.getCheckInImageUrl('avatar/Wolf.png'),
                    width: width,
                  ),
                ),
              ],
            ),
          ],
        ));

    // return Scaffold(
    //     body: Stack(
    //   children: [
    //     Container(
    //       width: 1.0.sw,
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage(Global.getAssetImageUrl("background.png")),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             width: 0.85.sw,
    //             child: GetBuilder<CheckInLogic>(
    //               builder: (logic) {
    //                 return Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     // Leaderboard(width: 700.w),
    //                     // PlayerDisplay(key: UniqueKey(), width: 580.w),
    //                   ],
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     GetBuilder<CheckInLogic>(builder: (logic) {
    //       // if (logic.bGameStart) {
    //       //   return Container();
    //       // } else {
    //       //   return const WaitingMask();
    //       // }
    //     }),
    //   ],
    // ));
  }
}
