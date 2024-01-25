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
import 'package:interactive_board/pages/check_in/widgets/avatar/avatar_model.dart';
import 'package:interactive_board/pages/check_in/widgets/user_list.dart';

import '../../../app_routes.dart';
import '../../../widgets/parallelogram_avatar.dart';
import '../data/checkIn_api.dart';

import 'package:flutter_gif/flutter_gif.dart';

import 'add_player/add_player_info.dart';

class AvatarDesignPage extends StatelessWidget {
  AvatarDesignPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

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
                image: AssetImage(Global.getCheckInImageUrl("background_new.png")),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 1.0.sw,
                  child: GetBuilder<CheckInLogic>(
                    builder: (logic) {
                      if (logic.pageState == PageState.setAvatarPage) {
                        return Column(
                          children: [
                            // 顶部文本信息
                            _SetAvatarTitle(),
                            // 中间的用户信息和avatar信息
                            _SetAvatarContent(),
                            // 底部的功能按钮
                            _SetAvatarBtnInfo(),
                          ],
                        );
                      } else {
                        return FormTestRoute(key: UniqueKey());
                      }
                      // return Column(
                      //   children: [
                      //     // 顶部文本信息
                      //     _SetAvatarTitle(),
                      //     // 中间的用户信息和avatar信息
                      //     _SetAvatarContent(),
                      //     // 底部的功能按钮
                      //     _SetAvatarBtnInfo(),
                      //   ],
                      // );
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

// 顶部的文本信息
class _SetAvatarTitle extends StatelessWidget {
  const _SetAvatarTitle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.now();
    print("12345 ${DateTime.now().toString().substring(0, 19)}");
    final String dateTime = DateTime.now().toString().substring(11, 16);
    final content = SizedBox(
      width: 0.94.sw,
      height: 100.h,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: const Alignment(0.5, 1.5),
                child: SizedBox(
                  width: 0.2.sw,
                  child: Text(
                    "Add Player",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                      decoration: TextDecoration.none,
                      fontFamily: 'BurbankBold',
                      color: Colors.white,
                      letterSpacing: 3.sp,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.5, 1.5),
                child: Row(
                    children: [
                      SizedBox(
                        width: 0.64.sw,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 0.24.sw,
                              child: Text(
                                "The game will start in ",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 50.sp,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BurbankBold',
                                  color: Colors.white,
                                  letterSpacing: 3.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 0.1.sw,
                              child: Text(
                                "05:23",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50.sp,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'BurbankBold',
                                  color: Colors.white,
                                  letterSpacing: 3.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                ),
              ),
              Align(
                alignment: const Alignment(0.5, 1.5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.1.sw,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 0.05.sw,
                            child: Text(
                              dateTime,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.white,
                                letterSpacing: 3.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.05.sw,
                            child: Text(
                              " Table 1",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.deepOrange,
                                letterSpacing: 3.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return content;
  }
}
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
                // alignment: const Alignment(0.05, 1.35),
                // child: UserList(
                //   key: UniqueKey(),
                //   width: 295.w,
                //   height: 1.0.sh,
                // ),
                child: Column(
                  children: [
                    UserList(
                      key: UniqueKey(),
                      width: 295.w,
                      height: 0.6.sh,
                    ),
                    _AddPlayerButton(width: 306.w),
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
                //         _AddPlayerButton(width: 306.w),
                //       ],
                //     )
                // ),
              ),
              Align(
                // alignment: const Alignment(-1, -1),
                child: _PersonModel(width: 700.w),
              ),
              Align(
                alignment: const Alignment(-1, -1),
                child: SizedBox(
                  width: 700.w,
                  height: 700.h,
                ),
                // child: AvatarModel(),
              ),
            ],
          )
        ],
      ),
    );
    return content;
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
              _SaveAvatarButton(width: 316.w,),
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
      height: 1.0.sh,
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
        // Align(
        //   alignment: const Alignment(0.285, -0.739),
        //   child: GestureDetector(
        //     // 点击事件
        //     onTap: () {
        //       // print("单击返回");
        //     },
        //     child: GetBuilder<CheckInLogic>(
        //       id: "headPage",
        //       builder: (logic) {
        //         return Container(
        //           width: 280.w,
        //           height: 280.h,
        //           child: logic.currentUrl != ""
        //               ? CachedNetworkImage(
        //             imageUrl: logic.currentUrl,
        //             fit: BoxFit.fitWidth,
        //             width: width * 0.6,
        //           )
        //               : CachedNetworkImage(
        //             imageUrl:
        //             logic.avatarInfo[0].url,
        //             fit: BoxFit.fitWidth,
        //             width: width * 0.6,
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
    return decorate;
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
  String get backgroundUri => Global.getSetAvatarImageUrl("add_btn.png");

  final testTabId = Global.tableId;

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
          headgearId: logic.headId,
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