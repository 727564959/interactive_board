import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common.dart';
import '../../../data/model/show_state.dart';

class TableLogicLogic extends GetxController {
  final _dio = Dio();

  Map singlePlayer = {};
  // 当前桌的消费者id
  int? consumerId;
  ShowState get showState => Get.arguments;
  DateTime get startTime =>
      (showState.details as ShowPreparingDetails).startTime;

  Future<Map> fetchSingleUsers(id) async {
    print("是否进入了查询单个玩家方法");
    final response = await _dio.get("$baseApiUrl/players/$id/base");
    print("测试接口 $response");

    Map<String, dynamic> result = response.data;
    return result;
  }

  @override
  void onInit() async {
    ShowPreparingDetails showPreparingDetails = showState.details;
    List<CustomerItem> customerItem = showPreparingDetails.customers;
    for (int i = 0; i < customerItem.length; i++) {
      if (Global.tableId == customerItem[i].tableId) {
        consumerId = customerItem[i].userId;
      }
    }
    singlePlayer = await fetchSingleUsers(consumerId.toString());
    update();
  }
}