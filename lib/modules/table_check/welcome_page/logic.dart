import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common.dart';
import '../../../data/model/show_state.dart';

class TableLogicLogic extends GetxController {
  final _dio = Dio();

  CustomerItem get customer {
    final customers = (showState.details as ShowPreparingDetails).customers;
    for (final item in customers) {
      if (item.tableId == Global.tableId) {
        return item;
      }
    }
    throw StateError("");
  }

  ShowState get showState => Get.arguments;
  DateTime get startTime => (showState.details as ShowPreparingDetails).startTime;
}
