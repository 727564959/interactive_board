import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../mirra_style.dart';
import '../complete_page/view.dart';
import '../data/show.dart';
import '../data/booking.dart';
import '../headgear_acquisition/view.dart';
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
  final logic = Get.put(ChooseTableLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: Color(0xFF233342),
        child: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 200.w),
          child: Column(
            children: [
              Align(
                alignment: const Alignment(-1.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Choose Table",
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                    ),
                    Text(
                      "Please Choose Your Gaming Table",
                      style: CustomTextStyles.title(color: Color(0xFF9B9B9B), fontSize: 36.sp, level: 4),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 50),
              // const Text(
              //   "Choose Table",
              //   style: TextStyle(fontSize: 50),
              // ),
              // const SizedBox(height: 70),
              // const Text(
              //   "Please Choose Your Gaming Table",
              //   style: TextStyle(fontSize: 50),
              // ),
              const SizedBox(height: 100),
              Align(
                alignment: const Alignment(-1.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Game Times: ${DateFormat('kk:mm').format(showInfo.startTime.add(8.hours))}",
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 34.sp, level: 5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          Global.getSetAvatarImageUrl('time_icon.png'),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "40 Mins",
                          style: CustomTextStyles.title(color: Colors.white, fontSize: 34.sp, level: 5),
                        ),
                      ],
                    ),
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
                  title: "Next",
                  disable: !logic.bSelected,
                  onPress: () async {
                    EasyLoading.show(status: "waiting...", maskType: EasyLoadingMaskType.black);
                    try {
                      Global.setTableId(logic.selectedTableId!);
                      final userId = await logic.loginInOrRegister(
                        name: customer.name,
                        email: customer.email,
                        phone: customer.phone,
                      );
                      await logic.customerCheckIn(showId: showInfo.showId, userId: userId);
                      EasyLoading.dismiss(animation: false);
                      // await Get.to(
                      //   () => CompletePage(
                      //     tableId: logic.selectedTableId!,
                      //     startTime: showInfo.startTime,
                      //     customer: customer,
                      //   ),
                      //   preventDuplicates: false,
                      // );

                      // await Get.to(
                      //   () => PlayerInfoShow(
                      //     showInfo: showInfo,
                      //     customer: customer,
                      //   ),
                      //   preventDuplicates: false,
                      // );

                      Map headgearObj = await logic.fetchHeadgearInfo(userId);
                      print("嘿嘿嘿嘿 ${headgearObj.isEmpty}");
                      if (headgearObj.isEmpty) {
                        Get.offAll(
                            () => PlayerInfoDeskShow(
                                  showInfo: showInfo,
                                  customer: customer,
                                ),
                            arguments: showInfo);
                      } else {
                        // await Get.offAll(() => HeadgearAcquisitionPage(showInfo: showInfo, customer: customer, headgearObj: headgearObj, userId: userId));
                        Get.offAll(
                          () => HeadgearAcquisitionPage(),
                          arguments: {
                            'showInfo': showInfo,
                            'customer': customer,
                            'headgearObj': headgearObj,
                            'userId': userId,
                          },
                        );
                      }
                      // Get.offAll(() => PlayerInfoDeskShow(showInfo: showInfo, customer: customer,), arguments: showInfo);
                    } on DioException catch (e) {
                      EasyLoading.dismiss();

                      // print("测试测试测试 ${logic.selectedTableId}");
                      // Global.setTableId(logic.selectedTableId!);
                      // print("哈哈哈哈哈 ${Global.tableId}");
                      // Map headgearObj = await logic.fetchHeadgearInfo(279);
                      // print("嘿嘿嘿嘿 ${headgearObj.isEmpty}");
                      // if(headgearObj.isEmpty) {
                      //   Get.offAll(() => PlayerInfoDeskShow(showInfo: showInfo, customer: customer,), arguments: showInfo);
                      // }
                      // else {
                      //   await Get.offAll(() => HeadgearAcquisitionPage(showInfo: showInfo, customer: customer, headgearObj: headgearObj, userId: 279));
                      // }

                      if (e.response == null) EasyLoading.showError("Network Error!");
                      EasyLoading.showError(e.response?.data["error"]["message"]);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
