import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/data/model/show_state.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../modules/set_avatar/data/setAvatar_api.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../modules/set_avatar/view.dart';
import '../../../../widgets/check_in_title.dart';
import '../../data/checkIn_api.dart';
import '../before_checkIn/term_of_use.dart';

class PlayerInfoShow extends StatelessWidget {
  PlayerInfoShow({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: 1.0.sw,
          height: 1.0.sh,
          color: Colors.black,
          child: Column(
            children: [
              // 顶部文本信息
              CheckInTitlePage(titleText: ""),
              SizedBox(
                child: GetBuilder<CheckInLogic>(
                  builder: (logic) {
                    return Column(
                      children: [
                        Align(
                          heightFactor: 1.5,
                          alignment: const Alignment(-0.7, 1.0),
                          child: Text(
                            "Hi, there !",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 120.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                        ),
                        Align(
                          heightFactor: 1,
                          alignment: const Alignment(-0.65, 0.0),
                          child: Text(
                            "Set your avatar",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 120.sp,
                              decoration: TextDecoration.none,
                              fontFamily: 'BurbankBold',
                              color: Colors.white,
                              letterSpacing: 3.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                child: GetBuilder<CheckInLogic>(
                  builder: (logic) {
                    return Column(
                      children: [
                        _NicknameArea(),
                        Column(
                          children: [
                            // _AddPlayerButton(width: 432.w),
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 0.0, right: 0.56.sw),
                              child: _AddPlayerButton(width: 432.w),
                            ),
                            if(Get.arguments.status == ShowStatus.gamePreparing)
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 0.0, right: 0.56.sw),
                              child: _GoBackButton(),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        GetBuilder<CheckInLogic>(builder: (logic) {
          return Container();
        }),
      ],
    ));
  }
}

// 玩家姓名
class _NicknameArea extends StatelessWidget {
  _NicknameArea({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  Color get color {
    print("12345 ${Global.tableId}");
    if (Global.tableId == 1) {
      // background: #FFBD80;
      return const Color(0xFFFFBD80);
    } else if (Global.tableId == 2) {
      // background: #EFB5FD;
      return const Color(0xFFEFB5FD);
    } else if (Global.tableId == 3) {
      // background: #8EE8BD;
      return const Color(0xFF8EE8BD);
    } else {
      // background: #9ED7F7;
      return const Color(0xFF9ED7F7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("修改名字");
      },
      child: GetBuilder<CheckInLogic>(
        id: "nicknameArea",
        builder: (logic) {
          return Container(
            // decoration: BoxDecoration(
            //   color: Colors.red,
            // ),
            margin: EdgeInsets.only(top: 50.0, left: 0.0, right: 0.0),
            constraints: BoxConstraints.tightFor(width: 0.78.sw), //卡片大小
            child: Wrap(
              // 主轴(水平)方向间距
              spacing: 10,
              // 纵轴（垂直）方向间距
              runSpacing: 20,
              alignment: WrapAlignment.start, //沿主轴方向居中
              // crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(logic.userList.length, (index) => getItem(index, color)),
            ),
          );
        },
      ),
    );
  }
}

// 获取子项目
Widget getItem(int index, Color color) {
  final logic = Get.find<CheckInLogic>();

  var item = logic.userList[index % logic.userList.length];
  final checkInApi = CheckInApi();
  final setAvatarApi = SetAvatarApi();
  return ActionChip(
      pressElevation: 10,
      // tooltip: "点击",
      label: Text(
        item.nickname,
        style: TextStyle(
          fontSize: 60.sp,
          decoration: TextDecoration.none,
          fontFamily: 'BurbankBold',
          color: Colors.black,
          letterSpacing: 3.sp,
        ),
      ),
      //长按提示
      // labelPadding: EdgeInsets.all(10),
      // backgroundColor: Color(0xffFFBD80),
      backgroundColor: color,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      onPressed: () async {
        print("点击 ${item.id}");
        print("参数 ${Get.arguments}");
        Map<String, dynamic> jsonObj = {
          "userId": int.parse(item.id),
          "showId": Get.arguments.showId,
          "status": Get.arguments.status.toString()
        };
        print("参数 ${jsonObj}");
        print("object ${Get.isRegistered<SetAvatarLogic>()}");
        if(Get.isRegistered<SetAvatarLogic>()) {
          Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
          await Future.delayed(100.ms);
          Get.find<SetAvatarLogic>().updatePlayer(item.id);
          Get.find<SetAvatarLogic>().explosiveChestFun(item.id);
        }
        // await Get.offAllNamed(AppRoutes.setAvatar, arguments: jsonObj);
        await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
      });
  // return Chip(
  //   // 文字标签
  //   label: Text(item.nickname,
  //         style: TextStyle(
  //           fontSize: 60.sp,
  //           decoration: TextDecoration.none,
  //           fontFamily: 'BurbankBold',
  //           color: Colors.black,
  //           letterSpacing: 3.sp,
  //         ),
  //   ),
  //   // backgroundColor: Colors.orangeAccent,
  //   backgroundColor: Color(0xffFFBD80),
  //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(2.0),
  //   ),
  //   // 删除按钮，添加后回自动设置 Icon
  //   // onDeleted: () {},
  // );
}

// 添加用户按钮
class _AddPlayerButton extends StatelessWidget {
  _AddPlayerButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("add_player_btn.png");

  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("添加用户");
        // 将点击跳过按钮置回初始状态
        logic.isClickSkip = false;
        logic.isFirstCheckIn = false;
        print("添加用户的跳转： ${Get.arguments}");
        logic.gameItemInfo.clear();
        logic.testRefreshFun();
        // Map<String, dynamic> jsonObj = {
        //   "userId": logic.consumerId,
        //   "showId": Get.arguments.showId,
        //   "status": Get.arguments.status.toString()
        // };
        Get.to(() => TermOfUsePage(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "addPlayerBtn",
        builder: (logic) {
          return Container(
            height: width * 0.3,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}

// 返回到addPlayer页面
class _GoBackButton extends StatelessWidget {
  _GoBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("单击返回");
        await Get.offAllNamed(AppRoutes.choosePlayer, arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "backBtn",
        builder: (logic) {
          return Text(
            "Back",
            style: TextStyle(
              fontSize: 35.sp,
              decoration: TextDecoration.none,
              fontFamily: 'BurbankBold',
              color: Color(0xff13EFEF),
              letterSpacing: 3.sp,
            ),
          );
        },
      ),
    );
  }
}
