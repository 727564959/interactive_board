import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/data/model/show_state.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../app_routes.dart';
import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../../modules/set_avatar/data/setAvatar_api.dart';
import '../../../../modules/set_avatar/logic.dart';
import '../../../../modules/set_avatar/view.dart';
import '../../../../widgets/check_in_title.dart';
import '../../../../widgets/player_dress_model.dart';
import '../../data/checkIn_api.dart';
import '../../data/player_card.dart';
import '../before_checkIn/term_of_use.dart';
import 'hint_dialog.dart';

class PlayerCardShow extends StatelessWidget {
  PlayerCardShow({Key? key}) : super(key: key);
  final logic = Get.put(CheckInLogic());
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
    int num = 1;
    if (logic.playerCardInfo.length % 2 == 0) {
      // 可以被2整除
      num = 1;
    } else if (logic.playerCardInfo.length % 3 == 0) {
      // 可以被3整除
      num = 2;
    } else if (logic.playerCardInfo.length % 4 == 0) {
      // 可以被4整除
      num = 3;
    }
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<CheckInLogic>(
            id: "playerCard",
            builder: (logic) {
              return Container(
                width: 0.8.sw,
                height: 0.8.sh,
                margin: EdgeInsets.only(left: 0.1.sw, top: 0.1.sh),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15.0, // 设置列之间的间距
                  childAspectRatio: 0.55, // 设置卡片宽高比
                  children: logic.playerCardInfo.map((card) {
                    return GestureDetector(
                      onTap: () async {
                        print("点击了卡牌 ${card.isUserCard}");
                        // 处理卡片点击事件
                        if (!card.isUserCard) {
                          // 点击非用户卡片时的逻辑
                          print("新增用户");
                          // logic.isClickSkip = false;
                          // logic.isFirstCheckIn = false;
                          // print("添加用户的跳转： ${Get.arguments}");
                          // logic.gameItemInfo.clear();
                          // Get.to(() => TermOfUsePage(), arguments: Get.arguments);
                        }
                        else {
                          print("设计形象");
                          if(card.bShowRegisterDialog != null && card.bShowRegisterDialog == true) {
                            Get.dialog(Dialog(child: HintDialog()));
                            logic.clearRegisterFlag(card.userId);
                          }
                          else {
                            Map<String, dynamic> jsonObj = {
                              "userId": card.userId,
                              "showId": Get.arguments.showId,
                              "status": Get.arguments.status.toString()
                            };
                            print("参数 ${jsonObj}");
                            print("object ${Get.isRegistered<SetAvatarLogic>()}");
                            if(Get.isRegistered<SetAvatarLogic>()) {
                              Get.find<SetAvatarLogic>().updateUserList(Get.arguments.showId);
                              await Future.delayed(100.ms);
                              Get.find<SetAvatarLogic>().updatePlayer(card.userId.toString());
                              await Future.delayed(100.ms);
                              Get.find<SetAvatarLogic>().explosiveChestFun(card.userId);
                            }
                            await Get.toNamed(AppRoutes.setAvatar, arguments: jsonObj);
                          }
                        }
                      },
                      child: Card(
                        child: card.isUserCard
                            ? Container(
                          decoration: BoxDecoration(
                            color: color,
                          ),
                          child: Stack(
                            children: [
                              PlayerDressModel(
                                headgearUrl: card.avatarIcon ?? '',
                                bodyUrl: card.bodyIcon ?? '',
                                width: 0.8.sw / 4 - (15 * num),
                              ),
                              Positioned(
                                // left: (0.8.sw / 4 - (15 * 8)) / 2, // 水平居中
                                bottom: 0,
                                child: Container(
                                  height: 34,
                                  width: 0.8.sw / 4 - (15 * num),
                                  color: Color(0xFFDBE2E3),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Text(
                                      card.nickname ?? '',
                                      maxLines: 1, // 最大显示行数
                                      overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                                      style: CustomTextStyles.notice(color: Color(0xFF5A5858), fontSize: 24.sp),
                                    ),
                                  ),
                                ),
                              ),
                              if(card.bTemped != null && card.bTemped == true) Positioned(
                                top: 5,
                                left: 0.8.sw / 4 - (15 * num) - (35),
                                child: Image.asset(
                                  Global.getSetAvatarImageUrl('warning_red_icon.png'),
                                  fit: BoxFit.fill,
                                  width: 25,
                                ),
                              ),
                            ],
                          ),
                        )
                              // Container(
                        //   decoration: BoxDecoration(
                        //     color: color,
                        //   ),
                        //   child: Stack(
                        //     children: [
                        //       Positioned(
                        //         left: (0.8.sw / 4 - (15 * 8)) / 2, // 水平居中
                        //         child: Container(
                        //           width: 100,
                        //           color: Colors.red,
                        //           child: CachedNetworkImage(
                        //             imageUrl: card.avatarIcon ?? '',
                        //             fit: BoxFit.contain,
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         left: (0.8.sw / 4 - (15 * 12)) / 2,
                        //         top: 100,
                        //         child: Container(
                        //           width: 160,
                        //           margin: EdgeInsets.only(top: 0.0),
                        //           color: Colors.green,
                        //           child: CachedNetworkImage(
                        //             imageUrl: card.bodyIcon ?? '',
                        //             fit: BoxFit.contain,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        //   // child: Column(
                        //   //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   //   children: [
                        //   //     Container(
                        //   //       width: 100,
                        //   //       color: Colors.red,
                        //   //       child: CachedNetworkImage(
                        //   //         imageUrl: card.avatarIcon ?? '',
                        //   //         fit: BoxFit.contain,
                        //   //       ),
                        //   //     ),
                        //   //     Container(
                        //   //       width: 160,
                        //   //       margin: EdgeInsets.only(top: 0.0),
                        //   //       color: Colors.green,
                        //   //       child: CachedNetworkImage(
                        //   //         imageUrl: card.bodyIcon ?? '',
                        //   //         fit: BoxFit.contain,
                        //   //       ),
                        //   //     ),
                        //   //     // Container(
                        //   //     //   color: Color(0xFFDBE2E3),
                        //   //     //   alignment: Alignment.center,
                        //   //     //   child: Padding(
                        //   //     //     padding: EdgeInsets.all(4),
                        //   //     //     child: Text(
                        //   //     //       card.avatarName ?? '',
                        //   //     //       maxLines: 1, // 最大显示行数
                        //   //     //       overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                        //   //     //       style: CustomTextStyles.notice(color: Color(0xFF5A5858), fontSize: 24.sp),
                        //   //     //     ),
                        //   //     //   ),
                        //   //     // ),
                        //   //   ],
                        //   // ),
                        // )
                            : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Icon(Icons.add, color: color, size: 100,),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}