import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../data/avatar_info.dart';
import '../data/show.dart';
import '../headgear_acquisition/view.dart';
import '../home_page/booking_state.dart';
import '../player_page/player_squad.dart';
import 'logic.dart';
import 'package:audioplayers/audioplayers.dart';

class GroupIconSetPage extends StatelessWidget {
  GroupIconSetPage({Key? key}) : super(key: key);
  final logic = Get.put(GroupIconSetLogic());
  ShowInfo get showInfo => Get.arguments["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments["tableId"];

  // 创建音频播放器实例
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    print('Screen Width: $screenWidth');
    print('Screen Height: $screenHeight');
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0, left: 40.0),
                    constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Squad Settings",
                            style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 2),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Please Choose Your Squad Badge",
                            style: CustomTextStyles.textSmall(
                              color: Color(0xFFFFFFFF),
                              fontSize: 26.sp,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.08.sh),
                  SizedBox(
                    child: GetBuilder<GroupIconSetLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 0.0, left: 0.26.sw),
                              // constraints: BoxConstraints.tightFor(width: 0.2.sw, height: 0.5.sh),//卡片大小
                              constraints: BoxConstraints.tightFor(width: 0.21.sw, height: 0.5.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Container(
                                    width: 0.21.sw,
                                    height: 0.06.sh,
                                    child: logic.teamName == logic.teamInfo[0].name ?
                                    Image.asset(
                                      MirraIcons.getSetAvatarIconPath('group_setting_select.png'),
                                      fit: BoxFit.fitHeight,
                                    ) : null,
                                  ),
                                  Container(
                                    width: 0.21.sw,
                                    height: 0.37.sh,
                                    margin: EdgeInsets.only(top: 0.02.sh),
                                    decoration: BoxDecoration(
                                      // color: logic.teamName == logic.teamInfo[0].name ? Color(0xFF5E6F96) : null,
                                      color: logic.teamName == logic.teamInfo[0].name ? Color(0xFFffffff).withOpacity(0.08) : null,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: GestureDetector(
                                      onTapUp: (details) async {
                                        print("object 选择队伍icon 0");
                                        await audioPlayer.release;
                                        logic.selectTeamIcon(logic.teamInfo[0].name, 0);
                                      },
                                      onTapDown: (details) async {
                                        await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("card.wav")));
                                      },
                                      onTapCancel: () async {
                                        await audioPlayer.release;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30), // 调整上下间距为10
                                        child: CachedNetworkImage(
                                          imageUrl: logic.teamInfo[0].iconPath,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.0, right: 0.26.sw),
                              constraints: BoxConstraints.tightFor(width: 0.21.sw, height: 0.5.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Container(
                                    width: 0.21.sw,
                                    height: 0.06.sh,
                                    child: logic.teamName == logic.teamInfo[1].name ?
                                    Image.asset(
                                      Global.getSetAvatarImageUrl('group_setting_select.png'),
                                      fit: BoxFit.fitHeight,
                                    ) : null,
                                  ),
                                  Container(
                                    width: 0.21.sw,
                                    height: 0.37.sh,
                                    margin: EdgeInsets.only(top: 0.02.sh),
                                    decoration: BoxDecoration(
                                      color: logic.teamName == logic.teamInfo[1].name ? Color(0xFFffffff).withOpacity(0.08) : null,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: GestureDetector(
                                      onTapUp: (details) async {
                                        print("object 选择队伍icon 0");
                                        await audioPlayer.release;
                                        logic.selectTeamIcon(logic.teamInfo[1].name, 1);
                                      },
                                      onTapDown: (details) async {
                                        await audioPlayer.play(AssetSource(MirraIcons.getSoundEffectsCheckPath("card.wav")));
                                      },
                                      onTapCancel: () async {
                                        await audioPlayer.release;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30), // 调整上下间距为10
                                        child: CachedNetworkImage(
                                          imageUrl: logic.teamInfo[1].iconPath,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 60,),
                  CommonButton(
                    width: 600.w,
                    height: 100.h,
                    btnText: 'NEXT',
                    btnBgColor: Color(0xff13EFEF),
                    textColor: Colors.black,
                    onPress: () async {
                      // 必须选择队伍icon，logic.teamInfoIndex不为空即为选择了
                      if(logic.teamInfoIndex != null) {
                        // 更新队伍的icon
                        print("队伍icon集合: ${logic.teamInfo}");
                        // 更新队伍的icon
                        await logic.updateTeamInfo(showInfo.showId, logic.teamInfo[int.parse(logic.teamInfoIndex.toString())]);
                        EasyLoading.show(status: "waiting...", maskType: EasyLoadingMaskType.black);
                        try {
                          // final userId = await logic.loginInOrRegister(
                          //   name: customer.name,
                          //   email: customer.email,
                          //   phone: customer.phone,
                          // );
                          // print("userId ${userId}");
                          print("showId ${showInfo.showId}");
                          EasyLoading.dismiss(animation: false);
                          Get.offAll(
                                  () => PlayerSquadPage(),
                              arguments: {
                                'showInfo': showInfo,
                                "bookingState": bookingState,
                                "isAddPlayerClick": isAddPlayerClick,
                                "tableId": tableId,
                              });
                          // List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(userId);
                          // print("headgearObj ${headgearObj}");
                          // print("嘿嘿嘿嘿 ${headgearObj.isEmpty}");
                          // // 如果爆过头套就直接去展示用户，反之就走爆头套、选肤色和性别
                          // if (headgearObj.isEmpty) {
                          //   Get.offAll(
                          //           () => PlayerSquadPage(),
                          //       arguments: {
                          //         'showInfo': showInfo,
                          //         "bookingState": bookingState,
                          //         "isAddPlayerClick": isAddPlayerClick,
                          //         "tableId": tableId,
                          //       });
                          // } else {
                          //   Get.offAll(
                          //         () => HeadgearAcquisitionPage(),
                          //     arguments: {
                          //       'showInfo': showInfo,
                          //       "bookingState": bookingState,
                          //       'headgearObj': headgearObj,
                          //       'userId': userId,
                          //       "isAddPlayerClick": isAddPlayerClick,
                          //       "tableId": tableId,
                          //     },
                          //   );
                          // }
                        } on DioException catch (e) {
                          EasyLoading.dismiss();
                          if (e.response == null) EasyLoading.showError("Network Error!");
                          EasyLoading.showError(e.response?.data["error"]["message"]);
                        }
                      }
                      else {
                        EasyLoading.showError("Please Choose Your Squad Badge !");
                      }
                    },
                    changedBgColor: Color(0xffA4EDF1),
                  ),
                ],
              ),
            ),
            GetBuilder<GroupIconSetLogic>(builder: (logic) {
              return Container();
            }),
          ],
        ));
  }
}