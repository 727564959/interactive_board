import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/check_in/data/show.dart';
import '../../../common.dart';
import '../data/booking.dart';

class HeadgearAcquisitionLogic extends GetxController {
  final _dio = Dio();

  bool isClickCard = false;

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
}
