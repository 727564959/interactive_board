import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common.dart';
import '../data/show.dart';
import 'booking_state.dart';


class HomeLogic extends GetxController {
  final _dio = Dio();

  String jsonString1 = '''
          {
            "bookings": [
                    {
                    "id": 58,
                    "transactionId": 58,
                    "bookingDate": "2024-07-25",
                    "bookingTime": "15:00:00",
                    "during": 60,
                    "quantity": 1,
                    "status": "pending",
                    "tableId": null,
                    "customerId": 25,
                    "createTime": "2024-07-25T07:33:47.947Z",
                    "updateTime": "2024-07-25T07:33:47.947Z",
                    "customer": {
                        "id": 25,
                        "firstName": "Gggggfgh",
                        "lastName": "Ddddd",
                        "telephone": "1235564654",
                        "email": "danny.luo@miraverse.net",
                        "createTime": "2024-07-25T07:33:47.947Z",
                        "updateTime": "2024-07-25T07:33:47.947Z"
                    }
                },
                {
                    "id": 59,
                    "transactionId": 59,
                    "bookingDate": "2024-07-25",
                    "bookingTime": "15:00:00",
                    "during": 60,
                    "quantity": 1,
                    "status": "pending",
                    "tableId": null,
                    "customerId": 26,
                    "createTime": "2024-07-25T07:33:47.947Z",
                    "updateTime": "2024-07-25T07:33:47.947Z",
                    "customer": {
                        "id": 26,
                        "firstName": "Zzzzzzzzzz",
                        "lastName": "Kkkkkk",
                        "telephone": "1235564654",
                        "email": "danny.luo@miraverse.net",
                        "createTime": "2024-07-25T07:33:47.947Z",
                        "updateTime": "2024-07-25T07:33:47.947Z"
                    }
                },
                {
                    "id": 60,
                    "transactionId": 60,
                    "bookingDate": "2024-07-25",
                    "bookingTime": "15:00:00",
                    "during": 60,
                    "quantity": 1,
                    "status": "onGaming",
                    "tableId": 4,
                    "customerId": 27,
                    "createTime": "2024-07-25T07:33:47.947Z",
                    "updateTime": "2024-07-25T07:33:47.947Z",
                    "customer": {
                        "id": 27,
                        "firstName": "Aaaaaaaaaaaaaaa",
                        "lastName": "Bffffff",
                        "telephone": "1235564654",
                        "email": "danny.luo@miraverse.net",
                        "createTime": "2024-07-25T07:33:47.947Z",
                        "updateTime": "2024-07-25T07:33:47.947Z"
                    }
                },
                {
                    "id": 67,
                    "transactionId": 67,
                    "bookingDate": "2024-07-27",
                    "bookingTime": "20:00:00",
                    "during": 60,
                    "quantity": 1,
                    "status": "onGaming",
                    "tableId": 2,
                    "customerId": 34,
                    "createTime": "2024-07-27T11:22:51.544Z",
                    "updateTime": "2024-07-27T11:22:51.544Z",
                    "customer": {
                        "id": 34,
                        "firstName": "M",
                        "lastName": "Zq",
                        "telephone": "6561615616",
                        "email": "mu15215217793@gmail.com",
                        "createTime": "2024-07-27T11:22:51.544Z",
                        "updateTime": "2024-07-27T11:22:51.544Z"
                    }
                }
            ]
        }
   ''';
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
    // Map<String, dynamic> jsonData = json.decode(jsonString1);
    // List<dynamic> bookingsList = jsonData["bookings"];
    // bookingState = bookingsList.map((booking) => BookingState.fromJson(booking)).toList();
    print("原始 ${bookingState}");
    // 对 data 数组进行排序
    bookingState.sort((a, b) => a.customer.firstName[0].compareTo(b.customer.firstName[0]));
    // bookingState.sort(
    //       (a, b) {
    //     if (a.tableId == null && b.tableId == null) {
    //       return 0;
    //     } else if (a.tableId == null) {
    //       return -1;
    //     } else if (b.tableId == null) {
    //       return 1;
    //     } else {
    //       return a.tableId!.compareTo(b.tableId!);
    //     }
    //   },
    // );
    print("排序 ${bookingState}");

    update(["landingCheckInPage"]);
  }
}