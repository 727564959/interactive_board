import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../data/checkIn_api.dart';
import '../avatar_design_new.dart';
import '../avatar_title.dart';
import '../before_checkIn/term_of_use.dart';

class PlayerInfoShow extends StatelessWidget {
  PlayerInfoShow({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  final String dateTime = DateTime.now().toString().substring(11, 16);

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
              AvatarTitlePage(titleText: ""),
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
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.red,
              //   ),
              //   margin: EdgeInsets.only(top: 0.0, left: 0.0),
              //   constraints: BoxConstraints.tightFor(width: 0.9.sw),
              //   child: Column(
              //     children: [
              //       _NicknameArea(),
              //       Column(
              //         children: [
              //           Container(
              //             margin: EdgeInsets.only(top: 20.0, left: 80.0),
              //             child: _AddPlayerButton(width: 432.w),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(top: 60.0, left: 80.0),
              //             child: _GoBackButton(width: 84.w),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                child: GetBuilder<CheckInLogic>(
                  builder: (logic) {
                    return Column(
                      children: [
                        _NicknameArea(),
                        Column(
                          children: [
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       margin: EdgeInsets.only(top: 20.0, left: 0.0),
                            //       child: _AddPlayerButton(width: 432.w),
                            //     ),
                            //   ],
                            // ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 0.0),
                              child: _AddPlayerButton(width: 432.w),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 60.0, left: 0.0),
                              child: _GoBackButton(width: 84.w),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("修改名字");
        // logic.isUpdateNameFun(true);
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
              children: List.generate(logic.userList.length, (index) => getItem(index)),
            ),

            // child: Container(
            //   margin: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0),
            //   child: Text(
            //     logic.userList[0].nickname,
            //     style: TextStyle(
            //       fontSize: 60.sp,
            //       decoration: TextDecoration.none,
            //       fontFamily: 'BurbankBold',
            //       color: Colors.black,
            //       letterSpacing: 3.sp,
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}

// 获取子项目
Widget getItem(int index) {
  final logic = Get.find<CheckInLogic>();
  var item = logic.userList[index % logic.userList.length];
  final checkInApi = CheckInApi();
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
      backgroundColor: Color(0xffFFBD80),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      onPressed: () async {
        print("点击 ${item.id}");
        // 将点击跳过按钮置回初始状态
        logic.isClickSkip = false;
        logic.isFirstCheckIn = false;
        logic.singlePlayer = await checkInApi.fetchSingleUsers(item.id);
        print("点击 ${logic.singlePlayer}");
        final index = logic.userList.indexWhere((element) => element.id == item.id);
        print("点击 ${index}");
        print("点击 ${logic.userList[index]}");
        // 更新
        logic.selectedId = item.id;
        print("54321 ${logic.selectedId}");
        logic.currentUrl = logic.userList[index].avatarUrl;
        logic.currentIsMale = logic.userList[index].bodyName == "Male" ? true : false;
        logic.currentNickName = logic.userList[index].nickname;
        // 更新用户信息
        // logic.updateUserList(logic.showState.showId);
        // 跳转到形象设计页面
        Get.to(() => AvatarDesignPage(), arguments: Get.arguments);
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

// 返回按钮
class _GoBackButton extends StatelessWidget {
  _GoBackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => !logic.addGoBackIsDown
      ? Global.getSetAvatarImageUrl("back_btn_default.png")
      : Global.getSetAvatarImageUrl("back_btn_selected.png");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 按下
      onTapDown: (details) {
        logic.goBackBtnDown(true);
      },
      // 抬起
      onTapUp: (details) {
        logic.goBackBtnDown(false);
      },
      // 点击事件
      onTap: () {
        print("单击返回");
        Get.offAllNamed(AppRoutes.choosePlayer, arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "goBackBtn",
        builder: (logic) {
          return Container(
            height: width * 0.72,
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
