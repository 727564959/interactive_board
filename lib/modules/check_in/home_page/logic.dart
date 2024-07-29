import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common.dart';
import '../data/show.dart';
import 'booking_state.dart';


class HomeLogic extends GetxController {
  final _dio = Dio();

  List<BookingState> bookingState = [];

  Future<List<BookingState>> getBookingStatus() async {
    print("12345上山打老虎");
    final response = await _dio.get(
      "$baseApiUrl/shows/booking-status",
    );
    print("response.data ${response.data}");
    List bookingsList = response.data['bookings'];
    return bookingsList.map((bookings) => BookingState.fromJson(bookings)).toList();
  }

  Future<ShowInfo> bookingTimeChecked(String bookingTime, String bookingDate) async {
    final response = await _dio.get(
      "$baseApiUrl/shows/booking-time-checked",
      queryParameters: {"bookingTime": bookingTime, "bookingDate": bookingDate},
    );
    final showInfo = ShowInfo.fromJson(response.data);
    return showInfo;
  }

  void refreshFun() {
    update(["landingCheckInPage"]);
  }

  @override
  void onInit() async {
    super.onInit();
    bookingState = await getBookingStatus();
    update();
  }
}