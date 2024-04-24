import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:intl/intl.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../widgets/check_in_title.dart';

class TreasureChestPage extends StatelessWidget {
  TreasureChestPage({Key? key, required this.playerId}) : super(key: key);
  final int playerId;
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GetBuilder<CheckInLogic>(
              id: "treasureChest",
              builder: (logic) {
                return _TreasureChestWidget(playerId: playerId);
                // return !logic.gameItemInfo.isEmpty ? _GetHeadiconsWidget() : _TreasureChestWidget(playerId: playerId);
              }
            ),
          ],
        ));
  }
}
// 宝箱图
class _TreasureChestWidget extends StatelessWidget {
  _TreasureChestWidget({
    Key? key,
    required this.playerId
  }) : super(key: key);
  final int playerId;
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      height: 1.0.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // 顶部文本信息
          // CheckInTitlePage(titleText: "Welcome Chest"),
          Align(
            alignment: const Alignment(-0.6, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  "Welcome Package",
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                ),
                SizedBox(height: 10,),
                Text(
                  "Click to flip the cards, exploring your gift pack",
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 1.0.sw,
          //   height: 0.65.sh,
          //   child: Container(
          //     margin: EdgeInsets.only(top: 0.2.sh),
          //     child: Image.asset(
          //       Global.getSetAvatarImageUrl('pageage_icon.png'),
          //       fit: BoxFit.fitHeight,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 1.0.sw,
            height: 0.5.sh,
            child: GestureDetector(
              // 点击事件
              onTap: () async {
                // logic.getHeadgearFun(playerId);
                logic.updateHeadgearPageFun();
              },
              child: Container(
                margin: EdgeInsets.only(top: 0.2.sh),
                child: !logic.isClickCard ? Image.asset(
                  Global.getSetAvatarImageUrl('pageage_icon.png'),
                  fit: BoxFit.contain,
                ) : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Global.getSetAvatarImageUrl('card_bg_icon.png')),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: CachedNetworkImage(
                          height: 180,
                          imageUrl: "$baseStrapiUrl${logic.headgearObj['itemInfo']['icon']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 36),
                      Container(
                        color: Color(0xFFDBE2E3),
                        width: 224,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            logic.headgearObj['itemInfo']['name'],
                            maxLines: 1, // 最大显示行数
                            overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                            style: CustomTextStyles.notice(color: Color(0xFF5A5858), fontSize: 24.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  // CachedNetworkImage(
                  //   imageUrl: "$baseStrapiUrl${logic.headgearObj['itemInfo']['icon']}",
                  //   fit: BoxFit.contain,
                  // )
              ),
            ),
          ),
          SizedBox(height: 50,),
          if(logic.isClickCard) _NextButton(width: 600.w,),
        ],
      ),
    );
  }
}
// 宝箱图
class _GetHeadiconsWidget extends StatelessWidget {
  _GetHeadiconsWidget({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      height: 1.0.sh,
      color: Colors.black,
      child: Column(
        children: [
          // 顶部文本信息
          // CheckInTitlePage(titleText: "Welcome Chest"),
          // SizedBox(
          //   width: 1.0.sw,
          //   height: 0.2.sh,
          //   child: Row(
          //     children: [
          //       Container(
          //         margin: EdgeInsets.only(top: 0.1.sh, left: 0.15.sw),
          //         child: SizedBox(
          //           width: 0.7.sw,
          //           child: Text(
          //             "Receive your newcomer's gift pack, these exciting headicons options for your upcoming adventures.",
          //             style: TextStyle(
          //               fontSize: 50.sp,
          //               decoration: TextDecoration.none,
          //               fontFamily: 'BurbankBold',
          //               color: Colors.white,
          //               letterSpacing: 3.sp,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Align(
            alignment: const Alignment(-0.6, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  "Welcome Package",
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                ),
                SizedBox(height: 10,),
                Text(
                  "Click to flip the cards, exploring your gift pack",
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                ),
              ],
            ),
          ),
          // Container(
          //   width: 1.0.sw,
          //   height: 0.4.sh,
          //   margin: EdgeInsets.only(top: 0.05.sh, bottom: 0.05.sh),
          //   // decoration: BoxDecoration(
          //   //   color: Colors.white24,
          //   //   borderRadius: BorderRadius.all(Radius.circular(10)),
          //   // ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         width: 0.2.sw,
          //         height: 0.3.sh,
          //         // decoration: BoxDecoration(
          //         //   color: Colors.red,
          //         // ),
          //         child: CachedNetworkImage(
          //           imageUrl: logic.gameItemInfo[0].icon,
          //           fit: BoxFit.fitHeight,
          //           width: 0.2.sw,
          //         ),
          //       ),
          //       Container(
          //         width: 0.2.sw,
          //         height: 0.3.sh,
          //         child: CachedNetworkImage(
          //           imageUrl: logic.gameItemInfo[1].icon,
          //           fit: BoxFit.fitHeight,
          //           width: 0.2.sw,
          //         ),
          //       ),
          //       Container(
          //         width: 0.2.sw,
          //         height: 0.3.sh,
          //         child: CachedNetworkImage(
          //           imageUrl: logic.gameItemInfo[2].icon,
          //           fit: BoxFit.fitHeight,
          //           width: 0.2.sw,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          _NextButton(width: 600.w,),
        ],
      ),
    );
  }
}

// 下一步的按钮
class _NextButton extends StatelessWidget {
  _NextButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("用于传递的参数: ${Get.arguments}");
        // await Get.toNamed(AppRoutes.setAvatar, arguments: Get.arguments);
        print("Get.isRegistered<SetAvatarLogic>() ${Get.isRegistered<SetAvatarLogic>()}");
        if(Get.isRegistered<SetAvatarLogic>()) {
          Get.find<SetAvatarLogic>().updateUserList(Get.arguments['showId']);
          await Future.delayed(100.ms);
          Get.find<SetAvatarLogic>().updatePlayer(Get.arguments['userId'].toString());
          Get.find<SetAvatarLogic>().explosiveChestFun(Get.arguments['userId'].toString());
        }
        // // 延迟调用爆宝箱
        // Future.delayed(0.5.seconds).then((value) {
        //   logic.gameItemInfo.clear();
        // }).onError((error, stackTrace) async {
        //   print("error爆宝箱 $error");
        // });
        await Get.toNamed(AppRoutes.setAvatar, arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "editNextBtn",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff13EFEF),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.only(top: 0.0, left: 0.0),
            constraints: BoxConstraints.tightFor(width: width * 0.8, height: 80.h),
            child: Center(
              child: Text(
                "Let's Start!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.sp,
                  decoration: TextDecoration.none,
                  fontFamily: 'BurbankBold',
                  color: Color(0xff000000),
                  letterSpacing: 3.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}