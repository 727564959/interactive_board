import 'dart:async';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';

import '../../mirra_style.dart';
import '../../pages/check_in/logic.dart';
import '../../pages/check_in/widgets/after_checkIn/player_info_show.dart';
import '../../widgets/check_in_title.dart';
import 'data/setAvatar_api.dart';
import 'logic.dart';
import 'widgets/avatar_design.dart';
import 'widgets/avatar_model.dart';

class AvatarDesignPage extends StatelessWidget {
  AvatarDesignPage({Key? key}) : super(key: key);
  final logic = Get.find<SetAvatarLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 1.0.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                children: [
                  SizedBox(
                    width: 1.0.sw,
                    child: GetBuilder<SetAvatarLogic>(
                      builder: (logic) {
                        return Column(
                          children: [
                            // 顶部文本信息
                            CheckInTitlePage(titleText: "Mirra Look"),
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
          ),
          Positioned(
            left: 0.0.sw,
            top: 0.8.sh,
            child: SizedBox(
              width: 0.4.sw,
              child: Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "After saving,",
                      style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 30.sp),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "changes apply in the next game.",
                      style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 30.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // return GestureDetector(
    //   child: GetBuilder<SetAvatarLogic>(
    //     id: "avatarHomePage",
    //     builder: (logic) {
    //       return Container(
    //         width: 1.0.sw,
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         child: Column(
    //           children: [
    //             SizedBox(
    //               width: 1.0.sw,
    //               child: GetBuilder<SetAvatarLogic>(
    //                 builder: (logic) {
    //                   return Column(
    //                     children: [
    //                       // 顶部文本信息
    //                       CheckInTitlePage(titleText: "Mirra Look"),
    //                       // 中间的用户信息和avatar信息
    //                       _SetAvatarContent(),
    //                       // 底部的功能按钮
    //                       // _SetAvatarBtnInfo(),
    //                     ],
    //                   );
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
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
      height: 0.85.sh,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                child: Column(
                  children: [
                    SizedBox(
                      width: 0.23.sw,
                      height: 0.2.sh,
                      child: GetBuilder<SetAvatarLogic>(
                        id: 'editNickname',
                        builder: (logic) {
                          return Row(
                            children: [
                              _EditNicknameText(),
                            ],
                          );
                        },
                      ),
                    ),
                    // SizedBox(
                    //   width: 0.23.sw,
                    //   child: Align(
                    //     alignment: const Alignment(-0.6, 0.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         SizedBox(height: 50),
                    //         Text(
                    //           "After saving,",
                    //           style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 30.sp),
                    //         ),
                    //         SizedBox(height: 10,),
                    //         Text(
                    //           "changes apply in the next game.",
                    //           style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 30.sp),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   // height: 0.35.sh,
                    //   // child: GetBuilder<SetAvatarLogic>(
                    //   //   builder: (logic) {
                    //   //     return Column(
                    //   //       children: [
                    //   //         Container(
                    //   //           margin: EdgeInsets.only(top: 20.0, left: 20.0),
                    //   //           child: SizedBox(
                    //   //             width: 0.24.sw,
                    //   //             child: Text(
                    //   //               "After saving,",
                    //   //               style: TextStyle(
                    //   //                 fontSize: 32.sp,
                    //   //                 decoration: TextDecoration.none,
                    //   //                 fontFamily: 'BurbankBold',
                    //   //                 color: Colors.white,
                    //   //                 letterSpacing: 3.sp,
                    //   //               ),
                    //   //             ),
                    //   //           ),
                    //   //         ),
                    //   //         Container(
                    //   //           margin: EdgeInsets.only(top: 0.0, left: 20.0),
                    //   //           child: SizedBox(
                    //   //             width: 0.24.sw,
                    //   //             child: Text(
                    //   //               "changes apply",
                    //   //               style: TextStyle(
                    //   //                 fontSize: 32.sp,
                    //   //                 decoration: TextDecoration.none,
                    //   //                 fontFamily: 'BurbankBold',
                    //   //                 color: Colors.white,
                    //   //                 letterSpacing: 3.sp,
                    //   //               ),
                    //   //             ),
                    //   //           ),
                    //   //         ),
                    //   //         Container(
                    //   //           margin: EdgeInsets.only(top: 0.0, left: 20.0),
                    //   //           child: SizedBox(
                    //   //             width: 0.24.sw,
                    //   //             child: Text(
                    //   //               "in the next game.",
                    //   //               style: TextStyle(
                    //   //                 fontSize: 32.sp,
                    //   //                 decoration: TextDecoration.none,
                    //   //                 fontFamily: 'BurbankBold',
                    //   //                 color: Colors.white,
                    //   //                 letterSpacing: 3.sp,
                    //   //               ),
                    //   //             ),
                    //   //           ),
                    //   //         ),
                    //   //       ],
                    //   //     );
                    //   //   },
                    //   // ),
                    // ),
                    // _SaveAndBackButton(width: 384.w),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(-1, -1),
                child: _PersonModel(width: 700.w),
              ),
              Align(
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.grey,
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  margin: EdgeInsets.only(top: 0.0, left: 0.0),
                  constraints: BoxConstraints.tightFor(width: 0.34.sw), //卡片大小
                  // child: AvatarModel(),
                  child: Column(
                    children: [
                      AvatarDesign(),
                      _SaveAndBackButton(width: 384.w)
                    ],
                  ),
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
  final logic = Get.find<SetAvatarLogic>();
  // TextEditingController _nameTextFieldController = new TextEditingController(text: "testststs");

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
    print("ppp ${logic.singlePlayer['name']}");
    print("ppp ${logic.currentNickName}");
    // TextEditingController _nameTextFieldController = new TextEditingController(text: logic.singlePlayer['name']);
    TextEditingController _nameTextFieldController = new TextEditingController(text: logic.currentNickName);
    return Container(
      margin: EdgeInsets.only(top: 0.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 428.w, height: 118.h), //卡片大小
      child: TextField(
        controller: _nameTextFieldController,
        decoration: InputDecoration(
          // hintText: logic.currentNickName,
          // border: InputBorder.none,
          // fillColor: Colors.deepOrangeAccent,

          // fillColor: Color(0xffFFBD80),
          fillColor: color,
          filled: true,
          suffixIcon: Icon(
            Icons.edit,
            size: 40,
          ),
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
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
  _ModelShape({Key? key, required this.width, required this.bAnimate}) : super(key: key);
  final double width;
  final bool bAnimate;
  final logic = Get.find<SetAvatarLogic>();
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
            child: GetBuilder<SetAvatarLogic>(
              id: "bodyPage",
              builder: (logic) {
                print("wwww ${logic.currentIsMale}");
                return logic.currentBodyUrl != ""
                    ? CachedNetworkImage(
                        imageUrl: logic.currentBodyUrl,
                        fit: BoxFit.fitWidth,
                        width: width * 0.5,
                      )
                    : CachedNetworkImage(
                        imageUrl: logic.gameItemInfoBody[0].icon,
                        fit: BoxFit.fitWidth,
                        width: width * 0.5,
                      );
                // return logic.currentIsMale
                //     ? CachedNetworkImage(
                //       imageUrl: logic.gameItemInfoBody[0].icon,
                //       fit: BoxFit.fitWidth,
                //       width: width * 0.5,
                //     ) : CachedNetworkImage(
                //       imageUrl: logic.gameItemInfoBody[1].icon,
                //       fit: BoxFit.fitWidth,
                //       width: width * 0.5,
                //     );
                // return logic.currentIsMale
                //     ? (Global.team == 0
                //         ? Image.asset(
                //             Global.getCheckInImageUrl('avatar/Red_man.png'),
                //             width: width * 0.5,
                //           )
                //         : Image.asset(
                //             Global.getCheckInImageUrl('avatar/Blue_man.png'),
                //             width: width * 0.5,
                //           ))
                //     : (Global.team == 0
                //         ? Image.asset(
                //             Global.getCheckInImageUrl('avatar/Red_Women.png'),
                //             width: width * 0.5,
                //           )
                //         : Image.asset(
                //             Global.getCheckInImageUrl('avatar/Blue_Women.png'),
                //             width: width * 0.5,
                //           ));
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
            child: GetBuilder<SetAvatarLogic>(
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
                          // imageUrl: logic.avatarInfo[0].url,
                          imageUrl: logic.gameItemInfoHead[0].icon,
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
  final logic = Get.find<SetAvatarLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("save_and_back_btn.png");

  final testTabId = Global.tableId;

  final setAvatarApi = SetAvatarApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        int num2 = int.parse(logic.headId.toString());
        print("num2：$num2");
        print("currentNickName：${logic.currentNickName}");
        print("showState：${Get.arguments}");
        print("logic.singlePlayer：${logic.singlePlayer['id']}");
        print("logic.currentIsMale：${logic.currentIsMale}");

        // await setAvatarApi.updatePlayer(logic.singlePlayer['id'],
        //     logic.currentNickName, num2, logic.currentIsMale ? 10 : 11);
        await setAvatarApi.updatePlayer(
            logic.singlePlayer['id'], logic.currentNickName, num2, int.parse(logic.currentIsMale));
        // Map<String, dynamic> jsonObj = {
        //   "userId": logic.singlePlayer['id'],
        //   "showId": logic.newAddUser.showId,
        //   "status": logic.newAddUser.status
        // };
        // Get.put(CheckInLogic());
        // print("参数：${Get.arguments}");
        // logic.updateUserList(int.parse(logic.newAddUser.showId.toString()));

        Get.find<CheckInLogic>().updateUserList(int.parse(logic.newAddUser.showId.toString()));
        Get.find<CheckInLogic>().updatePlayer(logic.newAddUser.userId.toString());
        Get.to(() => PlayerInfoShow(), arguments: await setAvatarApi.fetchShowState());
      },
      child: GetBuilder<SetAvatarLogic>(
        id: "saveAndBackBtn",
        builder: (logic) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff13EFEF),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.only(top: 50.0, left: 0.0),
            constraints: BoxConstraints.tightFor(width: width, height: 80.h),
            child: Center(
              child: Text(
                "SAVE AND BACK",
                textAlign: TextAlign.center,
                style: CustomTextStyles.button(color: Colors.black, fontSize: 28.sp),
              ),
            ),
          );
          // return Container(
          //   height: 100.sh,
          //   width: width,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(backgroundUri),
          //       fit: BoxFit.fitWidth,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
