import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../mirra_style.dart';
import '../complete_page/view.dart';
import '../data/avatar_info.dart';
import '../data/show.dart';
import '../data/booking.dart';
import '../group_set/view.dart';
import '../headgear_acquisition/view.dart';
import '../player_page/player_squad.dart';
import '../player_page/view.dart';
import 'logic.dart';
import '../../../common.dart';
import '../widget/button.dart';

class ChooseTablePage extends StatelessWidget {
  ChooseTablePage({
    Key? key,
  }) : super(key: key);
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  String get code => Get.arguments["code"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  final logic = Get.put(ChooseTableLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF233342),
            child: Container(
              // alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 200.w),
              child: Column(
                children: [
                  // Align(
                  //   alignment: const Alignment(-1.0, 0.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       SizedBox(height: 50),
                  //       Text(
                  //         "Choose Bay",
                  //         style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                  //       ),
                  //       Text(
                  //         "Let's Gather! Pick Your Bay for Fun",
                  //         style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 36.sp, level: 4),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 0.24.sh),
                  Align(
                    alignment: const Alignment(-1.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // "Game Time: ${DateFormat('kk:mm').format(showInfo.startTime.add(8.hours))}",
                          "Game Time: ${DateFormat('hh:mm a').format(showInfo.startTime)}",
                          style: CustomTextStyles.title(color: Colors.white, fontSize: 34.sp, level: 5),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Image.asset(
                        //       Global.getSetAvatarImageUrl('time_icon.png'),
                        //       fit: BoxFit.fill,
                        //     ),
                        //     SizedBox(
                        //       width: 5.0,
                        //     ),
                        //     Text(
                        //       "40 Mins",
                        //       style: CustomTextStyles.title(color: Colors.white, fontSize: 34.sp, level: 5),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.white),
                    // ),
                    // height: 600.w,
                    // padding: EdgeInsets.only(top: 150.w, left: 100.w, right: 100.w),
                    child: GetBuilder<ChooseTableLogic>(
                      builder: (ChooseTableLogic logic) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [1, 2, 3, 4]
                              .map(
                                (e) => _TableItem(
                              tableId: e,
                              bSelected: logic.selectedTableId == e,
                              bAvailable: !showInfo.fullTables.contains(e),
                            ),
                          )
                              .toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 120),
                  GetBuilder<ChooseTableLogic>(
                    builder: (logic) => CheckInButton(
                      title: "NEXT",
                      disable: !logic.bSelected,
                      onPress: () async {
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
                        // Global.setTableId(logic.selectedTableId!);
                        // Get.offAll(
                        //       () => HeadgearAcquisitionPage(),
                        //       arguments: {
                        //         'showInfo': showInfo,
                        //         'customer': customer,
                        //         'headgearObj': headgearObj,
                        //         'userId': 368,
                        //       },
                        // );

                        EasyLoading.show(status: "waiting...", maskType: EasyLoadingMaskType.black);
                        try {
                          // Global.setTableId(logic.selectedTableId!);
                          final userId = await logic.loginInOrRegister(
                            name: customer.name,
                            email: customer.email,
                            phone: customer.phone,
                          );
                          print("userId ${userId}");
                          print("showId ${showInfo.showId}");
                          print("code ${code}");
                          print("logic.selectedTableId ${logic.selectedTableId}");
                          // 验票
                          await logic.customerCheckIn(showId: showInfo.showId, userId: userId, code: code);
                          print("哈哈哈哈哈");
                          EasyLoading.dismiss(animation: false);
                          // 选队徽
                          // await Get.to(() => GroupIconSetPage(),
                          //     arguments: {
                          //       'showInfo': showInfo,
                          //       'customer': customer,
                          //       "isAddPlayerClick": isAddPlayerClick,
                          //       "tableId": logic.selectedTableId,
                          //     });
                          await Get.offAll(() => GroupIconSetPage(),
                              arguments: {
                                'showInfo': showInfo,
                                'customer': customer,
                                "isAddPlayerClick": isAddPlayerClick,
                                "tableId": logic.selectedTableId,
                              });

                          // List<GameItemInfo> headgearObj = await logic.fetchHeadgearInfo(userId);
                          // print("headgearObj ${headgearObj}");
                          // // List headgearObj = [
                          // //   {
                          // //     "itemInfo": {
                          // //       "id": 22,
                          // //       "name": "LowPoly_Dragn",
                          // //       "type": "headgear",
                          // //       "level": 1,
                          // //       "icon": "/uploads/Highres_Screenshot00004_9049db84a3.png"
                          // //     }
                          // //   },
                          // //   {
                          // //     "itemInfo": {
                          // //       "id": 20,
                          // //       "name": "Food_Burger",
                          // //       "type": "headgear",
                          // //       "level": 1,
                          // //       "icon": "/uploads/Highres_Screenshot00005_67afaf9dc4.png"
                          // //     }
                          // //   },
                          // //   {
                          // //     "itemInfo": {
                          // //       "id": 2,
                          // //       "name": "TV",
                          // //       "type": "headgear",
                          // //       "level": 1,
                          // //       "icon": "/uploads/TV_00b57f3012.png"
                          // //     }
                          // //   },
                          // //   {
                          // //     "itemInfo": {
                          // //       "id": 20,
                          // //       "name": "Food_Burger",
                          // //       "type": "headgear",
                          // //       "level": 1,
                          // //       "icon": "/uploads/Highres_Screenshot00005_67afaf9dc4.png"
                          // //     }
                          // //   },
                          // //   {
                          // //     "itemInfo": {
                          // //       "id": 2,
                          // //       "name": "TV",
                          // //       "type": "headgear",
                          // //       "level": 1,
                          // //       "icon": "/uploads/TV_00b57f3012.png"
                          // //     }
                          // //   },
                          // // ];
                          // print("嘿嘿嘿嘿 ${headgearObj.isEmpty}");
                          // // 如果爆过头套就直接去展示用户，反之就走爆头套、选肤色和性别
                          // if (headgearObj.isEmpty) {
                          //   Get.offAll(
                          //       () => PlayerSquadPage(),
                          //       arguments: {
                          //         'showInfo': showInfo,
                          //         'customer': customer,
                          //         "isAddPlayerClick": isAddPlayerClick,
                          //       });
                          // } else {
                          //   Get.offAll(
                          //     () => HeadgearAcquisitionPage(),
                          //     arguments: {
                          //       'showInfo': showInfo,
                          //       'customer': customer,
                          //       'headgearObj': headgearObj,
                          //       'userId': userId,
                          //       "isAddPlayerClick": isAddPlayerClick,
                          //     },
                          //   );
                          // }
                        } on DioException catch (e) {
                          print("hahah ${e}");
                          EasyLoading.dismiss();
                          if (e.response == null) EasyLoading.showError("Network Error!");
                          EasyLoading.showError(e.response?.data["error"]["message"]);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  _BackButton(),
                ],
              ),
            ),
          ),
          Positioned(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 40.0),
                  constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Choose Bay",
                          style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Let's Gather! Pick Your Bay for Fun",
                          style: CustomTextStyles.textSmall(
                            color: Color(0xFFFFFFFF),
                            fontSize: 26.sp,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TableItem extends StatefulWidget {
  const _TableItem({
    Key? key,
    required this.tableId,
    required this.bSelected,
    required this.bAvailable,
  }) : super(key: key);
  final int tableId;
  final bool bAvailable;
  final bool bSelected;
  @override
  _TableItemState createState() => _TableItemState();
}

class _TableItemState extends State<_TableItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapUp: (details) {
            // print("进行点击选桌: ${widget.tableId}");
            final logic = Get.find<ChooseTableLogic>();
            if (!widget.bAvailable) return;
            logic.selectTable(widget.tableId);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: containerWidthSize,
            height: containerHeightSize,
            // color: backgroundColor,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.bSelected)
                    Image.asset(
                      Global.getSetAvatarImageUrl('selected_icon.png'),
                      fit: BoxFit.fill,
                    ),
                  Text(
                    "Bay $bayString",
                    style: CustomTextStyles.title(color: Colors.black, fontSize: 48.sp, level: 2),
                  ),
                  Text(
                    widget.bAvailable ? "Available" : "Full",
                    style: CustomTextStyles.title(color: Colors.black, fontSize: 28.sp, level: 6),
                  ),
                ],
              ),
            ),
            // child: Text(
            //   widget.bAvailable ? "Available" : "Full",
            //   style: const TextStyle(color: Colors.black),
            // ),
          ),
        ),
        const SizedBox(height: 20),
        // Text("Table ${widget.tableId}"),
      ],
    );
  }

  Color get backgroundColor {
    if (!widget.bAvailable) return Color(0xFFD0D0D0);
    return widget.bSelected ? Color(0xFF13EFEF) : Color(0xFFA4EDF1);
  }

  double get containerWidthSize {
    if (!widget.bAvailable) return 0.18.sw;
    return widget.bSelected ? 0.21.sw : 0.18.sw;
  }

  double get containerHeightSize {
    if (!widget.bAvailable) return 0.21.sh;
    return widget.bSelected ? 0.24.sh : 0.21.sh;
  }

  String get bayString {
    if (widget.tableId == 1) {
      return "A";
    } else if (widget.tableId == 2) {
      return "B";
    } else if (widget.tableId == 3) {
      return "C";
    } else {
      return "D";
    }
  }
}

class _BackButton extends StatelessWidget {
  _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        Get.back();
      },
      child: Text(
        "BACK",
        style: CustomTextStyles.button(color: Color(0xFF13EFEF), fontSize: 28.sp),
      ),
    );
  }
}