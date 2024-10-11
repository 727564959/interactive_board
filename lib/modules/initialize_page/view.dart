import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/modules/initialize_page/logic.dart';

import '../../common.dart';

class InitializePage extends StatelessWidget {
  InitializePage({Key? key}) : super(key: key);
  final logic = Get.find<InitializeLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onLongPress: () {
          if (logic.deviceId.value == "") return;
          Get.dialog(Dialog(
            child: SizedBox(
              height: 500.w,
              width: 500.w,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () async {
                          await Dio().patch("$basePayloadApiUrl/board-configs/${logic.deviceId.value}", data: {
                            "checked": true,
                            "type": "check_in",
                          });
                          logic.loadBoardConfig();
                          Get.back();
                        },
                        child: const Text("check in")),
                    TextButton(
                      onPressed: () async {
                        await Dio().patch("$basePayloadApiUrl/board-configs/${logic.deviceId.value}", data: {
                          "checked": true,
                          "type": "interact",
                          "tableId": 1,
                        });
                        logic.loadBoardConfig();
                        Get.back();
                      },
                      child: const Text("table 1"),
                    ),
                    TextButton(
                        onPressed: () async {
                          await Dio().patch("$basePayloadApiUrl/board-configs/${logic.deviceId.value}", data: {
                            "checked": true,
                            "type": "interact",
                            "tableId": 2,
                          });
                          logic.loadBoardConfig();
                          Get.back();
                        },
                        child: const Text("table 2")),
                    TextButton(
                        onPressed: () async {
                          await Dio().patch("$basePayloadApiUrl/board-configs/${logic.deviceId.value}", data: {
                            "checked": true,
                            "type": "interact",
                            "tableId": 3,
                          });
                          logic.loadBoardConfig();
                          Get.back();
                        },
                        child: const Text("table 3")),
                    TextButton(
                        onPressed: () async {
                          await Dio().patch("$basePayloadApiUrl/board-configs/${logic.deviceId.value}", data: {
                            "checked": true,
                            "type": "interact",
                            "tableId": 4,
                          });
                          logic.loadBoardConfig();
                          Get.back();
                        },
                        child: const Text("table 4")),
                  ],
                ),
              ),
            ),
          ));
        },
        child: Container(
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
      ),
    );
  }
}
