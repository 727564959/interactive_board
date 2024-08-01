import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common.dart';
import '../data/show.dart';
import 'booking_state.dart';


class HomeLogic extends GetxController {
  final _dio = Dio();

  // String jsonString1 = '''
  //         {
  //           "bookings": [
  //                   {
  //                   "id": 58,
  //                   "transactionId": 58,
  //                   "bookingDate": "2024-07-25",
  //                   "bookingTime": "15:00:00",
  //                   "during": 60,
  //                   "quantity": 1,
  //                   "status": "pending",
  //                   "tableId": null,
  //                   "customerId": 25,
  //                   "createTime": "2024-07-25T07:33:47.947Z",
  //                   "updateTime": "2024-07-25T07:33:47.947Z",
  //                   "customer": {
  //                       "id": 25,
  //                       "firstName": "Gggggfgh",
  //                       "lastName": "Ddddd",
  //                       "telephone": "1235564654",
  //                       "email": "danny.luo@miraverse.net",
  //                       "createTime": "2024-07-25T07:33:47.947Z",
  //                       "updateTime": "2024-07-25T07:33:47.947Z"
  //                   }
  //               },
  //
  //               {
  //                   "id": 60,
  //                   "transactionId": 60,
  //                   "bookingDate": "2024-07-25",
  //                   "bookingTime": "15:00:00",
  //                   "during": 60,
  //                   "quantity": 1,
  //                   "status": "onGaming",
  //                   "tableId": 4,
  //                   "customerId": 27,
  //                   "createTime": "2024-07-25T07:33:47.947Z",
  //                   "updateTime": "2024-07-25T07:33:47.947Z",
  //                   "customer": {
  //                       "id": 27,
  //                       "firstName": "Aaaaaaaaaaaaaaa",
  //                       "lastName": "Bffffff",
  //                       "telephone": "1235564654",
  //                       "email": "danny.luo@miraverse.net",
  //                       "createTime": "2024-07-25T07:33:47.947Z",
  //                       "updateTime": "2024-07-25T07:33:47.947Z"
  //                   }
  //               },
  //               {
  //                   "id": 67,
  //                   "transactionId": 67,
  //                   "bookingDate": "2024-07-27",
  //                   "bookingTime": "20:00:00",
  //                   "during": 60,
  //                   "quantity": 1,
  //                   "status": "onGaming",
  //                   "tableId": 2,
  //                   "customerId": 34,
  //                   "createTime": "2024-07-27T11:22:51.544Z",
  //                   "updateTime": "2024-07-27T11:22:51.544Z",
  //                   "customer": {
  //                       "id": 34,
  //                       "firstName": "M",
  //                       "lastName": "Zq",
  //                       "telephone": "6561615616",
  //                       "email": "mu15215217793@gmail.com",
  //                       "createTime": "2024-07-27T11:22:51.544Z",
  //                       "updateTime": "2024-07-27T11:22:51.544Z"
  //                   }
  //               }
  //           ]
  //       }
  //  ''';
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

  Future<void> getBookingStateFun() async {
    List<BookingState> bookingStateList = await getBookingStatus();
    // Map<String, dynamic> jsonData = json.decode(jsonString1);
    // List<dynamic> bookingsList = jsonData["bookings"];
    // List<BookingState> bookingStateList = bookingsList.map((booking) => BookingState.fromJson(booking)).toList();
    if(bookingStateList.length > 0) {
      // 不足4个需要补足，避免重新排序赋值时越界
      if(bookingStateList.length < 4) {
        List<BookingState> newList = [];
        for(int m = 0; m < (4 - bookingStateList.length); m++) {
          Customer customer = Customer(
              userId: -1,
              firstName: "Z",
              lastName: "Z",
              name: "",
              phone: "",
              email: ""
          );
          newList.add(BookingState(
            bookingId: -1,
            transactionId: -1,
            bookingDate: "",
            bookingTime: "",
            status: "",
            tableId: null,
            customer: customer,
          ));
        }
        bookingStateList = [...bookingStateList, ...newList];
      }

      List<BookingState> sortedBookings = bookingStateList.where((element) => element.tableId != null).toList();
      sortedBookings.sort((a, b) => a.tableId!.compareTo(b.tableId!));
      print("sortedBookings ${sortedBookings}");
      List<BookingState> nullTableIdBookings = bookingStateList.where((element) => element.tableId == null).toList();
      nullTableIdBookings.sort((a, b) => a.customer.firstName[0].compareTo(b.customer.firstName[0]));
      print("nullTableIdBookings ${nullTableIdBookings}");
      for (int i = 0, j = 0, k = 0; i < bookingStateList.length; i++) {
        if(sortedBookings.length > 0 && nullTableIdBookings.length > 0) {
          if((i + 1) == sortedBookings[j].tableId) {
            bookingStateList[i] = sortedBookings[j];
            if((j + 1) < sortedBookings.length) {
              j++;
            }
          }
          else {
            bookingStateList[i] = nullTableIdBookings[k];
            if((k + 1) < nullTableIdBookings.length) {
              k++;
            }
          }
        }
        else if(sortedBookings.length <= 0) {
          bookingStateList = nullTableIdBookings;
        }
        else if(nullTableIdBookings.length <= 0) {
          bookingStateList = sortedBookings;
        }
        // if((i + 1) == sortedBookings[j].tableId) {
        //   bookingStateList[i] = sortedBookings[j];
        //   j++;
        // }
        // else {
        //   bookingStateList[i] = nullTableIdBookings[k];
        //   k++;
        // }
      }
      print("bookingStateList ${bookingStateList}");
      bookingState = bookingStateList;
      refreshFun();
    }
    else {
      // bookingState = [];
      for(int m = 0; m < 4; m++) {
        Customer customer = Customer(
            userId: -1,
            firstName: "Z",
            lastName: "Z",
            name: "",
            phone: "",
            email: ""
        );
        bookingStateList.add(BookingState(
          bookingId: -1,
          transactionId: -1,
          bookingDate: "",
          bookingTime: "",
          status: "",
          tableId: null,
          customer: customer,
        ));
      }
      bookingState = bookingStateList;
      refreshFun();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getBookingStateFun();
    update();
  }
}