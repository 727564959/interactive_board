import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../../widgets/check_in_title.dart';
import '../logic.dart';

class NextGamePage extends StatelessWidget {
  NextGamePage({Key? key}) : super(key: key);
  final logic = Get.find<StatisticsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Colors.black,
              child: Column(
                children: [
                  // 顶部文本信息
                  CheckInTitlePage(titleText: logic.gameName),
                  SizedBox(
                    width: 1.0.sw,
                    height: 0.8.sh,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0.3.sh, left: 0.0),
                          child: SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              "Waiting For Next Game",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 80.sp, level: 1),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 0.0),
                          child: SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              "...",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 80.sp, level: 1),
                            ),
                          ),
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