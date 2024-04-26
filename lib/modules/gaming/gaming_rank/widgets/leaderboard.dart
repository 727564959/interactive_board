import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import '../logic.dart';
import 'record_list.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 0.45.sh),
      width: 900.w,
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.w, bottom: 60.w),
      decoration: const BoxDecoration(
        color: Color(0xff5E6F96),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Leaderboard",
            style: CustomTextStyles.title3(
              color: Colors.white,
              fontSize: 40.sp,
            ),
          ),
          SizedBox(height: 10.w),
          GetBuilder<GamingRankLogic>(
            builder: (logic) {
              return RecordList();
            },
          ),
        ],
      ),
    );
  }
}
