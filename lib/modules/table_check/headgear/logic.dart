import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common.dart';
import '../../../data/model/show_state.dart';

class HeadgearLogic extends GetxController {
  final _dio = Dio();

  bool isClickCard = false;
  Map argumentsMap = Get.arguments;
  late ShowState showState;
  late List headgearObj;
  late int userId;
  late int clickSelectId;

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
    showState = argumentsMap['showState'];
    headgearObj = argumentsMap['headgearObj'];
    userId = argumentsMap['userId'];
    update();
  }
}
