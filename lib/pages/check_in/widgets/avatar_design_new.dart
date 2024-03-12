import 'dart:async';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/pages/check_in/data/user_info.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:interactive_board/pages/check_in/widgets/user_list.dart';

import '../../../app_routes.dart';
import '../../../widgets/parallelogram_avatar.dart';
import '../data/checkIn_api.dart';

import 'package:flutter_gif/flutter_gif.dart';

import '../view.dart';
import 'after_checkIn/player_info_show.dart';
import 'avatar/avatar_model.dart';
import 'avatar_title.dart';

class AvatarDesignPage extends StatelessWidget {
  AvatarDesignPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  // @override
  // void onInit() async {
  //   updateUserList();
  // }

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.now();
    return GestureDetector(
      child: GetBuilder<CheckInLogic>(
        id: "avatarHomePage",
        builder: (logic) {
          return Container(
            width: 1.0.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(Global.getCheckInImageUrl("background_new.png")),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 1.0.sw,
                  child: GetBuilder<CheckInLogic>(
                    builder: (logic) {
                      return Column(
                        children: [
                          // 顶部文本信息
                          AvatarTitlePage(titleText: "Set avatar"),
                          // 中间的用户信息和avatar信息
                          _SetAvatarContent(),
                          // 底部的功能按钮
                          // _SetAvatarBtnInfo(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// void updateUserList() async {
//   final logic = Get.find<CheckInLogic>();
//   final checkInApi = CheckInApi();
//   logic.userList = await checkInApi.fetchUsers();
// }
// 名称、人物模型、头像和身体信息
class _SetAvatarContent extends StatelessWidget {
  const _SetAvatarContent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      width: 0.96.sw,
      height: 0.8.sh,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                child: Column(
                  children: [
                    // UserList(
                    //   key: UniqueKey(),
                    //   width: 295.w,
                    //   height: 0.6.sh,
                    // ),
                    SizedBox(
                      width: 0.23.sw,
                      height: 0.2.sh,
                      child: GetBuilder<CheckInLogic>(
                        builder: (logic) {
                          return Row(
                            children: [
                              // _EditNicknameButton(),
                              _EditNicknameText(),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 0.23.sw,
                      height: 0.35.sh,
                      child: GetBuilder<CheckInLogic>(
                        builder: (logic) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20.0, left: 20.0),
                                child: SizedBox(
                                  width: 0.24.sw,
                                  child: Text(
                                    "After saving,",
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'BurbankBold',
                                      color: Colors.white,
                                      letterSpacing: 3.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0.0, left: 20.0),
                                child: SizedBox(
                                  width: 0.24.sw,
                                  child: Text(
                                    "changes apply",
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'BurbankBold',
                                      color: Colors.white,
                                      letterSpacing: 3.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0.0, left: 20.0),
                                child: SizedBox(
                                  width: 0.24.sw,
                                  child: Text(
                                    "in the next game.",
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'BurbankBold',
                                      color: Colors.white,
                                      letterSpacing: 3.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    _SaveAndBackButton(width: 384.w),
                  ],
                ),
                // child: SizedBox(
                //   width: 0.2.sw,
                //   child: Column(
                //       children: [
                //         UserList(
                //           key: UniqueKey(),
                //           width: 295.w,
                //           height: 0.5.sh,
                //         ),
                //         _AddPlayerButton(width: 432.w),
                //       ],
                //     )
                // ),
              ),
              Align(
                alignment: const Alignment(-1, -1),
                child: _PersonModel(width: 700.w),
              ),
              Align(
                // alignment: const Alignment(-1, -1),
                // child: SizedBox(
                //   width: 700.w,
                //   height: 700.h,
                // ),
                // child: AvatarModel(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.only(top: 0.0, left: 0.0),
                  constraints: BoxConstraints.tightFor(
                      width: 0.34.sw, height: 0.7.sh), //卡片大小
                  child: AvatarModel(),
                ),
              ),
            ],
          )
        ],
      ),
    );
    return content;
  }
}

class _EditNicknameText extends StatelessWidget {
  _EditNicknameText({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  // TextEditingController _nameTextFieldController = new TextEditingController(text: "testststs");

  @override
  Widget build(BuildContext context) {
    print("ppp ${logic.currentNickName}");
    TextEditingController _nameTextFieldController =
        new TextEditingController(text: logic.currentNickName);
    return Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 428.w, height: 118.h), //卡片大小
      child: TextField(
        controller: _nameTextFieldController,
        decoration: InputDecoration(
          // hintText: logic.currentNickName,
          // border: InputBorder.none,
          // fillColor: Colors.deepOrangeAccent,
          fillColor: Color(0xffFFBD80),
          filled: true,
          suffixIcon: Icon(
            Icons.edit,
            size: 40,
          ),
          isCollapsed: true,
          contentPadding:
          EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
          // suffix: Text('.com'),
          // suffixStyle: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(15),
          FilteringTextInputFormatter.allow(
            RegExp(r'[A-Za-z0-9]+'),
          )
        ],
        onChanged: (v) {
          print("onChange: $v");
          // print("tetetettet: ${_nameTextFieldController.text}");
          logic.currentNickName = v;
        },
        style: TextStyle(
          fontSize: 60.sp,
          decoration: TextDecoration.none,
          fontFamily: 'BurbankBold',
          color: Colors.white,
          letterSpacing: 3.sp,
        ),
      ),
    );
  }
}

// 修改nickname
class _EditNicknameButton extends StatelessWidget {
  _EditNicknameButton({
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
        id: "editNickname",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
            ),
            margin: EdgeInsets.only(top: 0.0, left: 0.0),
            constraints:
                BoxConstraints.tightFor(width: 428.w, height: 118.h), //卡片大小
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0.0, left: 20.0),
                  child: Text(
                    logic.currentNickName,
                    style: TextStyle(
                      fontSize: 60.sp,
                      decoration: TextDecoration.none,
                      fontFamily: 'BurbankBold',
                      color: Colors.black,
                      letterSpacing: 3.sp,
                    ),
                  ),

                  // child: !logic.isUpdateName ? Text(
                  //     "Sophia Davis",
                  //     style: TextStyle(
                  //       fontSize: 60.sp,
                  //       decoration: TextDecoration.none,
                  //       fontFamily: 'BurbankBold',
                  //       color: Colors.black,
                  //       letterSpacing: 3.sp,
                  //     ),
                  //   ) : TextField(
                  //     controller: TextEditingController(),
                  //     decoration: InputDecoration(
                  //       hintText: '请输入nickname',
                  //       hintStyle: TextStyle(
                  //         fontFamily: 'Burbank',
                  //         color: Colors.white,
                  //         decoration: TextDecoration.none,
                  //         fontSize: 24.sp,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     ),
                  //     // onChanged: (text) {
                  //     onSubmitted: (text) {
                  //       print("输入改变时" + text);
                  //       logic.testUpd(text);
                  //     },
                  //     style: TextStyle(
                  //       fontFamily: 'Burbank',
                  //       color: Colors.white,
                  //       decoration: TextDecoration.none,
                  //       fontSize: 36.sp,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  //   ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0.0, left: 20.0),
                  child: Image.asset(
                    Global.getSetAvatarImageUrl('set_avatar_edit_icon.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 底部的功能按钮区域
class _SetAvatarBtnInfo extends StatelessWidget {
  const _SetAvatarBtnInfo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      width: 0.94.sw,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _GoBackButton(width: 84.w),
              _SaveAvatarButton(
                width: 316.w,
              ),
            ],
          )
        ],
      ),
    );
    return content;
  }
}

// 人物模型
class _PersonModel extends StatelessWidget {
  const _PersonModel({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 0.8.sh,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _ModelShape(width: width, bAnimate: false),
        ],
      ),
    );
  }
}

// 模型图层
class _ModelShape extends StatelessWidget {
  _ModelShape({Key? key, required this.width, required this.bAnimate})
      : super(key: key);
  final double width;
  final bool bAnimate;
  final logic = Get.find<CheckInLogic>();
  @override
  Widget build(BuildContext context) {
    final decorate = Stack(
      children: [
        Align(
          alignment: const Alignment(0, 0.279),
          child: GestureDetector(
            // 点击事件
            onTap: () {
              // print("单击返回");
            },
            child: GetBuilder<CheckInLogic>(
              id: "bodyPage",
              builder: (logic) {
                // print("wwww ${logic.currentIsMale}");
                return logic.currentIsMale
                    ? (Global.team == 0
                        ? Image.asset(
                            Global.getCheckInImageUrl('avatar/Red_man.png'),
                            width: width * 0.5,
                          )
                        : Image.asset(
                            Global.getCheckInImageUrl('avatar/Blue_man.png'),
                            width: width * 0.5,
                          ))
                    : (Global.team == 0
                        ? Image.asset(
                            Global.getCheckInImageUrl('avatar/Red_Women.png'),
                            width: width * 0.5,
                          )
                        : Image.asset(
                            Global.getCheckInImageUrl('avatar/Blue_Women.png'),
                            width: width * 0.5,
                          ));
              },
            ),
          ),
        ),
        Align(
          // alignment: const Alignment(0.285, -0.739),
          alignment: const Alignment(0.225, -0.85),
          child: GestureDetector(
            // 点击事件
            onTap: () {
              // print("单击返回");
            },
            child: GetBuilder<CheckInLogic>(
              id: "headPage",
              builder: (logic) {
                return Container(
                  width: 240.w,
                  height: 240.h,
                  child: logic.currentUrl != ""
                      ? CachedNetworkImage(
                          imageUrl: logic.currentUrl,
                          fit: BoxFit.fitWidth,
                          width: width * 0.6,
                        )
                      : CachedNetworkImage(
                          imageUrl: logic.avatarInfo[0].url,
                          fit: BoxFit.fitWidth,
                          width: width * 0.6,
                        ),
                );
              },
            ),
          ),
        ),
      ],
    );
    return decorate;
  }
}

// 添加用户按钮
class _SaveAndBackButton extends StatelessWidget {
  _SaveAndBackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri =>
      Global.getSetAvatarImageUrl("save_and_back_btn.png");

  final testTabId = Global.tableId;

  final checkInApi = CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        // logic.checkInFun(false);
        print("保存avatar");
        print("sssr ${logic.selectedId}");
        print("sssr ${logic.headId}");
        print("sssr ${logic.currentNickName}");
        print("currentIsMale ${logic.currentIsMale}");
        print("isClickSkip ${logic.isClickSkip}");
        // int num1 = int.parse(logic.selectedId.toString());
        int num2 = int.parse(logic.headId.toString());
        // 如果在添加用户信息页面点击了跳过，则需要先添加用户信息，再进行形象信息更新保存；反之则直接更新形象信息
        if (logic.isClickSkip) {
          // 添加用户(加入游戏show)
          await checkInApi.addPlayerFun(logic.showState.showId, testTabId, null, null, logic.currentNickName, null);
          // 更新用户列表
          logic.userList = await checkInApi.fetchUsers(logic.showState.showId);
          int index = logic.userList.length - 1;
          print("ooop ${index}");
          logic.selectedId = logic.userList[index].id;
          print("rtrt ${logic.selectedId}");
          // 更新形象信息
          await checkInApi.updatePlayer(int.parse(logic.selectedId.toString()),
              logic.currentNickName, num2, logic.currentIsMale ? 1 : 2);
        } else {
          // 更新形象信息
          await checkInApi.updatePlayer(int.parse(logic.selectedId.toString()),
              logic.currentNickName, num2, logic.currentIsMale ? 1 : 2);
        }
        print("showState ${logic.showState.showId}");
        // 更新用户信息
        logic.updateUserList(logic.showState.showId);
        Get.to(() => PlayerInfoShow(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "saveAndBackBtn",
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

// 添加用户按钮
class _AddPlayerButton extends StatelessWidget {
  _AddPlayerButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("add_player_btn.png");

  // final testTabId = Global.tableId;
  final testTabId = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("打开添加用户页面");
        // logic.checkInFun(false);
        print("54321 $testTabId");
        logic.clickAddPlayer();
      },
      child: GetBuilder<CheckInLogic>(
        id: "addPlayer",
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

// 返回按钮
class _GoBackButton extends StatelessWidget {
  _GoBackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  // String get backgroundUri => Global.getSetAvatarImageUrl("back_btn_default.png");
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
        logic.checkInFun(false);
        Get.to(() => CheckInPage(), arguments: Get.arguments);
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

// 保存avatar按钮
class _SaveAvatarButton extends StatelessWidget {
  _SaveAvatarButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  // String get backgroundUri => Global.getSetAvatarImageUrl("save_btn_default.png");
  String get backgroundUri => !logic.saveAvatarIsDown
      ? Global.getSetAvatarImageUrl("save_btn_default.png")
      : Global.getSetAvatarImageUrl("save_btn_selected.png");

  get checkInApi => CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 按下
      onTapDown: (details) {
        logic.saveAvatarBtnDown(true);
      },
      // 抬起
      onTapUp: (details) {
        logic.saveAvatarBtnDown(false);
      },
      // 点击事件
      onTap: () async {
        print("保存avatar");
        print("用户数据: ${logic.userList}");
        await checkInApi.updatePlayerInfo(
            logic.selectedId ?? (logic.userList[0].id),
            logic.currentNickName,
            logic.headId,
            logic.currentIsMale);
        final index = logic.userList
            .indexWhere((element) => element.id == logic.selectedId);
        logic.userList[index] = UserInfo(
          id: logic.userList[index].id,
          nickname: logic.currentNickName,
          avatarUrl: logic.currentUrl,
          // username: logic.userList[index].username,
          // isMale: logic.currentIsMale,
          headgearId: logic.headId.toString(),
          headgearName: logic.userList[index].headgearName,
          bodyId: logic.userList[index].bodyId,
          bodyName: logic.userList[index].bodyName,
        );
        // logic.testSave();
        Get.dialog(
          Center(
            child: Container(
              width: 700.w,
              height: 150.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      Global.getCheckInImageUrl("success_dialog.png")),
                  // fit: BoxFit.cover,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
      child: GetBuilder<CheckInLogic>(
        id: "saveAvatarBtn",
        builder: (logic) {
          return Container(
            height: width * 0.31,
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
