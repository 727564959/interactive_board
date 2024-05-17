import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common.dart';
import '../../../data/model/show_state.dart';
import '../data/user_info.dart';

class HeadgearLogic extends GetxController {
  final _dio = Dio();

  bool isClickCard = false;
  Map argumentsMap = Get.arguments;
  late ShowState showState;
  late List headgearObj;
  late int userId;
  late int clickSelectId;

  Future<List<UserInfo>> fetchUsers(int showId, int tableId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    final response = await _dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {"tableId": tableId},
    );
    // List userList = response.data['playerList'];
    print("测试接口 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }

  Future<UserInfo> getCurrentUser(showId, tableId, userId) async {
    List<UserInfo> currentUserList = await fetchUsers(showId, tableId);
    UserInfo userData = currentUserList.firstWhere((element) => element.id == userId);
    return userData;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("是否初始化进入");
    showState = argumentsMap['showState'];
    headgearObj = argumentsMap['headgearObj'];
    userId = argumentsMap['userId'];
    update();
  }
}
