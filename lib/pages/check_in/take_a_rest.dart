import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../common.dart';

class TakeARestPage extends StatelessWidget {
  TakeARestPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

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
                  SizedBox(
                    width: 1.0.sw,
                    height: 0.1.sh,
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 0.8.sw),
                              child: SizedBox(
                                width: 0.08.sw,
                                child: Text(
                                  "09:56",
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0, left: 0.0),
                              child: SizedBox(
                                width: 0.12.sw,
                                child: Text(
                                  "Table 1",
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.deepOrange,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    )
                  ),
                  SizedBox(
                    width: 1.0.sw,
                    height: 0.25.sh,
                    child: Container(
                        margin: EdgeInsets.only(top: 20.0, right: 0.65.sw),
                        child: Image.asset(
                          Global.getSetAvatarImageUrl('take_a_rest_icon.png'),
                          fit: BoxFit.fitHeight,
                        ),
                    ),
                  ),
                  SizedBox(
                    width: 1.0.sw,
                    height: 0.6.sh,
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 0.0),
                              child: SizedBox(
                                width: 0.8.sw,
                                child: Text(
                                  "Take a Rest",
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
                        );
                      },
                    ),
                  ),
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