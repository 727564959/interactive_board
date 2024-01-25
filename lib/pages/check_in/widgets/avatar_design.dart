import 'dart:async';

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

class AvatarDeaignPage extends StatelessWidget {
  AvatarDeaignPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GetBuilder<CheckInLogic>(
        id: "avatarSelect",
        builder: (logic) {
          return Container(
            width: 1.0.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Global.getCheckInImageUrl("background.png")),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 1.0.sw,
                  child: GetBuilder<CheckInLogic>(
                    builder: (logic) {
                      return Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _BgLeftView(),
                          _MiddleView(),
                          _RightView(),
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

class _BgLeftView extends StatelessWidget {
  const _BgLeftView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final content = Image.asset(Global.getCheckInImageUrl("bg_left.png"));
    final content = SizedBox(
      width: 365.w,
      height: 1.0.sh,
      child: Stack(
        children: [
          Align(
            // alignment: const Alignment(-0.75, 1.85),
            alignment: const Alignment(0.05, 1.35),
            child: UserList(
              key: UniqueKey(),
              width: 295.w,
              height: 800.h,
            ),
          ),
          Align(
            alignment: const Alignment(-1.05, 0),
            child: Image.asset(
              Global.getCheckInImageUrl('bg_left.png'),
              fit: BoxFit.fitHeight,
              width: 70.sp,
              height: 1.0.sh,
            ),
          ),
          Align(
            alignment: const Alignment(-1, -1),
            child: _GoBackButton(width: 143.w),
          ),
        ],
      ),
      // child: Image.asset(
      //   Global.getCheckInImageUrl('bg_left.png'),
      //   fit: BoxFit.fitHeight,
      // ),
    );
    return content;
  }
}

class _MiddleView extends StatelessWidget {
  const _MiddleView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      width: 700.w,
      height: 1.0.sh,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-1, -1),
            child: _PersonModel(width: 700.w),
          ),
          Align(
            alignment: const Alignment(1.15, -1.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _SetNicknameButton(
                  width: 241.w,
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(1.45, 0.92),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _SaveAvatarButton(
                  width: 427.w,
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: const Alignment(0, 0.85),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       _SetNicknameButton(
          //         width: 241.w,
          //       ),
          //       _SaveAvatarButton(
          //         width: 181.w,
          //       ),
          //       //   Text("set nickname"),
          //       //   Text("save avatar"),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
    return content;
  }
}

class _SetNicknameButton extends StatelessWidget {
  _SetNicknameButton({
    Key? key,
    required this.width,
    this.inputFormatters,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  final List<TextInputFormatter>? inputFormatters;
  String get backgroundUri => Global.getCheckInImageUrl("set_nickname_btn.png");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("修改名字");
        // var text = await SendCommentPage.show2<String>(context);
        // var text = await SendCommentPage.show<String>();
        // // _UpdateNickname();
        // print("修改名字 $text");
        logic.isUpdateNameFun(true);
      },
      child: GetBuilder<CheckInLogic>(
        id: "setNickname",
        builder: (logic) {
          return Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: width * 0.8,
                    child: !logic.isUpdateName
                        ? Text(
                            logic.currentNickName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Burbank',
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        : TextField(
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              hintText: '请输入nickname',
                              hintStyle: TextStyle(
                                fontFamily: 'Burbank',
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // onChanged: (text) {
                            onSubmitted: (text) {
                              print("输入改变时" + text);

                              logic.testUpd(text);

                              // final user = logic.userList.firstWhere(
                              //     (element) => element.id == logic.selectedId);
                              // logic.userListuser.nickname = text;

                              // final index = logic.userList.indexWhere(
                              //     (element) => element.id == logic.selectedId);
                              // logic.userList[index] = UserInfo(
                              //   id: logic.userList[index].id,
                              //   nickname: text,
                              //   avatarUrl: logic.currentUrl,
                              //   username: logic.userList[index].username,
                              //   isMale: logic.currentIsMale,
                              //   headgearId: logic.headId,
                              // );
                            },
                            style: TextStyle(
                              fontFamily: 'Burbank',
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                // SizedBox(
                //   width: width * 0.8,
                //   child: TextField(
                //     controller: TextEditingController(),
                //     decoration: InputDecoration(
                //       hintText: '请输入nickname',
                //     ),
                //     onChanged: (text) {
                //       print("输入改变时" + text);
                //     },
                //     // decoration: InputDecoration(
                //     //   label: Text(logic.currentNickName,
                //     //       style: const TextStyle(color: Colors.grey)),
                //     //   enabledBorder: const OutlineInputBorder(
                //     //     borderSide: BorderSide(color: Colors.white),
                //     //     borderRadius: BorderRadius.all(Radius.circular(24)),
                //     //   ),
                //     //   focusedBorder: const OutlineInputBorder(
                //     //     borderSide: BorderSide(color: Colors.white),
                //     //     borderRadius: BorderRadius.all(Radius.circular(24)),
                //     //   ),
                //     //   border: const OutlineInputBorder(
                //     //     borderSide: BorderSide(color: Colors.white),
                //     //     borderRadius: BorderRadius.all(Radius.circular(24)),
                //     //   ),
                //     // ),
                //     inputFormatters: [
                //       LengthLimitingTextInputFormatter(20),
                //       FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                //     ],
                //   ),
                // ),
                SizedBox(
                  width: 30.w,
                  child: Image.asset(
                    Global.getCheckInImageUrl("set_icon.png"),
                    width: 30.w,
                    height: 31.h,
                    fit: BoxFit.fill,
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

class _SaveAvatarButton extends StatelessWidget {
  _SaveAvatarButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getCheckInImageUrl("save_avatar_btn.png");

  get checkInApi => CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("保存avatar");
        await checkInApi.updatePlayerInfo(
            logic.selectedId ?? (logic.userList[0].id), logic.currentNickName, logic.headId, logic.currentIsMale);
        final index = logic.userList.indexWhere((element) => element.id == logic.selectedId);
        logic.userList[index] = UserInfo(
          id: logic.userList[index].id,
          nickname: logic.currentNickName,
          avatarUrl: logic.currentUrl,
          username: logic.userList[index].username,
          isMale: logic.currentIsMale,
          headgearId: logic.headId,
        );
        // logic.testSave();
        Get.dialog(
          Center(
            child: Container(
              width: 700.w,
              height: 150.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Global.getCheckInImageUrl("success_dialog.png")),
                  // fit: BoxFit.cover,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
      child: GetBuilder<CheckInLogic>(
        id: "saveAvatar",
        builder: (logic) {
          return Container(
            height: width * 0.24,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
            // child: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     // Text("Save avatar",
            //     //     textAlign: TextAlign.center,
            //     //     style: TextStyle(
            //     //       fontWeight: FontWeight.bold,
            //     //       fontSize: 36.sp,
            //     //       decoration: TextDecoration.none,
            //     //       fontFamily: 'Burbank',
            //     //       color: Color.fromARGB(255, 223, 227, 1),
            //     //       textBaseline: TextBaseline.ideographic,
            //     //     )),
            //     SizedBox(
            //       width: width,
            //       child: Text(
            //         "Save avatar",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           fontFamily: 'Burbank',
            //           color: const Color.fromARGB(255, 223, 227, 1),
            //           decoration: TextDecoration.none,
            //           fontSize: 36.sp,
            //           fontWeight: FontWeight.normal,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}

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

class _ModelShape extends StatelessWidget {
  _ModelShape({Key? key, required this.width, required this.bAnimate}) : super(key: key);
  final double width;
  final bool bAnimate;
  final logic = Get.find<CheckInLogic>();
  @override
  Widget build(BuildContext context) {
    final decorate = Stack(
      children: [
        Align(
          // alignment: const Alignment(0.225, -0.479),
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
                            width: width * 0.6,
                          )
                        : Image.asset(
                            Global.getCheckInImageUrl('avatar/Blue_man.png'),
                            width: width * 0.6,
                          ))
                    : (Global.team == 0
                        ? Image.asset(
                            Global.getCheckInImageUrl('avatar/Red_Women.png'),
                            width: width * 0.6,
                          )
                        : Image.asset(
                            Global.getCheckInImageUrl('avatar/Blue_Women.png'),
                            width: width * 0.6,
                          ));
              },
            ),
          ),
        ),
        Align(
          // alignment: const Alignment(0.225, -0.479),
          alignment: const Alignment(0.285, -0.739),
          child: GestureDetector(
            // 点击事件
            onTap: () {
              // print("单击返回");
            },
            child: GetBuilder<CheckInLogic>(
              id: "headPage",
              builder: (logic) {
                // return logic.currentUrl != ""
                //     ? CachedNetworkImage(
                //         imageUrl: logic.currentUrl,
                //         fit: BoxFit.fitWidth,
                //         width: width * 0.4,
                //       )
                //     : CachedNetworkImage(
                //         imageUrl: logic.userList[0].avatarUrl,
                //         fit: BoxFit.fitWidth,
                //         width: width * 0.4,
                //       );
                return Container(
                  // color: Colors.white,
                  width: 280.w,
                  height: 280.h,
                  child: logic.currentUrl != ""
                      ? CachedNetworkImage(
                          imageUrl: logic.currentUrl,
                          fit: BoxFit.fitWidth,
                          width: width * 0.6,
                        )
                      : CachedNetworkImage(
                          imageUrl: logic.avatarInfo[0].transparentBackgroundUrl,
                          // imageUrl: logic.userList[0].avatarUrl,
                          fit: BoxFit.fitWidth,
                          width: width * 0.6,
                        ),
                );
              },
            ),
          ),
          // child: Image.asset(
          //   Global.getCheckInImageUrl('avatar/ChipsHead.png'),
          //   width: width * 0.45,
          // ),
        ),
        // Align(
        //   alignment: const Alignment(0.22, 0.18),
        //   child: logic.currentIsMale
        //       ? Image.asset(
        //           Global.getCheckInImageUrl('avatar/Blue_man.png'),
        //           width: width * 0.45,
        //         )
        //       : Image.asset(
        //           Global.getCheckInImageUrl('avatar/Blue_Woman.png'),
        //           width: width * 0.45,
        //         ),
        // ),
      ],
    );
    return decorate;
  }
}

class _GoBackButton extends StatelessWidget {
  _GoBackButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getCheckInImageUrl("back_btn.png");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("单击返回");
        logic.checkInFun(false);
      },
      child: GetBuilder<CheckInLogic>(
        id: "goBack",
        builder: (logic) {
          return Container(
            height: width / 2,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
            // child: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Transform.translate(
            //       offset: const Offset(0, 0),
            //       child: Icon(
            //         Icons.play_arrow,
            //         size: width * 0.18,
            //         color: const Color(0xFFFFE350),
            //       ),
            //     ),
            //     SizedBox(width: width * 0.05),
            //     // content,
            //   ],
            // ),
          );
        },
      ),
    );
  }
}

class _RightView extends StatelessWidget {
  _RightView({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  List<Widget> children() {
    final result = <Widget>[];
    for (int i = 0; i < logic.avatarInfo.length; i++) {
      final item = logic.avatarInfo[i];
      final widget = GestureDetector(
        onTapUp: (detail) {
          logic.clickHead(item.id, item.transparentBackgroundUrl);
        },
        child: ParallelogramAvatar(width: 180.w, avatarUrl: item.url, isRequest: true),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Align(
        //           alignment: Alignment.center,
        //           child: ParallelogramAvatar(width: 180.w, avatarUrl: item.url, isRequest: true),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        // child: AvatarHeadPage(width: 180.w, avatarUrl: item.url),
      );
      result.add(widget);
    }
    print("哈哈哈哈哈: $result");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      width: 850.sp,
      height: 1.0.sh,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0.8, -0.9),
            child: _SummonButton(width: 144.w),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              width: 720.w,
              height: 715.h,
              Global.getCheckInImageUrl("set_avatar_bg.png"),
            ),
          ),
          Align(
            alignment: const Alignment(-0.70, -0.60),
            child: TextButton(
              child: const Text("HEAD"),
              onPressed: () {
                logic.clickCut("head");
              },
              //定义一下文本样式
              style: ButtonStyle(
                //更优美的方式来设置
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.focused) && !states.contains(MaterialState.pressed)) {
                      //获取焦点时的颜色
                      return Colors.blue;
                    } else if (states.contains(MaterialState.pressed)) {
                      //按下时的颜色
                      return Colors.deepPurple;
                    }
                    //默认状态使用灰色
                    return Colors.grey;
                  },
                ),
                //背景颜色
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blue[200];
                  }
                  //默认不使用背景颜色
                  return null;
                }),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.35, -0.60),
            child: TextButton(
              child: const Text("BODY"),
              onPressed: () {
                logic.clickCut("body");
              },
              //定义一下文本样式
              style: ButtonStyle(
                //更优美的方式来设置
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.focused) && !states.contains(MaterialState.pressed)) {
                      //获取焦点时的颜色
                      return Colors.blue;
                    } else if (states.contains(MaterialState.pressed)) {
                      //按下时的颜色
                      return Colors.deepPurple;
                    }
                    //默认状态使用灰色
                    return Colors.grey;
                  },
                ),
                //背景颜色
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blue[200];
                  }
                  //默认不使用背景颜色
                  return null;
                }),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 540.w,
              height: 450.h,
              child: GetBuilder<CheckInLogic>(
                id: "typePage",
                builder: (logic) {
                  if (logic.isAvatarType == "head") {
                    // return Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: children(),
                    // );
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[0].id, logic.avatarInfo[0].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[0].url, isRequest: true),
                                )
                                // child: ParallelogramAvatar(
                                //     width: 180.w,
                                //     avatarUrl: logic.avatarInfo[0].url, isRequest: true),
                                ),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[1].id, logic.avatarInfo[1].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[1].url, isRequest: true),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[2].id, logic.avatarInfo[2].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[2].url, isRequest: true),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[3].id, logic.avatarInfo[3].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[3].url, isRequest: true),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[4].id, logic.avatarInfo[4].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[4].url, isRequest: true),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[5].id, logic.avatarInfo[5].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[5].url, isRequest: true),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[6].id, logic.avatarInfo[6].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[6].url, isRequest: true),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[7].id, logic.avatarInfo[7].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[7].url, isRequest: true),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickHead(
                                        logic.avatarInfo[8].id, logic.avatarInfo[8].transparentBackgroundUrl);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 180.w, avatarUrl: logic.avatarInfo[8].url, isRequest: true),
                                )),
                          ],
                        ),
                      ],
                    );
                  } else {
                    print("kkkk嘎嘎嘎嘎是 ${logic.avatarInfo[0].url}");
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickBody(true);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 190.w,
                                      avatarUrl: Global.team == 0
                                          ? 'selection_panel/Red_man_s.png'
                                          : 'selection_panel/Blue_man_s.png',
                                      isRequest: false,
                                      isHigh: "high"),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTapUp: (detail) {
                                    logic.clickBody(false);
                                  },
                                  child: ParallelogramAvatar(
                                      width: 190.w,
                                      avatarUrl: Global.team == 0
                                          ? 'selection_panel/Red_Women_s.png'
                                          : 'selection_panel/Blue_Women_s.png',
                                      isRequest: false,
                                      isHigh: "high"),
                                )),
                            // Align(
                            //     alignment: Alignment.center,
                            //     child: GestureDetector(
                            //       onTapUp: (detail) {
                            //         logic.clickHead(logic.avatarInfo[2].id);
                            //       },
                            //       child: ParallelogramAvatar(
                            //           width: 180.w,
                            //           avatarUrl: 'avatar/Blue_Women.png',
                            //           isRequest: false),
                            //     )),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          // Align(
          //   alignment: const Alignment(0.0, 0.0),
          //   child: Text(
          //     'HEAD',
          //     style: TextStyle(
          //       fontFamily: 'Burbank',
          //       color: const Color.fromARGB(131, 189, 189, 189),
          //       decoration: TextDecoration.none,
          //       fontSize: 40.sp,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: children(),
          //   ),
          //   // child: Row(
          //   //   children: children(),
          //   // ),
          //   //   child: Stack(
          //   //     alignment: AlignmentDirectional.center,
          //   //     children: [
          //   //       Align(
          //   //   alignment: const Alignment(-0.2, -0.1),
          //   //   child: ClipPath(
          //   //     clipper: _HexagonalClipper(),
          //   //     child: SizedBox(
          //   //       height: 144.h,
          //   //       width: 180.w,
          //   //       child: CachedNetworkImage(
          //   //         imageUrl: avatarUrl,
          //   //         fit: BoxFit.fitHeight,
          //   //       ),
          //   //     ),
          //   //   ),
          //   // ),
          //   //     ],
          //   //   ),
          //   // child: SizedBox(
          //   //   width: 540.w,
          //   //   height: 450.h,
          //   //   child: Container(
          //   //     color: Colors.white,
          //   //     width: 180.w,
          //   //     height: 144.h,
          //   //     child: AvatarHeadPage(width: 180.w),
          //   //   ),
          //   //   // child: AvatarHeadPage(width: 180.w),
          //   // ),
          // ),
        ],
      ),
    );
    return content;
  }
}

class _SummonButton extends StatelessWidget {
  _SummonButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getCheckInImageUrl("summon_btn.png");
  // late final FlutterGifController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        logic.birdShow();
      },
      child: GetBuilder<CheckInLogic>(
        id: "summon",
        builder: (logic) {
          // return Container(
          //   height: width,
          //   width: width,
          //   child: Stack(children: [
          //     GifImage(
          //       width: width,
          //       height: width,
          //       controller: controller,
          //       image: AssetImage(Global.getGifUrl("answer_cell_expand.gif")),
          //       fit: BoxFit.fill,
          //     ),
          //   ]),
          // );
          return Container(
            height: width,
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
