import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/initialize_page/logic.dart';

class InitializePage extends StatelessWidget {
  InitializePage({Key? key}) : super(key: key);
  final logic = Get.find<InitializeLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MirraIcons.getGameShowIconPath("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "UDID:    ${logic.udid.value}",
                  style: CustomTextStyles.title3(color: Colors.white, fontSize: 60.sp),
                ),
                SizedBox(height: 100.w),
                Text(
                  "Device ID:    ${logic.deviceId.value}",
                  style: CustomTextStyles.title3(color: Colors.white, fontSize: 60.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
