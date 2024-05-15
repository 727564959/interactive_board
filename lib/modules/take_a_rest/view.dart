import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../mirra_style.dart';
import '../../widgets/check_in_title.dart';

class TakeARestPage extends StatelessWidget {
  TakeARestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              // color: Colors.black,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  // 顶部文本信息
                  CheckInTitlePage(titleText: ""),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.1.sw),
                      child: SizedBox(
                        height: 0.25.sh,
                        child: Image.asset(
                          Global.getGifUrl('take_a_rest.gif'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.1.sw),
                      child: SizedBox(
                        height: 0.25.sh,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 0.0),
                              child: SizedBox(
                                width: 0.8.sw,
                                child: Text(
                                  "Take a Rest",
                                  style: CustomTextStyles.display(color: Colors.white, fontSize: 106.sp, level: 1),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 0.0),
                              child: SizedBox(
                                width: 0.8.sw,
                                child: Text(
                                  "We will be back soon",
                                  style: CustomTextStyles.display(color: Colors.white, fontSize: 48.sp, level: 4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}