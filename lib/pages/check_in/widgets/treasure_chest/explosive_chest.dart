import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:intl/intl.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../widgets/check_in_title.dart';

class TreasureChestPage extends StatelessWidget {
  TreasureChestPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GetBuilder<CheckInLogic>(
              id: "treasureChest",
              builder: (logic) {
                return !logic.gameItemInfo.isEmpty ? _GetHeadiconsWidget() : _TreasureChestWidget();
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
          CheckInTitlePage(titleText: "Welcome Chest"),
          SizedBox(
            width: 1.0.sw,
            height: 0.65.sh,
            child: Container(
              margin: EdgeInsets.only(top: 0.2.sh),
              child: Image.asset(
                Global.getSetAvatarImageUrl('treasure_chest_icon.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
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
          CheckInTitlePage(titleText: "Welcome Chest"),
          SizedBox(
            width: 1.0.sw,
            height: 0.2.sh,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0.1.sh, left: 0.15.sw),
                  child: SizedBox(
                    width: 0.7.sw,
                    child: Text(
                      "Receive your newcomer's gift pack, these exciting headicons options for your upcoming adventures.",
                      style: TextStyle(
                        fontSize: 50.sp,
                        decoration: TextDecoration.none,
                        fontFamily: 'BurbankBold',
                        color: Colors.white,
                        letterSpacing: 3.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1.0.sw,
            height: 0.4.sh,
            margin: EdgeInsets.only(top: 0.05.sh, bottom: 0.05.sh),
            // decoration: BoxDecoration(
            //   color: Colors.white24,
            //   borderRadius: BorderRadius.all(Radius.circular(10)),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.2.sw,
                  height: 0.3.sh,
                  // decoration: BoxDecoration(
                  //   color: Colors.red,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: logic.gameItemInfo[0].icon,
                    fit: BoxFit.fitHeight,
                    width: 0.2.sw,
                  ),
                ),
                Container(
                  width: 0.2.sw,
                  height: 0.3.sh,
                  child: CachedNetworkImage(
                    imageUrl: logic.gameItemInfo[1].icon,
                    fit: BoxFit.fitHeight,
                    width: 0.2.sw,
                  ),
                ),
                Container(
                  width: 0.2.sw,
                  height: 0.3.sh,
                  child: CachedNetworkImage(
                    imageUrl: logic.gameItemInfo[2].icon,
                    fit: BoxFit.fitHeight,
                    width: 0.2.sw,
                  ),
                ),
              ],
            ),
          ),
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