import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../mirra_style.dart';
import '../../../widgets/check_in_title.dart';
import '../complete_page/view.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../terms_page/view.dart';
import 'logic.dart';

class PlayerInfoShow extends StatelessWidget {
  PlayerInfoShow({
    Key? key,
    required this.showInfo,
    required this.customer,
  }) : super(key: key);
  final logic = Get.put(PlayerShowLogic());
  final ShowInfo showInfo;
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Color(0xFF233342),
              child: Column(
                children: [
                  // 顶部文本信息
                  CheckInTitlePage(titleText: '',),
                  SizedBox(
                    child: GetBuilder<PlayerShowLogic>(
                      builder: (logic) {
                        return Column(
                          children: [
                            Align(
                              heightFactor: 1.5,
                              alignment: const Alignment(-0.7, 1.0),
                              child: Text(
                                "Hi, there !",
                                style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
                              ),
                            ),
                            Align(
                              heightFactor: 1,
                              alignment: const Alignment(-0.65, 0.0),
                              child: Text(
                                "Set your avatar",
                                style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    child: GetBuilder<PlayerShowLogic>(
                      builder: (logic) {
                        return Column(
                          children: [
                            _NicknameArea(),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20.0, left: 0.0, right: 0.56.sw),
                                  child: _AddPlayerButton(width: 432.w, showInfo: showInfo, customer: customer),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0.45.sw,
              top: 30,
              child: Countdown(
                seconds: 60,
                build: (context, time) => TextButton(
                  onPressed: () {  },
                  child: Text(
                    "${time.toInt()}s close",
                    style: CustomTextStyles.title(color: Colors.white, fontSize: 40.sp, level: 2),
                  )),
                  onFinished: () async {
                    await Get.to(
                          () => CompletePage(
                        tableId: Global.tableId!,
                        startTime: showInfo.startTime,
                        customer: customer,
                      ),
                      preventDuplicates: false,
                    );
                  },
              ),
            ),
            // GetBuilder<PlayerShowLogic>(builder: (logic) {
            //   return Container();
            // }),
          ],
        ));
  }
}

// 玩家姓名
class _NicknameArea extends StatelessWidget {
  _NicknameArea({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<PlayerShowLogic>();

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
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("修改名字");
      },
      child: GetBuilder<PlayerShowLogic>(
        id: "nicknameArea",
        builder: (logic) {
          return Container(
            // decoration: BoxDecoration(
            //   color: Colors.red,
            // ),
            margin: EdgeInsets.only(top: 50.0, left: 0.0, right: 0.0),
            constraints: BoxConstraints.tightFor(width: 0.78.sw), //卡片大小
            child: Wrap(
              // 主轴(水平)方向间距
              spacing: 10,
              // 纵轴（垂直）方向间距
              runSpacing: 20,
              alignment: WrapAlignment.start, //沿主轴方向居中
              // crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(logic.casualUser.length, (index) => getItem(index, color)),
            ),
          );
        },
      ),
    );
  }
}

// 获取子项目
Widget getItem(int index, Color color) {
  final logic = Get.find<PlayerShowLogic>();

  var item = logic.casualUser[index % logic.casualUser.length];
  return ActionChip(
      pressElevation: 10,
      // tooltip: "点击",
      label: Text(
        item.nickname,
        style: CustomTextStyles.title(color: Colors.black, fontSize: 40.sp, level: 3),
      ),
      //长按提示
      // labelPadding: EdgeInsets.all(10),
      // backgroundColor: Color(0xffFFBD80),
      backgroundColor: color,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      onPressed: () async {
        // print("点击 ${item.userId}");
        // print("参数 ${Get.arguments}");
        // Map<String, dynamic> jsonObj = {
        //   "userId": item.userId,
        //   "showId": Get.arguments.showId,
        //   "status": Get.arguments.status.toString()
        // };
        // print("参数 ${jsonObj}");
        // print("object ${Get.isRegistered<SetAvatarLogic>()}");
        // if(Get.isRegistered<SetAvatarLogic>()) {
        //   Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
        //   await Future.delayed(100.ms);
        //   Get.find<SetAvatarLogic>().updatePlayer(item.id);
        //   Get.find<SetAvatarLogic>().explosiveChestFun(item.id);
        // }
        // await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
      });
}

// 添加用户按钮
class _AddPlayerButton extends StatelessWidget {
  _AddPlayerButton({
    Key? key,
    required this.width,
    required this.showInfo,
    required this.customer,
  }) : super(key: key);
  final double width;
  final ShowInfo showInfo;
  final Customer customer;

  final logic = Get.find<PlayerShowLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("add_player_btn.png");

  final testTabId = Global.tableId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("添加用户");
        // 将点击跳过按钮置回初始状态
        // logic.isClickSkip = false;
        // logic.isFirstCheckIn = false;
        // print("添加用户的跳转： ${Get.arguments}");
        // logic.gameItemInfo.clear();
        // logic.testRefreshFun();
        Get.off(() => TermsOfUsePage(isAddPlayerClick: true, showInfo: showInfo, customer: customer), arguments: Get.arguments);
      },
      child: GetBuilder<PlayerShowLogic>(
        id: "addPlayerBtn",
        builder: (logic) {
          return Container(
            height: width * 0.3,
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