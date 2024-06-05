import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../common.dart';
import '../../../data/model/show_state.dart';
import '../data/user_info.dart';

class GameShowEndLogic extends GetxController {
  final _dio = Dio();

  // ShowState get showState => Get.arguments;
  String jsonString = ''' 
        {
    "showId": 59,
    "status": "choose_player",
    "details": {
        "showId": 59,
        "startDate": "2024-05-17",
        "startTime": "00:45:00",
        "roundId": 120,
        "roundNumber": 1,
        "totalRound": 1,
        "mode": "normal",
        "game": "Jackpot In Pairs",
        "customers": [],
        "teams": [
            {
                "name": "RABBIT",
                "teamId": 3,
                "iconPath": "/uploads/RABBIT_84f4ce33a2.png",
                "noBorderIconPath": "/uploads/RABBIT_a643234a19.png"
            },
            {
                "name": "OCTOPUS",
                "teamId": 4,
                "iconPath": "/uploads/OCTOPUS_4b4cce8c91.png",
                "noBorderIconPath": "/uploads/OCTOPUS_3c2d3fe5f6.png"
            },
            {
                "name": "PANTHER",
                "teamId": 2,
                "iconPath": "/uploads/PANTHER_ee552a9eda.png",
                "noBorderIconPath": "/uploads/PANTHER_a51915c9a9.png"
            },
            {
                "name": "FOX",
                "teamId": 1,
                "iconPath": "/uploads/FOX_4697eff882.png",
                "noBorderIconPath": "/uploads/FOX_a54ae92df1.png"
            }
        ]
    }
}
   ''';

  // // 游戏名称
  // String get gameName => (showState.details as GamingDetails).game;
  String gameName = "";
  List<UserInfo> userList = [];

  Future<List<UserInfo>> fetchUserList(showId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    final response = await _dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {"tableId": Global.tableId},
    );
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user, Global.tableId)).toList();
  }

  @override
  void onInit() async {
    Map<String, dynamic> jsonData = json.decode(jsonString);
    ShowState showState = ShowState.fromJson(jsonData);
    // 游戏名称
    gameName = (showState.details as GamingDetails).game;
    print("gameName ${gameName}");
    Global.setTableId(1);
    userList = await fetchUserList(showState.showId);
    print("userList $userList");
    update();
  }
}