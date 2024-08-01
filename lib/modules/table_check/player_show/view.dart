import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../data/model/show_state.dart';
import '../../../widgets/check_in_title.dart';
import '../../add_player/view.dart';
import '../terms_use/view.dart';
import 'logic.dart';
import '../../mirra_look/player_look.dart';

class PlayerShowPage extends StatelessWidget {
  PlayerShowPage({Key? key}) : super(key: key);
  final logic = Get.put(PlayerShowPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<PlayerShowPageLogic>(
            id: "playerShowPage",
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
                    // Container(
                    //   width: 0.92.sw,
                    //   margin: EdgeInsets.only(top: 40.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "Home Page",
                    //         style: CustomTextStyles.title(
                    //             color: Colors.white, fontSize: 48.sp, level: 2),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // 顶部文本信息
                    CheckInTitlePage(
                      titleText: 'Homepage',
                    ),
                    SizedBox(height: 20.0,),
                    _SquadCard(),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 45,
            child: Container(
              width: 1.0.sw,
              child: Center(
                child: Text(
                  'Game Show Coming Soon',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.textBig(
                      color: Colors.white, fontSize: 30.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SquadCard extends StatelessWidget {
  final logic = Get.put(PlayerShowPageLogic());
  Color get color {
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
  // 浅色
  Color get lightColor {
    if (Global.tableId == 1) {
      return const Color(0xFFE6BC9C);
    } else if (Global.tableId == 2) {
      return const Color(0xFFE8B6E0);
    } else if (Global.tableId == 3) {
      return const Color(0xFFBCDBBC);
    } else {
      return const Color(0xFFC5D4E6);
    }
  }
  // 深色
  Color get darkColor {
    if (Global.tableId == 1) {
      return const Color(0xFFCB8C5E);
    } else if (Global.tableId == 2) {
      return const Color(0xFFBB7EB1);
    } else if (Global.tableId == 3) {
      return const Color(0xFF81AE81);
    } else {
      return const Color(0xFF85AEDE);
    }
  }
  String get bayString {
    if (Global.tableId == 1) {
      return "A";
    } else if (Global.tableId == 2) {
      return "B";
    } else if (Global.tableId == 3) {
      return "C";
    } else {
      return "D";
    }
  }
  int num = 0;
  ShowState get showState => Get.arguments["showState"];
  // List<PlayerCardInfo> get playerCardInfo => Get.arguments?["playerCardInfo"];
  // String get teamlogo => Get.arguments?["teamlogo"];

  @override
  Widget build(BuildContext context) {
    for(int m = 0; m < logic.playerCardInfo.length; m++){
      if(logic.playerCardInfo[m].isUserCard) {
        num++;
      }
    }
    print("logic.playerCardInfo ${logic.playerCardInfo}");

    // double parentWidth = MediaQuery.of(context).size.width; // 父级的宽度
    // print("parentWidth ${parentWidth}");
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
                crossAxisSpacing: 5.0, // 设置列之间的间距
                mainAxisSpacing: 5.0, // 行之间的间距
                childAspectRatio: 0.714, // 设置卡片宽高比
                children: logic.playerCardInfo.map((card) {
                  return GestureDetector(
                    onTap: () async {
                      print("点击了卡牌 ${card.isUserCard}");
                      // 处理卡片点击事件
                      if (!card.isUserCard) {
                        // 点击非用户卡片时的逻辑
                        print("新增用户");
                        logic.refreshFun();
                        // await Get.to(() => TermsOfUseInfo(), arguments: {"showState": showState});
                        await Get.to(() => UserAuthenticator(),
                            arguments: {
                              "isAddPlayerClick": true,
                              "showState": showState,
                              "isFlow": "tableCheck",
                            });
                      }
                      else {
                        try {
                          print("设计形象");
                          logic.getGameItems(card.userId, card.avatarId);
                          await Future.delayed(300.ms);
                          logic.refreshFun();
                          await Future.delayed(100.ms);
                          print("logic.gameItemInfo ${logic.gameItemInfo}");
                          EasyLoading.dismiss(animation: false);
                          Get.offAll(() => PlayerLookPage(),
                              arguments: {
                                "gameItemInfo": logic.gameItemInfo,
                                "showState": showState,
                                "card": card,
                                "isAddPlayerClick": true,
                                "tableId": Global.tableId
                              });
                        } on DioException catch (e) {
                          EasyLoading.dismiss();
                          if (e.response == null) EasyLoading.showError("Network Error!");
                          EasyLoading.showError(e.response?.data["error"]["message"]);
                        }

                        // print("设计形象");
                        // logic.getGameItems(card.userId, card.avatarId);
                        // await Future.delayed(300.ms);
                        // logic.refreshFun();
                        // await Future.delayed(100.ms);
                        // print("logic.gameItemInfo ${logic.gameItemInfo}");
                        // Get.offAll(() => PlayerLookPage(),
                        //     arguments: {
                        //       "gameItemInfo": logic.gameItemInfo,
                        //       "showState": showState,
                        //       "card": card,
                        //       "isAddPlayerClick": true});
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
                                        height: 196,
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
                                  height: 196,
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
            child: Container(decoration: BoxDecoration(
              color: Colors.blue, // 设置背景色
            ),),
          ),
        ],
      ),
    );
  }
}