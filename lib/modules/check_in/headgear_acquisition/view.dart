import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../data/show.dart';
import '../data/user_info.dart';
import '../home_page/booking_state.dart';
import '../player_page/new_player_page.dart';
import 'flip_card.dart';
import 'logic.dart';
import 'package:audioplayers/audioplayers.dart';

class HeadgearAcquisitionPage extends StatelessWidget {
  HeadgearAcquisitionPage({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(HeadgearAcquisitionLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GetBuilder<HeadgearAcquisitionLogic>(
                id: "headgearAcquisitionPage",
                builder: (logic) {
                  // return _TreasureChestWidget(showInfo: showInfo, customer: customer, headgearObj: headgearObj, userId: userId);
                  return _TreasureChestWidget(
                    showInfo: logic.showInfo,
                    customer: logic.customer,
                    headgearObj: logic.headgearObj,
                    userId: logic.userId,
                  );
                }),
          ],
    ));
  }
}

//宝箱图
class _TreasureChestWidget extends StatelessWidget {
  _TreasureChestWidget({
    Key? key,
    required this.showInfo,
    required this.customer,
    required this.headgearObj,
    required this.userId,
  }) : super(key: key);
  final ShowInfo showInfo;
  final Customer customer;
  final List headgearObj;
  final int userId;
  final logic = Get.find<HeadgearAcquisitionLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      height: 1.0.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
          fit: BoxFit.cover,
        ),
      ),
      child: _CardFlip(headgearObj: headgearObj),
    );
  }
}

class _CardFlip extends StatefulWidget {
  _CardFlip({Key? key, required this.headgearObj});
  final List headgearObj;
  @override
  _CardFlipState createState() => _CardFlipState();
}

class _CardFlipState extends State<_CardFlip> {
  final logic = Get.find<HeadgearAcquisitionLogic>();
  int? selectIndex;
  ShowInfo get showInfo => Get.arguments["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get userId => Get.arguments["userId"];
  int get tableId => Get.arguments["tableId"];

  // 创建音频播放器实例
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   width: 0.9.sw,
        //   margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Welcome Package",
        //         style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
        //       ),
        //       SizedBox(height: 10,),
        //       // Text(
        //       //   !logic.isClickCard
        //       //       ? "These exciting headwears options for your upcoming adventures."
        //       //       : "Gear Up for Glory! Choose Your Winning Headgear.",
        //       //   style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
        //       // ),
        //       Text(
        //         "Gear Up for Glory! Choose Your Winning Headgear.",
        //         style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 40.0),
          constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  // "Welcome Package",
                  "Hi," + logic.playerName,
                  style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Gear Up for Glory! Choose Your Winning Headgear.",
                  style: CustomTextStyles.textSmall(
                    color: Color(0xFFFFFFFF),
                    fontSize: 26.sp,
                  ),
                ),
                // child: Text(
                //   !logic.isClickCard
                //       ? "Gear Up for Glory! Choose Your Winning Headgear."
                //       : ("Hi," + logic.playerName + ", Choose Your Winning Headgear."),
                //   style: CustomTextStyles.textSmall(
                //     color: Color(0xFFFFFFFF),
                //     fontSize: 26.sp,
                //   ),
                // ),
              ),
            ],
          ),
        ),
        Container(
          width: 0.84.sw,
          margin: EdgeInsets.only(top: 0.1.sh, left: 0.08.sw, right: 0.08.sw),
          child: Row(
            children: List.generate(widget.headgearObj.length, (index) {
              return GestureDetector(
                onTapUp: (details) async {
                  await audioPlayer.release;
                  logic.clickSelectId = widget.headgearObj[index].id;
                  UserInfo userData = await logic.getCurrentUser(showInfo.showId, tableId, userId);
                  setState(() {
                    selectIndex = index;
                    logic.playerName = userData.nickname;
                    logic.isClickCard = true;
                  });
                  print("logic.clickSelectId ${logic.clickSelectId}");
                  // Future.delayed(0.5.seconds).then((value) async {
                  //   Get.offAll(() => NewPlayerPage(),
                  //       arguments: {
                  //         "userId": userId,
                  //         "headgearId": logic.clickSelectId,
                  //         "showInfo": showInfo,
                  //         "customer": customer,
                  //         "isAddPlayerClick": isAddPlayerClick,
                  //         "tableId": tableId,
                  //       });
                  // });
                },
                onTapDown: (details) async {
                  await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("card.wav")));
                },
                onTapCancel: () async {
                  await audioPlayer.release;
                },
                child: Container(
                  margin: EdgeInsets.only(right: index != widget.headgearObj.length - 1 ? 10 : 0),
                  child: HeadgearFlipCard(
                      width: (0.84.sw / 5) - ((10 * 4) / 5),
                      tableId: tableId,
                      url: widget.headgearObj[index].icon,
                      level: widget.headgearObj[index].level + 2,
                      bSelected: selectIndex == index ? true : false,
                      delay: Duration(milliseconds: 500 * index)),
                ),
              );
            }),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        // if (logic.isClickCard) _NextButton(width: 600.w),
        if (logic.isClickCard) CommonButton(
                                  width: 600.w,
                                  height: 100.h,
                                  btnText: 'NEXT',
                                  btnBgColor: Color(0xff13EFEF),
                                  textColor: Colors.black,
                                  onPress: () async {
                                    if (logic.clickSelectId != null && logic.isClickCard) {
                                      try {
                                        EasyLoading.dismiss(animation: false);
                                        UserInfo userData = await logic.getCurrentUser(showInfo.showId, tableId, userId);
                                        Get.offAll(() => NewPlayerPage(), arguments: {
                                          "userId": userId,
                                          "headgearId": logic.clickSelectId,
                                          "showInfo": showInfo,
                                          "bookingState": bookingState,
                                          "isAddPlayerClick": isAddPlayerClick,
                                          "tableId": tableId,
                                          "userData": userData,
                                        });
                                      } on DioException catch (e) {
                                        EasyLoading.dismiss();
                                        if (e.response == null) EasyLoading.showError("Network Error!");
                                        EasyLoading.showError(e.response?.data["error"]["message"]);
                                      }
                                    }
                                  },
                                  disable: logic.clickSelectId != null ? false : true,
                                  changedBgColor: Color(0xffA4EDF1),
                                ),
      ],
    );
  }
}
