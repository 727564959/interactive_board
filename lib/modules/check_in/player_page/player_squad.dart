import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mirra_style.dart';
import '../../../widgets/custom_countdown.dart';
import '../complete_page/view.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../terms_page/view.dart';
import 'add_dialog.dart';
import 'logic.dart';
import '../../mirra_look/player_look.dart';

import 'package:audioplayers/audioplayers.dart';

class PlayerSquadPage extends StatelessWidget {
  PlayerSquadPage({Key? key}) : super(key: key);
  final logic = Get.put(PlayerShowLogic());
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    print("isAddPlayerClick ${isAddPlayerClick}");
    if(!isAddPlayerClick) Future.delayed(Duration.zero, () {
      Get.dialog(Dialog(child: AddDialog()), arguments: {"tableId": tableId,}).then((value) {
        logic.isCountdownStart = true;
        logic.testFun();
      });
    });
    print("isCountdownStart ${logic.isCountdownStart}");
    if(isAddPlayerClick && !logic.isCountdownStart) {
      logic.isCountdownStart = true;
    }

    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<PlayerShowLogic>(
            id: "playerSquadPage",
            builder: (logic) {
              return Container(
                width: 1.0.sw,
                height: 1.0.sh,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MirraIcons.getSetAvatarIconPath(
                        "interactive_board_bg.png")),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 1.0.sw,
                      margin: EdgeInsets.only(top: 20.0, left: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Homepage",
                            style: CustomTextStyles.title(
                                color: Colors.white, fontSize: 48.sp, level: 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    _SquadCard(),
                    SizedBox(height: 10.0,),
                    _DoneButton(width: 600.w, isCountdownStart: logic.isCountdownStart),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SquadCard extends StatelessWidget {
  final logic = Get.put(PlayerShowLogic());
  int get tableId => Get.arguments["tableId"];
  Color get color {
    if (tableId == 1) {
      // background: #FFBD80;
      return const Color(0xFFFFBD80);
    } else if (tableId == 2) {
      // background: #EFB5FD;
      return const Color(0xFFEFB5FD);
    } else if (tableId == 3) {
      // background: #8EE8BD;
      return const Color(0xFF8EE8BD);
    } else {
      // background: #9ED7F7;
      return const Color(0xFF9ED7F7);
    }
  }
  // 浅色
  Color get lightColor {
    if (tableId == 1) {
      return const Color(0xFFE6BC9C);
    } else if (tableId == 2) {
      return const Color(0xFFE8B6E0);
    } else if (tableId == 3) {
      return const Color(0xFFBCDBBC);
    } else {
      return const Color(0xFFC5D4E6);
    }
  }
  // 深色
  Color get darkColor {
    if (tableId == 1) {
      return const Color(0xFFCB8C5E);
    } else if (tableId == 2) {
      return const Color(0xFFBB7EB1);
    } else if (tableId == 3) {
      return const Color(0xFF81AE81);
    } else {
      return const Color(0xFF85AEDE);
    }
  }
  String get bayString {
    if (tableId == 1) {
      return "A";
    } else if (tableId == 2) {
      return "B";
    } else if (tableId == 3) {
      return "C";
    } else {
      return "D";
    }
  }
  int num = 0;

  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];

  @override
  Widget build(BuildContext context) {
    for(int m = 0; m < logic.playerCardInfo.length; m++){
      if(logic.playerCardInfo[m].isUserCard) {
        num++;
      }
    }
    print("logic.playerCardInfo ${logic.playerCardInfo}");
    return Container(
      child: Row(
        children: [
          // 左侧布局
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 190,
                    height: 232,
                    padding: EdgeInsets.symmetric(vertical: 10.0), // 调整上下间距为10
                    child: CachedNetworkImage(
                      imageUrl: logic.teamlogo,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text(
                    'Squad ' + bayString,
                    style: CustomTextStyles.title(color: Color(0xFFFFFFFF), fontSize: 40.sp, level: 3),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    num.toString() + ' / 8',
                    style: CustomTextStyles.textNormal(color: Color(0xFFFFFFFF), fontSize: 24.sp),
                  ),
                ],
              ),
            ),
          ),
          // 右侧布局
          Expanded(
            flex: 4,
            child: Container(
              height: 0.65.sh,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0, // 设置列之间的间距
                mainAxisSpacing: 10.0, // 行之间的间距
                childAspectRatio: 0.7, // 设置卡片宽高比
                children: logic.playerCardInfo.map((card) {
                  return GestureDetector(
                    onTap: () async {
                      print("点击了卡牌 ${card.isUserCard}");
                      logic.isCountdownStart = false;
                      // 处理卡片点击事件
                      if (!card.isUserCard) {
                        // 点击非用户卡片时的逻辑
                        print("新增用户");
                        logic.testFun();
                        await Get.to(() => TermsOfUsePage(),
                            arguments: {
                              "isAddPlayerClick": true,
                              "showInfo": showInfo,
                              "customer": customer,
                              "tableId": tableId,
                            });
                      }
                      else {
                        print("设计形象");
                        EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                        try {
                          EasyLoading.dismiss(animation: false);
                          logic.getGameItems(card.userId, card.avatarId);
                          // logic.currentName = card.nickname??"";
                          // logic.currentUserId = card.userId??null;
                          logic.testFun();
                          // logic.refreshPlayerLook(card.userId, card.avatarId);
                          await Future.delayed(100.ms);
                          print("logic.gameItemInfo ${logic.gameItemInfo}");
                          Get.offAll(() => PlayerLookPage(),
                              arguments: {
                                "gameItemInfo": logic.gameItemInfo,
                                "showInfo": showInfo,
                                "customer": customer,
                                "card": card,
                                "isAddPlayerClick": isAddPlayerClick,
                                "tableId": tableId
                              });
                        } on DioException catch (e) {
                          EasyLoading.dismiss();
                          if (e.response == null) EasyLoading.showError("Network Error!");
                          EasyLoading.showError(e.response?.data["error"]["message"]);
                        }
                      }
                    },
                    child: Card(
                      child: card.isUserCard
                          ? Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  // gradient: RadialGradient(
                                  //   center: Alignment.center,
                                  //   radius: 0.5,
                                  //   colors: [
                                  //     lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
                                  //     darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
                                  //   ],
                                  // ),
                                  color: color,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top: 10.0),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        gradient: RadialGradient(
                                          center: Alignment.center,
                                          radius: 0.5,
                                          colors: [
                                            lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
                                            darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
                                          ],
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        height: 200,
                                        imageUrl: card.avatarIcon ?? '',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Container(
                                      height: 2.0,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      // padding: EdgeInsets.all(0),
                                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Text(
                                        card.nickname ?? '',
                                        maxLines: 1, // 最大显示行数
                                        overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                                        style: CustomTextStyles.title(color: Color(0xFF000000), fontSize: 34.sp, level: 5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              // gradient: RadialGradient(
                              //   center: Alignment.center,
                              //   radius: 0.5,
                              //   colors: [
                              //     lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
                              //     darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
                              //   ],
                              // ),
                              color: color,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 10.0),
                                  // decoration: BoxDecoration(
                                  //   borderRadius: const BorderRadius.only(
                                  //     topLeft: Radius.circular(10),
                                  //     topRight: Radius.circular(10),
                                  //   ),
                                  //   gradient: RadialGradient(
                                  //     center: Alignment.center,
                                  //     radius: 0.5,
                                  //     colors: [
                                  //       lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
                                  //       darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
                                  //     ],
                                  //   ),
                                  // ),
                                  // height: 190,
                                  // child: Icon(Icons.add, color: Colors.white, size: 60,),
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: RadialGradient(
                                                center: Alignment.center,
                                                radius: 0.5,
                                                colors: [
                                                  lightColor.withOpacity(1.0),
                                                  darkColor.withOpacity(1.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 2.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    card.nickname ?? '',
                                    maxLines: 1, // 最大显示行数
                                    overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                                    style: CustomTextStyles.title(color: Color(0xFF000000), fontSize: 34.sp, level: 5),
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _DoneButton extends StatefulWidget {
  _DoneButton({
    Key? key,
    required this.width,
    required this.isCountdownStart
  }) : super(key: key);
  final double width;
  final bool isCountdownStart;

  @override
  _DoneButtonState createState() => _DoneButtonState();
}
class _DoneButtonState extends State<_DoneButton> {
  double get width => widget.width;
  bool get isCountdownStart => widget.isCountdownStart;
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  int get tableId => Get.arguments["tableId"];
  bool isChangeBgColor = false;

  // 创建音频播放器实例
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTapUp: (details) async {
        await audioPlayer.release;
        setState(() {
          isChangeBgColor = false;
        });
        await Get.to(
              () => const CompletePage(),
          arguments: {"tableId": tableId, "startTime": showInfo.startTime, "customer": customer},
          preventDuplicates: false,
        );
      },
      onTapDown: (details) async {
        await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("normal_click.wav")));
        setState(() {
          isChangeBgColor = true;
        });
      },
      onTapCancel: () async {
        // 手指离开区域的处理逻辑
        print('onTapCancel');
        await audioPlayer.release;
        setState(() {
          isChangeBgColor = !isChangeBgColor;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isChangeBgColor ? Color(0xffA4EDF1) : Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 子项水平居中对齐
            children: [
              Text(
                "DONE",
                textAlign: TextAlign.center,
                style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
              ),
              SizedBox(width: 5.0,),
              CustomCountdown(
                duration: Duration(seconds: 60),
                color: Color(0xff000000),
                start: isCountdownStart,
                onCountdownComplete: () async {
                  await Get.to(
                        () => const CompletePage(),
                    arguments: {"tableId": tableId, "startTime": showInfo.startTime, "customer": customer},
                    preventDuplicates: false,
                  );
                },
              ),
              // if(isCountdownStart) Countdown(
              //   seconds: 60,
              //   build: (context, time) => TextButton(
              //       onPressed: () {},
              //       child: Text(
              //         "(" + "${time.toInt()}s" + ")",
              //         style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
              //       )),
              //   onFinished: () async {
              //     await Get.to(
              //           () => const CompletePage(),
              //       arguments: {"tableId": tableId, "startTime": showInfo.startTime, "customer": customer},
              //       preventDuplicates: false,
              //     );
              //   },
              // ),
              // if(!isCountdownStart) Text(
              //   "(60s)",
              //   textAlign: TextAlign.center,
              //   style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}