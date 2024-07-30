import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common.dart';
import '../check_in/data/avatar_info.dart';

class TermsOfUseLogic extends GetxController {
  final _dio = Dio();
  bool isSelectedOne = true;
  bool isSelectedTwo = false;
  bool isDisable = true;

  // 查询并清理头套
  Future<List<GameItemInfo>> fetchHeadgearInfo(userId) async {
    final response = await _dio.get(
      "$baseApiUrl/players/$userId/game-items",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item['gameItem']));
    }
    return result;
  }

  // 查询单个玩家
  Future<Map> fetchSingleUsers(id) async {
    print("是否进入了查询单个玩家方法");
    final response = await _dio.get("$baseApiUrl/players/$id/base");

    Map<String, dynamic> result = response.data;
    return result;
  }

  void refreshFun() {
    update(['TermsOfUsePage']);
  }

  @override
  void onInit() async {
    super.onInit();
    update();
  }
}