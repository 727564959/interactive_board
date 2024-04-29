import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';

import 'package:card_swiper/card_swiper.dart';

import '../../../../mirra_style.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../modules/set_avatar/view.dart';
import '../../data/checkIn_api.dart';
import '../treasure_chest/explosive_chest.dart';

class GroupSettingPage extends StatelessWidget {
  GroupSettingPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  List banner = [
    {
      "banner_url":
      "https://ts1.cn.mm.bing.net/th/id/R-C.8e091d0e6a2b9bcb27738cd96e22f699?rik=M4LFAVmmb38W6A&riu=http%3a%2f%2fi3.img.969g.com%2fdown%2fimgx2013%2f01%2f21%2f206_170432_901de.jpg&ehk=564uTBfxvugUBybGO2%2bTpMUNgJEa6rUfSrc1sonLso8%3d&risl=&pid=ImgRaw&r=0"
    },
    {
      "banner_url":
      "https://ts1.cn.mm.bing.net/th/id/R-C.abd4829c9387ec1bfd1a276a5c1da122?rik=dl55Voqxy4wINQ&riu=http%3a%2f%2fi1.073img.com%2f140306%2f4343693_144142_1.jpg&ehk=qvhMjT0iGQT5DhH8MTkAzJqUpjHJRScTQTT5hj%2forLM%3d&risl=&pid=ImgRaw&r=0"
    },
    {
      "banner_url":
      "https://ts1.cn.mm.bing.net/th/id/R-C.ddfbf9ed55354323035f947515fe0233?rik=0KFdFk3RHUzBdg&riu=http%3a%2f%2fi1.img.969g.com%2fdown%2fimgx2013%2f01%2f05%2f206_164916_4fab0.jpg&ehk=Vqb%2f5c3%2fW5n39t7bAae6YpUlfG4ibEbf9lpETY5Xz4c%3d&risl=&pid=ImgRaw&r=0"
    }
  ];

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
                          margin: EdgeInsets.only(top: 30.0, left: 120.0),
                          child: SizedBox(
                            width: 0.24.sw,
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
                          margin: EdgeInsets.only(top: 0.0, left: 120.0),
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
                  SizedBox(
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: logic.teamName == logic.teamInfo[0].name ? Colors.white24 : null,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 20.0, left: 0.2.sw),
                              constraints: BoxConstraints.tightFor(width: 0.3.sw, height: 0.55.sh),//卡片大小
                              alignment: Alignment.center, //卡片内文字居中
                              child: Column(
                                children: [
                                  Container(
                                    width: 0.3.sw,
                                    height: 0.08.sh,
                                    child: logic.teamName == logic.teamInfo[0].name ?
                                              Image.asset(
                                                Global.getSetAvatarImageUrl('group_setting_select.png'),
                                                fit: BoxFit.fitHeight,
                                              ) : null,
                                  ),
                                  Container(
                                    width: 0.3.sw,
                                    height: 0.42.sh,
                                    margin: EdgeInsets.only(top: 0.02.sh),
                                    child: GestureDetector(
                                      onTap: () async {
                                        print("object 选择队伍icon 0");
                                        logic.selectTeamIcon(logic.teamInfo[0].name, 0);
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: logic.teamInfo[0].iconPath,
                                        fit: BoxFit.fitHeight,
                                        width: 0.2.sw,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: logic.teamName == logic.teamInfo[1].name ? Colors.white24 : null,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(top: 20.0, right: 0.2.sw,),
                              constraints: BoxConstraints.tightFor(width: 0.3.sw, height: 0.55.sh),//卡片大小
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    width: 0.3.sw,
                                    height: 0.08.sh,
                                    child: logic.teamName == logic.teamInfo[1].name ?
                                    Image.asset(
                                      Global.getSetAvatarImageUrl('group_setting_select.png'),
                                      fit: BoxFit.fitHeight,
                                    ) : null,
                                  ),
                                  Container(
                                    width: 0.3.sw,
                                    height: 0.42.sh,
                                    margin: EdgeInsets.only(top: 0.02.sh),
                                    child: GestureDetector(
                                      onTap: () async {
                                        print("object 选择队伍icon 1");
                                        logic.selectTeamIcon(logic.teamInfo[1].name, 1);
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: logic.teamInfo[1].iconPath,
                                        fit: BoxFit.fitHeight,
                                        width: 0.2.sw,
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
                  // SizedBox(
                  //   child: GetBuilder<CheckInLogic>(
                  //     builder: (logic) {
                  //       return Row(
                  //         children: [
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.white24,
                  //               borderRadius: BorderRadius.all(Radius.circular(10)),
                  //             ),
                  //             margin: EdgeInsets.only(top: 20.0, left: 120.0),
                  //             constraints: BoxConstraints.tightFor(width: 0.4.sw, height: 0.5.sh),//卡片大小
                  //             alignment: Alignment.center, //卡片内文字居中
                  //             child: Column(
                  //               children: [
                  //                 Align(
                  //                   heightFactor: 5,
                  //                   alignment: const Alignment(0.0, 0.0),
                  //                   child: Text(
                  //                     "Create a Catchy Team Name!",
                  //                     style: TextStyle(
                  //                       // fontWeight: FontWeight.bold,
                  //                       fontSize: 45.sp,
                  //                       decoration: TextDecoration.none,
                  //                       fontFamily: 'BurbankBold',
                  //                       color: Colors.white,
                  //                       letterSpacing: 3.sp,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   child: TextField(
                  //                     decoration: InputDecoration(
                  //                       fillColor: Color(0xff212121),
                  //                       filled: true,
                  //                       contentPadding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 30.sp),
                  //                       // 默认可编辑时的边框
                  //                       enabledBorder: OutlineInputBorder(
                  //                         borderSide: BorderSide(
                  //                           color: Color(0xff5A5858), //边线颜色为白色
                  //                           width: 2, //边线宽度为2
                  //                         ),
                  //                       ),
                  //                       // 输入时的边框
                  //                       focusedBorder: OutlineInputBorder(
                  //                         borderSide: BorderSide(
                  //                           color: Colors.blue, //边框颜色为白色
                  //                           width: 2, //宽度为5
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     style: TextStyle(fontSize: 50.sp, decoration: TextDecoration.none, fontFamily: 'BurbankBold', color: Colors.white, letterSpacing: 3.sp,),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.white24,
                  //               borderRadius: BorderRadius.all(Radius.circular(10)),
                  //             ),
                  //             margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  //             constraints: BoxConstraints.tightFor(width: 0.4.sw, height: 0.5.sh),//卡片大小
                  //             alignment: Alignment.center, //卡片内文字居中
                  //             child: Column(
                  //               children: [
                  //                 Align(
                  //                   heightFactor: 5,
                  //                   alignment: const Alignment(0.0, 0.0),
                  //                   child: Text(
                  //                     "Pick up a flag",
                  //                     style: TextStyle(
                  //                       // fontWeight: FontWeight.bold,
                  //                       fontSize: 45.sp,
                  //                       decoration: TextDecoration.none,
                  //                       fontFamily: 'BurbankBold',
                  //                       color: Colors.white,
                  //                       letterSpacing: 3.sp,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Align(
                  //                   alignment: const Alignment(0.0, 0.0),
                  //                   child: SizedBox(
                  //                     width: 200,
                  //                     height: 200,
                  //                     child: CustomSwiper(
                  //                       banner: banner,
                  //                     )
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                  _NextDefaultButton(width: 800.w),
                ],
              ),
            ),
            GetBuilder<CheckInLogic>(builder: (logic) {
              return Container();
            }),
          ],
        ));
  }
}
//轮播图的区域
class CustomSwiper extends StatefulWidget {
  const CustomSwiper({super.key, required this.banner});
  final List banner;

