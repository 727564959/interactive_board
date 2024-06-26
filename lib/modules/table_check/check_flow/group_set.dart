import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../data/model/show_state.dart';
import '../player_show/logic.dart';
import '../player_show/view.dart';
import 'logic.dart';

class GroupSetIconPage extends StatelessWidget {
  GroupSetIconPage({Key? key}) : super(key: key);
  final logic = Get.put(CheckFlowLogic());

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
                  SizedBox(
                    width: 1.0.sw,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.0, left: 0.1.sw),
                          child: SizedBox(
                            child: Text(
                              "Group settings",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1.0.sw,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 0.1.sw),
                          child: SizedBox(
                            child: Text(
                              "Please Choose Your Squad icon",
                              style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 36.sp, level: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  SizedBox(
                    child: GetBuilder<CheckFlowLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 0.0, left: 0.3.sw),
                              constraints: BoxConstraints.tightFor(width: 0.2.sw, height: 0.5.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Container(
                                    width: 0.2.sw,
                                    height: 0.06.sh,
                                    child: logic.teamName == logic.teamInfo[0].name ?
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
                              margin: EdgeInsets.only(top: 0.0, right: 0.3.sw),
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
                  _NextDefaultButton(width: 800.w),
                ],
              ),
            ),
            GetBuilder<CheckFlowLogic>(builder: (logic) {
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
  final logic = Get.put(CheckFlowLogic());
  final testTabId = Global.tableId;
  ShowState get showState => Get.arguments["showState"];

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
          await logic.updateTeamInfo(showState.showId??1, logic.teamInfo[int.parse(logic.teamInfoIndex.toString())]);

          try {
            EasyLoading.dismiss(animation: false);
            Get.offAll(() => PlayerShowPage(),
                arguments: {
                  'showState': showState,
                });
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }

          // final playerShowPageLogic = Get.put(PlayerShowPageLogic());
          // playerShowPageLogic.refreshFun();
          // playerShowPageLogic.getCurrentTeam();
          // Get.offAll(() => PlayerShowPage(),
          //     arguments: {
          //       'showState': showState,
          //     });
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