import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/check_in/data/show.dart';
import '../../../common.dart';
import '../data/user_info.dart';
import '../home_page/booking_state.dart';

class HeadgearAcquisitionLogic extends GetxController {
  final _dio = Dio();

  Map argumentsMap = Get.arguments;
  late ShowInfo showInfo;
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  late List headgearObj;
  late int userId;
  int? clickSelectId;
  bool isClickCard = false;
  late UserInfo userData;
  String playerName = "";

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
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("是否初始化进入");
    print("Get arguments: ${argumentsMap}");
    print("Get arguments.userId: ${argumentsMap['userId']}");
    showInfo = argumentsMap['showInfo'];
    headgearObj = argumentsMap['headgearObj'];
    userId = argumentsMap['userId'];

    userData = await getCurrentUser(showInfo.showId, Get.arguments["tableId"], userId);
    playerName = userData.nickname;
    update(["headgearPage"]);
    Future.delayed(2.5.seconds).then((value) async {
      print("延迟");
      isClickCard = true;
      // UserInfo userData = await getCurrentUser(showInfo.showId, Get.arguments["tableId"], userId);
      // playerName = userData.nickname;
      update(["headgearAcquisitionPage"]);
    });
    update();
  }
}
