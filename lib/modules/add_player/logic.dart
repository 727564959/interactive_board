import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common.dart';
import '../check_in/data/avatar_info.dart';
import '../check_in/data/casual_user.dart';
import '../check_in/data/show.dart';
import '../game_over/statistics/data/team_info.dart';
import 'data/search_user.dart';

class UserRegistrationLogic extends GetxController {
  final _dio = Dio();
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  int get tableId => Get.arguments["tableId"];
  final emailController = TextEditingController();
  final focusNode = FocusNode();
  String errorText = "";
  final nicknameController = TextEditingController();
  final focusNode1 = FocusNode();
  List<CasualUser> casualUser = [];
  var isExist = false.obs;
  int? selectedId;

  void updateState(judge) {
    isExist.value = judge;
  }

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

  // 敏感字判断
  Future<Map> sensitiveWordDetector(text) async {
    print("敏感字判断");
    print(text);
    final response = await _dio.get(
        "https://inb27b1nma.execute-api.us-east-1.amazonaws.com/bad-words-checked",
        queryParameters: {"text": text}
    );
    print(response.data);
    Map<String, dynamic> result = json.decode(response.data);
    return result;
  }

  // 同步邮箱信息
  Future<void> syncRemote({
    required String email
  }) async {
    await _dio.post(
      "$baseApiUrl/players/sync-remote",
      data: {
        "email": email,
      },
    );
  }

  // 查询并清理头套
  Future<List<GameItemInfo>> fetchHeadgearInfo(userId) async {
    final response = await _dio.get(
      // "$baseApiUrl/players/$userId/game-items",
      "$baseApiUrl/users/$userId/assets",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item['gameItem']));
    }
    return result;
  }

  // 查询限定头套
  Future<List<GameItemInfo>> fetchLimitedHeadgear() async {
    final response = await _dio.get(
      "$baseApiUrl/headgears/limited",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item['gameItem']));
    }
    return result;
  }
  // // 查询万圣节头套
  // Future<List<GameItemInfo>> fetchHallowmas() async {
  //   final response = await _dio.get(
  //     "$baseApiUrl/headgears/hallowmas",
  //   );
  //   final result = <GameItemInfo>[];
  //   for (final item in response.data) {
  //     result.add(GameItemInfo.fromJson(item['gameItem']));
  //   }
  //   return result;
  // }

  // 根据邮箱查用户
  Future<List<SearchUser>> checkingPlayer(String email) async {
    print("通过邮箱进行玩家查重");
    print("object $email");
    try {
      final response = await _dio.get(
        // "$baseApiUrl/players/search",
        "$baseApiUrl/users/by-email",
        queryParameters: {"email": email},
      );
      List result = response.data;
      return result.map((data) => SearchUser.fromJson(data)).toList();
    } on DioException catch (e) {
      print("object $e");
      return [];
    }
  }
  // Future<Map> checkingPlayer(String email) async {
  //   print("通过邮箱进行玩家查重");
  //   print("object $email");
  //   try {
  //     final response = await _dio.get(
  //       "$baseApiUrl/players/query-id",
  //       queryParameters: {"email": email},
  //     );
  //     print("object $response");
  //     Map<String, dynamic> result = response.data;
  //     return result;
  //   } on DioException {
  //     Map<String, dynamic> result = {};
  //     return result;
  //   }
  // }

  // 查询单个玩家
  Future<SearchUser> fetchSingleUsers(id) async {
    // print("是否进入了查询单个玩家方法");
    // final response = await _dio.get("$baseApiUrl/players/$id/base");
    //
    // Map<String, dynamic> result = response.data;
    // return result;
    final response = await _dio.get("$baseApiUrl/users/$id");
    print("用户信息 $response");
    final data = response.data;
    return SearchUser.fromJson({...data});
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

  // 查询队伍信息
  Future<List<TeamInfo>> fetchTeamInfo(showId) async {
    print("是否进入了查询队伍信息方法");
    final response = await _dio.get(
        "$baseApiUrl/shows/$showId/team-info"
    );
    List teamList = response.data;
    return teamList.map((team) => TeamInfo.fromJson(team)).toList();
  }

  // 玩家加入show
  Future<void> addPlayerToShow(int showId, int tableId, int userId) async {
    final firstMap = tableId != null ? {"tableId": tableId} : {};
    final secondMap = userId != null ? {"userId": userId} : {};
    final result = {
      ...firstMap,
      ...secondMap,
    };
    await _dio.post("$baseApiUrl/shows/$showId/player-joined", data: result);
    print("哈哈哈哈哈 $result");
  }

  Future<void> defaultNicknameFun() async {
    casualUser = await fetchCasualUser(showInfo.showId, tableId);
    int num = casualUser.length;
    // nicknameController.text = getBayString(tableId) + num.toString();
    String suffixNum = num > 9 ? num.toString() : ("0" + num.toString());
    List<TeamInfo> teamList = await fetchTeamInfo(showInfo.showId);
    for(int i = 0; i < teamList.length; i++) {
      if(teamList[i].teamId == tableId) {
        nicknameController.text = teamList[i].name + "_" + suffixNum;
      }
    }
  }

  void refreshUserAuthenticatorPage() {
    update(['UserAuthenticatorPage']);
  }
  void refreshUserSelectionPage() {
    update(['UserSelectionPage']);
  }

  @override
  void onInit() async {
    super.onInit();
    update();
  }
}