  @override
  _CustomSwiperState createState() => _CustomSwiperState();
}
class _CustomSwiperState extends State<CustomSwiper> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        // return Image.network(
        //   widget.banner[index]['banner_url'],
        //   fit: BoxFit.fill,
        // );
        return Image.asset(
          Global.getSetAvatarImageUrl('group_icon.png'),
          fit: BoxFit.fitHeight,
          width: 210.w,
        );
      },
      onTap: (index) {
        print(index);
      },
      itemCount: widget.banner.length,
      // autoplay: true,
      pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: Color(0xFFFFFFFF), activeColor: Color(0xFFFF4646))),
      control: SwiperControl(),
    );
  }
}
// 同意条款的按钮
class _NextDefaultButton extends StatelessWidget {
  _NextDefaultButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("group_setting_input.png");
  // String get backgroundUri => !logic.groupSettingBtnIsInput
  //     ? Global.getSetAvatarImageUrl("group_setting_default.png")
  //     : Global.getSetAvatarImageUrl("group_setting_input.png");

  final testTabId = Global.tableId;
  get checkInApi => CheckInApi();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        // 必须选择队伍icon，logic.teamInfoIndex不为空即为选择了
        if(logic.teamInfoIndex != null) {
          // print("groupsetting ${logic.showState.status}");
          logic.isFirstCheckIn = false;
          // Get.to(() => AvatarDesignPage(), arguments: Get.arguments);

          // 更新队伍的icon
          print("队伍icon集合: ${logic.teamInfo}");
          print("选择的队伍icon索引: ${logic.teamInfoIndex}");
          // 更新队伍的icon
          await checkInApi.updateTeamInfo(Get.arguments.showId, logic.teamInfo[int.parse(logic.teamInfoIndex.toString())]);

          // logic.gameItemInfo = await checkInApi.fetchUserGameItems(logic.consumerId);
          // print("爆出来的头像: ${logic.gameItemInfo}");
          // // 延迟调用爆宝箱
          // Future.delayed(2.seconds).then((value) {
          //   logic.explosiveChestFun(logic.consumerId);
          // }).onError((error, stackTrace) async {
          //   print("error爆宝箱 $error");
          // });

          Map<String, dynamic> jsonObj = {
            "userId": logic.consumerId,
            "showId": logic.showState.showId,
            "status": logic.showState.status.toString(),
          };
          logic.getHeadgearFun(logic.consumerId);
          if(logic.headgearObj.isEmpty) {
            if(Get.isRegistered<SetAvatarLogic>()) {
              Get.find<SetAvatarLogic>().updateUserList(int.parse(logic.showState.showId.toString()));
              await Future.delayed(100.ms);
              Get.find<SetAvatarLogic>().updatePlayer(logic.consumerId.toString());
              await Future.delayed(100.ms);
              Get.find<SetAvatarLogic>().explosiveChestFun(logic.consumerId.toString());
            }
            await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
          }
          else {
            Map<String, dynamic> jsonObj1 = {
              "userId": logic.consumerId,
              "showId": logic.showState.showId,
              "status": logic.showState.status.toString(),
              'headgearObj': logic.headgearObj,
            };
            Future.delayed(0.5.seconds).then((value) async {
              print("延迟跳转");
              Get.to(() => TreasureChestPage(playerId: int.parse(logic.consumerId.toString())), arguments: jsonObj1);
            });
            // Get.offAll(() => TreasureChestPage(playerId: int.parse(logic.consumerId.toString())), arguments: jsonObj);
          }
          // await Get.offAllNamed(AppRoutes.setAvatar, arguments: jsonObj);
          // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
          // Get.to(() => TreasureChestPage(playerId: int.parse(logic.consumerId.toString())), arguments: jsonObj);
        }
        else {
          EasyLoading.showError("Please Choose Your Squad icon !");
        }
      },
      child: GetBuilder<CheckInLogic>(
        id: "groupsettingBtn",
        builder: (logic) {
          return Container(
            height: width * 0.35,
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