import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_icon_button.dart';
import '../data/show.dart';
import '../player_page/player_squad.dart';
import 'booking_state.dart';

class ConfirmationSquadPage extends StatelessWidget {
  ConfirmationSquadPage({Key? key}) : super(key: key);
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;

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
                  Container(
                    margin: EdgeInsets.only(top: 0.2.sh,),
                    child: Text(
                      "Are you part of Emily soup's squad?",
                      style: CustomTextStyles.title(
                          color: Color(0xFFFFFFFF),
                          fontSize: 48.sp,
                          level: 2
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.42.sh),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                          width: 600.w,
                          height: 100.h,
                          btnText: "NO",
                          btnBgColor: Color(0xFF272727),
                          textColor: Color(0xffFFFFFF),
                          onPress: () async {
                            Get.back();
                          },
                          borderColor: Color(0xff13EFEF),
                          changedBorderColor: Color(0xffA4EDF1),
                          changedTextColor: Color(0xffA4EDF1),
                          changedBgColor: Color(0xFF272727),
                        ),
                        SizedBox(width: 20,),
                        CommonButton(
                          width: 600.w,
                          height: 100.h,
                          btnText: 'YES',
                          btnBgColor: Color(0xff13EFEF),
                          textColor: Colors.black,
                          onPress: () async {
                            Get.offAll(() => PlayerSquadPage(),
                                arguments: {
                                  'showInfo': showInfo,
                                  "bookingState": bookingState,
                                  "isAddPlayerClick": true,
                                  "tableId": int.parse(bookingState.tableId.toString()),
                                });
                          },
                          changedBgColor: Color(0xffA4EDF1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}