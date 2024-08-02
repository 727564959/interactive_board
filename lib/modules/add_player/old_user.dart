import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../data/model/show_state.dart';
import '../../mirra_style.dart';
import '../../widgets/check_in_title.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_icon_button.dart';
import '../check_in/data/show.dart';
import '../check_in/home_page/booking_state.dart';
import '../term_of_use/view.dart';

class OldUserPage extends StatelessWidget {
  OldUserPage({Key? key}) : super(key: key);
  Map get singlePlayer => Get.arguments["singlePlayer"];
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  String get isFlow => Get.arguments["isFlow"];
  ShowState get showState => Get.arguments?["showState"];
  int get tableId => Get.arguments["tableId"];

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
                  Container(
                    width: 1.0.sw,
                    margin: EdgeInsets.only(top: 20.0, left: 40.0),
                    child: Row(
                      children: [
                        CommonIconButton(
                          onPress: () {
                            Get.back();
                          },
                        ),
                        SizedBox(width: 0.1.sw - 48 - 40,),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 0.25.sh,
                      child: Image.asset(
                        Global.getGifUrl('Welcome.gif'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Welcome back",
                        style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 2),
                      ),
                      Text(
                        singlePlayer['firstName'] + singlePlayer['lastName'].substring(0, 1) + " !",
                        style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.15.sh,),
                  CommonButton(
                    width: 600.w,
                    height: 100.h,
                    btnText: 'NEXT',
                    btnBgColor: Color(0xff13EFEF),
                    textColor: Colors.black,
                    onPress: () async {
                      print("bookingState ${bookingState}");
                      if(isFlow == "checkIn") {
                        await Get.to(() => TermsOfUse(), arguments: {
                          "isAddPlayerClick": true,
                          "showInfo": showInfo,
                          "bookingState": bookingState,
                          "isFlow": "checkIn",
                          "userId": singlePlayer['id'],
                          // "tableId": bookingState.tableId,
                          "tableId": tableId,
                        });
                      }
                      else if(isFlow == "tableCheck") {
                        await Get.to(() => TermsOfUse(), arguments: {
                          "isAddPlayerClick": true,
                          "showState": showState,
                          "bookingState": bookingState,
                          "isFlow": "tableCheck",
                          "userId": singlePlayer['id'],
                        });
                      }
                    },
                    changedBgColor: Color(0xffA4EDF1),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}