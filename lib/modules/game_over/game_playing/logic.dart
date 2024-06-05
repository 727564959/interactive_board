import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../app_routes.dart';
import '../../../common.dart';
import '../../../data/model/show_state.dart';
import '../data/user_info.dart';

class GamePlayingLogic extends GetxController {
  final _dio = Dio();
  late final Socket gameServerSocket;
  final option = OptionBuilder().setTransports(['websocket']).enableReconnection().disableAutoConnect().build();

  bool isWellDone = Get.arguments['isWellDone'];
  ShowState get showState => Get.arguments['showState'];
//   String jsonString = '''
//         {
//     "showId": 35,
//     "status": "choose_player",
//     "details": {
//         "showId": 35,
//         "startDate": "2024-05-17",
//         "startTime": "00:45:00",
//         "roundId": 120,
//         "roundNumber": 1,
//         "totalRound": 1,
//         "mode": "normal",
//         "game": "Jackpot In Pairs",
//         "customers": [],
//         "teams": [
//             {
//                 "name": "RABBIT",
//                 "teamId": 3,
//                 "iconPath": "/uploads/RABBIT_84f4ce33a2.png",
//                 "noBorderIconPath": "/uploads/RABBIT_a643234a19.png"
//             },
//             {
//                 "name": "OCTOPUS",
//                 "teamId": 4,
//                 "iconPath": "/uploads/OCTOPUS_4b4cce8c91.png",
//                 "noBorderIconPath": "/uploads/OCTOPUS_3c2d3fe5f6.png"
//             },
//             {
//                 "name": "PANTHER",
//                 "teamId": 2,
//                 "iconPath": "/uploads/PANTHER_ee552a9eda.png",
//                 "noBorderIconPath": "/uploads/PANTHER_a51915c9a9.png"
//             },
//             {
//                 "name": "FOX",
//                 "teamId": 1,
//                 "iconPath": "/uploads/FOX_4697eff882.png",
//                 "noBorderIconPath": "/uploads/FOX_a54ae92df1.png"
//             }
//         ]
//     }
// }
//    ''';

  // 游戏名称
  String get gameName => (showState.details as GamingDetails).game;

  List<UserInfo> userList = [];
  List<PositionInfo> positionList = [];

  // 获取用户信息
  Future<List<UserInfo>> fetchUserList(int showId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    final response = await _dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {
        "tableId": Global.tableId,
        "bJoinedCount": true,
      },
    );
    print("测试接口 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user, Global.tableId)).toList();
  }
  // 获取当前轮次的位置信息
  Future<List<PositionInfo>> fetchPositions(int roundId) async {
    print("roundId ${roundId}");
    final response = await _dio.get("$baseApiUrl/rounds/$roundId/positions");
    print("response ${response}");
    final result = <PositionInfo>[];
    for (final item in response.data) {
      print("item ${item}");
      print("item bool ${(item as Map).containsKey('tableId')}");
      if (!(item as Map).containsKey('tableId')) continue;
      final int tableId = item['tableId'];
      final UserInfo player = UserInfo.fromJson(item['player'], tableId);
      final int position = item['position'];
      if(tableId == Global.tableId) {
        result.add(PositionInfo(player: player, position: position));
      }
      // result.add(PositionInfo(player: player, position: position));
    }
    return result;
  }

  @override
  void onInit() async {
    super.onInit();

    print("baseSocketIoUrl $baseSocketIoUrl");
    gameServerSocket = io('$baseSocketIoUrl/listener/game-server', option);
    print("Socket connected: ${gameServerSocket.connected}");
    // 游戏结束监听
    gameServerSocket.on('game_over', (data) {
      print("game_over的socket");
      // Get.offAllNamed(AppRoutes.gamePlayingPage, arguments: {"showState": Get.arguments['showState'], "isWellDone": true});
      Get.arguments['isWellDone'] = true;
      isWellDone = Get.arguments['isWellDone'];
      update(["gamePlayingPage"]);
    });
    gameServerSocket.connect();
    print("Socket connected: ${gameServerSocket.connected}");

    print("gameName ${gameName}");
    positionList = await fetchPositions((showState.details as GamingDetails).roundId);
    print("positionList ${positionList}");
    update(["gamePlayingPage"]);
  }

  @override
  void onClose() {
    super.onClose();
    gameServerSocket.close();
  }
}