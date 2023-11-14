import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../common.dart';

class CheckInPage extends StatelessWidget {
  CheckInPage({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: 1.0.sw,
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                width: 1.0.sw,
                child: GetBuilder<CheckInLogic>(
                  builder: (logic) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Leaderboard(width: 700.w),
                        // PlayerDisplay(width: 580.w),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Text(
            "Table ${Global.tableId}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 80.sp,
              decoration: TextDecoration.none,
              fontFamily: 'Burbank',
              color: Colors.white,
            ),
          ),
        ),
      ],
    ));
  }
}
