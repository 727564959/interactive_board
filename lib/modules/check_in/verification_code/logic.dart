import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/check_in/data/show.dart';
import '../../../common.dart';
import '../data/booking.dart';

class VerificationCodeLogic extends GetxController {
  final _dio = Dio();
  final codeController = TextEditingController();
  final focusNode = FocusNode();

  // bool isButtonShow = false;
  // 0：初始状态 1：迟到 2：早到 -1：报错
  int isStateShow = 0;
  String bookingDate = "";
  String bookingTime = "";
  String bookingEnd = "";
  // // 0：初始状态 1：迟到 2：早到
  // int isShowMasking = 0;

  void updateStateShowFun(int judgeVal) {
    isStateShow = judgeVal;
    focusNode.unfocus();
    update(["verificationPage"]);
  }

  // void updatePageFun(int judgeVal) {
  //   isShowMasking = judgeVal;
  //   update(["verificationMasking"]);
  // }

  // void updateStateFun(bool judgeVal) {
  //   isButtonShow = judgeVal;
  //   focusNode.unfocus();
  //   update(["verificationPage"]);
  // }

  Future<BookingInfo> queryBookInfo(String code) async {
    final response = await _dio.get(
      "$baseApiUrl/shows/booking",
      queryParameters: {"code": code},
    );
    return BookingInfo.fromJson(response.data);
  }

  // Future<ShowInfo> bookingTimeChecked(DateTime bookingTime) async {
  //   final response = await _dio.get(
  //     "$baseApiUrl/shows/booking-time-checked",
  //     queryParameters: {"bookingTime": bookingTime},
  //   );
  //   final showInfo = ShowInfo.fromJson(response.data);
  //   return showInfo;
  // }
  Future<ShowInfo> bookingTimeChecked(String startTime) async {
    final response = await _dio.get(
      "$baseApiUrl/shows/booking-time-checked",
      queryParameters: {"bookingTime": startTime},
    );
    final showInfo = ShowInfo.fromJson(response.data);
    return showInfo;
  }

  Future<ShowInfo> ticketValidation(String code, DateTime bookingTime) async {
    final response1 = await _dio.get(
      "$baseApiUrl/shows/booking-time-checked",
      queryParameters: {"bookingTime": bookingTime},
    );
    final showInfo = ShowInfo.fromJson(response1.data);
    // await _dio.post("$baseResovaUrl/ticket-validation", data: {"code": code});
    return showInfo;
  }
}
