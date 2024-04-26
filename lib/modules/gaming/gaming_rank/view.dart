import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../../../mirra_style.dart';
import '../../../pages/check_in/widgets/after_checkIn/player_info_show.dart';
import '../../../widgets/mirra_app_bar.dart';
import 'widgets/leaderboard.dart';
import 'widgets/player_display.dart';
import 'logic.dart';

class GamingRankPage extends StatelessWidget {
  GamingRankPage({Key? key}) : super(key: key);
  final logic = Get.find<GamingRankLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MirraIcons.getGameShowIconPath("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MirraAppBar(title: logic.details.game),
            Container(
              height: 0.75.sh,
              padding: EdgeInsets.only(left: 50.w, top: 20.w),
              child: Row(
                children: [
                  const Leaderboard(),
                  Expanded(child: Center(child: PlayerDisplay())),
                ],
              ),
            ),
            const Align(
              alignment: Alignment(0.9, 0),
              child: _MirraLookButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MirraLookButton extends StatelessWidget {
  const _MirraLookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Get.offNamed(AppRoutes.checkIn, arguments: Get.arguments);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xff13efef)),
        side: MaterialStateProperty.all(
          const BorderSide(color: Color(0xff13efef)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              MirraIcons.getGameShowIconPath("mirra_look_icon.png"),
              height: 50.w,
            ),
            SizedBox(width: 15.w),
            Text(
              'Mirra Look',
              style: CustomTextStyles.button(color: Colors.black, fontSize: 27.sp),
            )
          ],
        ),
      ),
    );
  }
}
