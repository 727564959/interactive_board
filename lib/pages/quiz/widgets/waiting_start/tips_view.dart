import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common.dart';
import '../border_title.dart';
import 'joined_button.dart';

class TipsView extends StatelessWidget {
  const TipsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.15.sh),
        BorderTitle(
          title: "Get Ready for Trivia Time!",
          fontSize: 130.sp,
        ),
        SizedBox(height: 0.1.sh),
        SizedBox(
          width: 0.55.sw,
          child: Text(
            "Join the Trivia Challenge for knowledge and fun. Answer 10 fun questions in just 15 seconds each, with "
            "only one right answer.\n\n Accumulate ten points for each correct answer and aim for the top score!",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 70.sp,
              decoration: TextDecoration.none,
              fontFamily: 'BurbankBold',
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 0.1.sh),
        JoinedButton(width: 250.w),
      ],
    );
  }
}
