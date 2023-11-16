import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/pages/check_in/logic.dart';
import 'package:interactive_board/pages/check_in/widgets/user_list.dart';

import '../../../app_routes.dart';

class AvatarDeaignPage extends StatelessWidget {
  AvatarDeaignPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Container(
    //         color: Color.fromARGB(255, 52, 231, 147),
    //       ),
    //       Transform.scale(
    //         scale: 1,
    //         child: SizedBox(
    //           width: 1.0.sw,
    //           child: Image.asset(
    //             Global.getCheckInImageUrl('background_line.png'),
    //             fit: BoxFit.fitHeight,
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         width: 1.0.sw,
    //         height: 1.0.sh,
    //         child: GetBuilder<CheckInLogic>(
    //           id: "page",
    //           builder: (logic) {
    //             return Row(
    //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 const _BgLeftView(),
    //                 UserList(
    //                   key: UniqueKey(),
    //                   width: 300.sp,
    //                   height: 1.0.sh,
    //                 ),
    //                 _PersonModel(key: UniqueKey(), width: 400.sp),
    //               ],
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );

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
                      return const Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _BgLeftView(),
                          // SizedBox(
                          //   width: 295.w,
                          //   height: 1.0.sh,
                          //   child: Stack(
                          //     children: [
                          //       Align(
                          //         alignment: const Alignment(-1.5, 1.5),
                          //         child: UserList(
                          //           key: UniqueKey(),
                          //           width: 295.w,
                          //           height: 800.sp,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          _MiddleView(),
                          // _PersonModel(key: UniqueKey(), width: 600.w),
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
      width: 365.sp,
      height: 1.0.sh,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.75, 1.85),
            child: UserList(
              key: UniqueKey(),
              width: 295.w,
              height: 800.sp,
            ),
          ),
          Align(
            alignment: const Alignment(-1.05, 0),
            child: Image.asset(
              Global.getCheckInImageUrl('bg_left.png'),
              fit: BoxFit.fitHeight,
              width: 70.sp,
            ),
          ),
          Align(
            alignment: const Alignment(-1, -1),
            child: _GoBackButton(width: 150.w),
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
      width: 600.w,
      height: 1.0.sh,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-1, -1),
            child: _PersonModel(width: 600.w),
          ),
          Align(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _SetNicknameButton(
                  width: 241.w,
                ),
                _SaveAvatarButton(
                  width: 181.w,
                ),
                //   Text("set nickname"),
                //   Text("save avatar"),
              ],
            ),
          ),
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
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getCheckInImageUrl("set_nickname_btn.png");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("修改名字");
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
                // Text("JOIN",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 36.sp,
                //       decoration: TextDecoration.none,
                //       fontFamily: 'Burbank',
                //       color: Colors.white,
                //       textBaseline: TextBaseline.ideographic,
                //     )),
                SizedBox(
                  width: width * 0.8,
                  child: Text(
                    logic.currentNickName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Burbank',
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("保存avatar");
      },
      child: GetBuilder<CheckInLogic>(
        id: "saveAvatar",
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
                // Text("Save avatar",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 36.sp,
                //       decoration: TextDecoration.none,
                //       fontFamily: 'Burbank',
                //       color: Color.fromARGB(255, 223, 227, 1),
                //       textBaseline: TextBaseline.ideographic,
                //     )),
                SizedBox(
                  width: width,
                  child: Text(
                    "Save avatar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Burbank',
                      color: const Color.fromARGB(255, 223, 227, 1),
                      decoration: TextDecoration.none,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.normal,
                    ),
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
  const _ModelShape({Key? key, required this.width, required this.bAnimate})
      : super(key: key);
  final double width;
  final bool bAnimate;
  @override
  Widget build(BuildContext context) {
    final decorate = Stack(
      children: [
        Align(
          alignment: const Alignment(0.33, -0.12),
          child: Image.asset(
            Global.getCheckInImageUrl('testHead.png'),
            width: width * 0.45,
          ),
        ),
        Align(
          alignment: const Alignment(0.15, 0.35),
          child: Image.asset(
            Global.getCheckInImageUrl('testBody.png'),
            width: width * 0.45,
          ),
        ),
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

  // Widget get content {
  //   final style = TextStyle(
  //     fontWeight: FontWeight.bold,
  //     fontSize: width * 0.1,
  //     decoration: TextDecoration.none,
  //     fontFamily: 'Burbank',
  //     color: Colors.black,
  //     textBaseline: TextBaseline.ideographic,
  //   );
  //   return Text("back", textAlign: TextAlign.center, style: style);
  // }

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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0, 0),
                  child: Icon(
                    Icons.play_arrow,
                    size: width * 0.18,
                    color: const Color(0xFFFFE350),
                  ),
                ),
                SizedBox(width: width * 0.05),
                // content,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RightView extends StatelessWidget {
  const _RightView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      width: 850.sp,
      height: 1.0.sh,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(1.0, -0.9),
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
            alignment: const Alignment(0.0, 0.0),
            child: Text(
              'HEAD',
              style: TextStyle(
                fontFamily: 'Burbank',
                color: const Color.fromARGB(131, 189, 189, 189),
                decoration: TextDecoration.none,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("点击雨林");
      },
      child: GetBuilder<CheckInLogic>(
        id: "summon",
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
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
