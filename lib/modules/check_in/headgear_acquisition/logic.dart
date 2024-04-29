import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/check_in/data/show.dart';
import '../../../common.dart';
import '../data/booking.dart';

class HeadgearAcquisitionLogic extends GetxController {
  final _dio = Dio();

  bool isClickCard = false;
  Map argumentsMap = Get.arguments;
  late ShowInfo showInfo;
  late Customer customer;
  late Map headgearObj;
  late int userId;

  void updateHeadgearPageFun() {
    if(!isClickCard) {
      isClickCard = true;
      Future.delayed(1.2.seconds).then((value) async {
        // 刷新当前页面
        update(['headgearAcquisitionPage']);
      });
    }
    else {
      isClickCard = false;
      // 刷新当前页面
      update(['headgearAcquisitionPage']);
    }
    // // 刷新当前页面
    // update(['headgearAcquisitionPage']);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("是否初始化进入");
    print("Get arguments: ${argumentsMap}");
    print("Get arguments.userId: ${argumentsMap['userId']}");
    showInfo = argumentsMap['showInfo'];
    customer = argumentsMap['customer'];
    headgearObj = argumentsMap['headgearObj'];
    userId = argumentsMap['userId'];
    update();
  }
}
