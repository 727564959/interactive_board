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

  bool isButtonShow = false;
  String bookingDate = "";
  String bookingTime = "";
  String bookingEnd = "";
  // 0：初始状态 1：迟到 2：早到
  int isShowMasking = 0;

  void updatePageFun(int judgeVal) {
    isShowMasking = judgeVal;
    update(["verificationMasking"]);
  }

  void updateStateFun(bool judgeVal) {
    isButtonShow = judgeVal;
    update(["verificationPage"]);
  }

  Future<BookingInfo> queryBookInfo(String code) async {
    final response = await _dio.get(
      "$baseResovaUrl/booking-info",
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
  Future<ShowInfo> bookingTimeChecked(String bookingTime, String bookingDate) async {
    final response = await _dio.get(
      "$baseApiUrl/shows/booking-time-checked",
      queryParameters: {"bookingTime": bookingTime, "bookingDate": bookingDate},
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
