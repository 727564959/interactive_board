import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common.dart';
import '../check_in/data/casual_user.dart';
import '../check_in/data/show.dart';

class UserRegistrationLogic extends GetxController {
  final _dio = Dio();
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  int get tableId => Get.arguments["tableId"];
  final emailController = TextEditingController();
  final focusNode = FocusNode();
  final nicknameController = TextEditingController();
  final focusNode1 = FocusNode();
  List<CasualUser> casualUser = [];

  String getBayString(tableId) {
    if (tableId == 1) {
      return "A";
    } else if (tableId == 2) {
      return "B";
    } else if (tableId == 3) {
      return "C";
    } else {
      return "D";
    }
  }

  // 根据邮箱查用户
  Future<Map> checkingPlayer(String email) async {
    print("通过邮箱进行玩家查重");
    print("object $email");
    try {
      final response = await _dio.get(
        "$baseApiUrl/players/query-id",
        queryParameters: {"email": email},
      );
      print("object $response");
      Map<String, dynamic> result = response.data;
      return result;
    } on DioException {
      Map<String, dynamic> result = {};
      return result;
    }
  }

  // 查询单个玩家
  Future<Map> fetchSingleUsers(id) async {
    print("是否进入了查询单个玩家方法");
    final response = await _dio.get("$baseApiUrl/players/$id/base");

    Map<String, dynamic> result = response.data;
    return result;
  }

  Future<List<CasualUser>> fetchCasualUser(int showId, int tableId) async {
    final response = await _dio.get(
      "$baseApiUrl/shows/$showId/check-in/players",
      queryParameters: {"tableId": tableId},
    );
    List casualUser = response.data;
    return casualUser.map((user) => CasualUser.fromJson(user)).toList();
  }

  Future<void> updateUserPreference(userId, String nickname) async {
    final response = await _dio.post(
      "$baseApiUrl/players/$userId/update-user-preference",
      data: {
        "nickname": nickname,
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    casualUser = await fetchCasualUser(showInfo.showId, tableId);
    int num = casualUser.length;
    nicknameController.text = getBayString(tableId) + num.toString();
    update();
  }
}