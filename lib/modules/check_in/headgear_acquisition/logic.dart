import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/check_in/data/show.dart';
import '../../../common.dart';
import '../data/booking.dart';

class HeadgearAcquisitionLogic extends GetxController {
  final _dio = Dio();

  Map argumentsMap = Get.arguments;
  late ShowInfo showInfo;
  late Customer customer;
  late List headgearObj;
  late int userId;
  late int clickSelectId;
  bool isClickCard = false;

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
