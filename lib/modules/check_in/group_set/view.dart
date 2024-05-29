import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../data/avatar_info.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../headgear_acquisition/view.dart';
import '../player_page/player_squad.dart';
import 'logic.dart';

class GroupIconSetPage extends StatelessWidget {
  GroupIconSetPage({Key? key}) : super(key: key);
  final logic = Get.put(GroupIconSetLogic());

  @override
  Widget build(BuildContext context) {
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
                  // SizedBox(
                  //   width: 1.0.sw,
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         margin: EdgeInsets.only(top: 20.0, left: 0.1.sw),
                  //         child: SizedBox(
                  //           child: Text(
                  //             "Squad settings",
                  //             style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 2),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 1.0.sw,
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         margin: EdgeInsets.only(top: 10.0, left: 0.1.sw),
                  //         child: SizedBox(
                  //           child: Text(
                  //             "Please Choose Your Squad Badge",
                  //             style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 36.sp, level: 4),
                  //           ),
                  //         ),
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
                  SizedBox(height: 50,),
                  SizedBox(
                    child: GetBuilder<GroupIconSetLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 0.0, left: 0.28.sw),
                              constraints: BoxConstraints.tightFor(width: 0.2.sw, height: 0.5.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Container(
                                    width: 0.2.sw,
                                    height: 0.06.sh,
                                    child: logic.teamName == logic.teamInfo[0].name ?
                                    Image.asset(
                                      MirraIcons.getSetAvatarIconPath('group_setting_select.png'),
                                      fit: BoxFit.fitHeight,
                                    ) : null,
                                  ),
                                  Container(
                                    width: 0.2.sw,
                                    height: 0.42.sh,
                                    margin: EdgeInsets.only(top: 0.02.sh),
                                    decoration: BoxDecoration(
                                      color: logic.teamName == logic.teamInfo[0].name ? Color(0xFF5E6F96) : null,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        print("object 选择队伍icon 0");
                                        logic.selectTeamIcon(logic.teamInfo[0].name, 0);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 30.0), // 调整上下间距为10
                                        child: CachedNetworkImage(
                                          imageUrl: logic.teamInfo[0].iconPath,
                                          fit: BoxFit.fitHeight,
                                          width: 0.2.sw,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.0, right: 0.28.sw),
                              constraints: BoxConstraints.tightFor(width: 0.2.sw, height: 0.5.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Container(
                                    width: 0.2.sw,
                                    height: 0.06.sh,
                                    child: logic.teamName == logic.teamInfo[1].name ?
                                    Image.asset(
                                      Global.getSetAvatarImageUrl('group_setting_select.png'),
                                      fit: BoxFit.fitHeight,
                                    ) : null,
                                  ),
                                  Container(
                                    width: 0.2.sw,
                                    height: 0.42.sh,
                                    margin: EdgeInsets.only(top: 0.02.sh),
                                    decoration: BoxDecoration(
                                      color: logic.teamName == logic.teamInfo[1].name ? Color(0xFF5E6F96) : null,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        print("object 选择队伍icon 0");
                                        logic.selectTeamIcon(logic.teamInfo[1].name, 1);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 30.0), // 调整上下间距为10
                                        child: CachedNetworkImage(
                                          imageUrl: logic.teamInfo[1].iconPath,
                                          fit: BoxFit.fitHeight,
                                          width: 0.2.sw,
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
                  SizedBox(height: 80,),
                  _NextDefaultButton(width: 600.w),
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

class _NextDefaultButton extends StatelessWidget {
  _NextDefaultButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.put(GroupIconSetLogic());
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        // 必须选择队伍icon，logic.teamInfoIndex不为空即为选择了
        if(logic.teamInfoIndex != null) {
          // 更新队伍的icon
          print("队伍icon集合: ${logic.teamInfo}");
          print("选择的队伍icon索引: ${logic.teamInfoIndex}");
          // 更新队伍的icon
          await logic.updateTeamInfo(showInfo.showId, logic.teamInfo[int.parse(logic.teamInfoIndex.toString())]);
          EasyLoading.show(status: "waiting...", maskType: EasyLoadingMaskType.black);
          try {
            final userId = await logic.loginInOrRegister(
              name: customer.name,
              email: customer.email,
              phone: customer.phone,
            );
            print("userId ${userId}");
            print("showId ${showInfo.showId}");
            print("哈哈哈哈哈");
            EasyLoading.dismiss(animation: false);
            List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(userId);
            print("headgearObj ${headgearObj}");
            // List headgearObj = [
            //   {
            //     "itemInfo": {
            //       "id": 22,
            //       "name": "LowPoly_Dragn",
            //       "type": "headgear",
            //       "level": 1,
            //       "icon": "/uploads/Highres_Screenshot00004_9049db84a3.png"
            //     }
            //   },
            //   {
            //     "itemInfo": {
            //       "id": 20,
            //       "name": "Food_Burger",
            //       "type": "headgear",
            //       "level": 1,
            //       "icon": "/uploads/Highres_Screenshot00005_67afaf9dc4.png"
            //     }
            //   },
            //   {
            //     "itemInfo": {
            //       "id": 2,
            //       "name": "TV",
            //       "type": "headgear",
            //       "level": 1,
            //       "icon": "/uploads/TV_00b57f3012.png"
            //     }
            //   },
            //   {
            //     "itemInfo": {
            //       "id": 20,
            //       "name": "Food_Burger",
            //       "type": "headgear",
            //       "level": 1,
            //       "icon": "/uploads/Highres_Screenshot00005_67afaf9dc4.png"
            //     }
            //   },
            //   {
            //     "itemInfo": {
            //       "id": 2,
            //       "name": "TV",
            //       "type": "headgear",
            //       "level": 1,
            //       "icon": "/uploads/TV_00b57f3012.png"
            //     }
            //   },
            // ];
            print("嘿嘿嘿嘿 ${headgearObj.isEmpty}");
            // 如果爆过头套就直接去展示用户，反之就走爆头套、选肤色和性别
            if (headgearObj.isEmpty) {
              Get.offAll(
                      () => PlayerSquadPage(),
                  arguments: {
                    'showInfo': showInfo,
                    'customer': customer,
                    "isAddPlayerClick": isAddPlayerClick,
                    "tableId": tableId,
                  });
            } else {
              Get.offAll(
                    () => HeadgearAcquisitionPage(),
                arguments: {
                  'showInfo': showInfo,
                  'customer': customer,
                  'headgearObj': headgearObj,
                  'userId': userId,
                  "isAddPlayerClick": isAddPlayerClick,
                  "tableId": tableId,
                },
              );
            }
          } on DioException catch (e) {
            print("hahah ${e}");
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }
        }
        else {
          EasyLoading.showError("Please Choose Your Squad icon !");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
        child: Center(
          child: Text(
            "NEXT",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Colors.black, fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}