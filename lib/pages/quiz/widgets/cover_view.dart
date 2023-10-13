import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common.dart';

class CoverView extends StatelessWidget {
  const CoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.15.sh),
        Image.asset(
          Global.getQuizIconUrl("cover_title.png"),
          width: 0.5.sw,
        ),
        SizedBox(height: 0.1.sh),
        Container(
          width: 1.sw,
          height: 0.1.sw,
          color: const Color(0xFF171616),
          child: Center(
            child: Image.asset(
              Global.getQuizIconUrl('cover_icons.png'),
              height: 0.06.sw,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
