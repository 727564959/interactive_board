import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../widgets/check_in_title.dart';
import 'logic.dart';

class HonorPage extends StatelessWidget {
  HonorPage({Key? key}) : super(key: key);
  final logic = Get.find<HonorLogic>();

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
                          margin: EdgeInsets.only(top: 10.0, left: 0.0),
                          child: SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              "Take a Rest",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 150.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.white,
                                letterSpacing: 3.sp,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 0.0),
                          child: SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              "We will be back soon",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'BurbankBold',
                                color: Colors.white,
                                letterSpacing: 3.sp,
                              ),
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