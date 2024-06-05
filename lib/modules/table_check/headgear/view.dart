import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../data/model/show_state.dart';
import '../../../widgets/common_button.dart';
import '../../check_in/headgear_acquisition/flip_card.dart';
import '../data/user_info.dart';
import '../player_show/new_player_page.dart';
import 'logic.dart';

class HeadgearPage extends StatelessWidget {
  HeadgearPage({
    Key? key,
  }) : super(key: key);
  final logic = Get.put(HeadgearLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GetBuilder<HeadgearLogic>(
                id: "headgearPage",
                builder: (logic) {
                  return _TreasureChestWidget(
                    showState: logic.showState,
                    headgearObj: logic.headgearObj,
                    userId: logic.userId,
                  );
                }
            ),
          ],
        ));
  }
}

//宝箱图
class _TreasureChestWidget extends StatelessWidget {
  _TreasureChestWidget({
    Key? key,
    required this.showState,
    required this.headgearObj,
    required this.userId,
  }) : super(key: key);
  final ShowState showState;
  final List headgearObj;
  final int userId;
  final logic = Get.find<HeadgearLogic>();

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
  final logic = Get.find<HeadgearLogic>();
  int? selectIndex;
  ShowState get showState => Get.arguments["showState"];
  int get userId => Get.arguments["userId"];

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
                //     fontSize: 26.sp,),
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
                onTap: () async {
                  logic.clickSelectId = widget.headgearObj[index].id;
                  UserInfo userData = await logic.getCurrentUser(showState.showId, Global.tableId, userId);
                  setState(() {
                    selectIndex = index;
                    logic.playerName = userData.nickname;
                    logic.isClickCard = true;
                  });
                  print("logic.clickSelectId ${logic.clickSelectId}");
                  // Future.delayed(0.5.seconds).then((value) async {
                  //   Get.offAll(() => NewPlayerInfoPage(),
                  //       arguments: {
                  //         "userId": userId,
                  //         "headgearId": logic.clickSelectId,
                  //         "showState": showState});
                  // });
                },
                child: Container(
                  margin: EdgeInsets.only(right: index != widget.headgearObj.length - 1 ? 10 : 0),
                  child: HeadgearFlipCard(width: (0.84.sw / 5) - ((10 * 4) / 5), tableId: Global.tableId, url: widget.headgearObj[index].icon, level: widget.headgearObj[index].level + 2, bSelected: selectIndex == index ? true : false, delay: Duration(milliseconds: 500 * index)),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 50,),
        // if(logic.isClickCard) _NextButton(width: 600.w),
        if (logic.isClickCard) CommonButton(
          width: 600.w,
          height: 100.h,
          btnText: 'NEXT',
          btnBgColor: Color(0xff13EFEF),
          textColor: Colors.black,
          onPress: () async {
            if(logic.clickSelectId != null && logic.isClickCard) {
              try {
                EasyLoading.dismiss(animation: false);
                UserInfo userData = await logic.getCurrentUser(showState.showId, Global.tableId, userId);
                Get.offAll(() => NewPlayerInfoPage(),
                    arguments: {
                      "userId": userId,
                      "headgearId": logic.clickSelectId,
                      "showState": showState,
                      "userData": userData,});
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

class _NextButton extends StatelessWidget {
  _NextButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  ShowState get showState => Get.arguments["showState"];
  int get userId => Get.arguments["userId"];
  final logic = Get.find<HeadgearLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        if(logic.clickSelectId != null && logic.isClickCard) {
          try {
            EasyLoading.dismiss(animation: false);
            UserInfo userData = await logic.getCurrentUser(showState.showId, Global.tableId, userId);
            Get.offAll(() => NewPlayerInfoPage(),
                arguments: {
                  "userId": userId,
                  "headgearId": logic.clickSelectId,
                  "showState": showState,
                  "userData": userData,});
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: (logic.clickSelectId != null && logic.isClickCard) ? Color(0xff13EFEF) : Color(0xff9B9B9B),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
        child: Center(
          child: Text(
            "NEXT",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}