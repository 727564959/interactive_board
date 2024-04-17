import 'dart:convert';

import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../../../data/model/show_state.dart';
import 'data/game_over_info.dart';
import 'data/winner_api.dart';

class WinnerLogic extends GetxController {
  final winnerApi = WinnerApi();
  // 传参信息
  ShowState get showState => Get.arguments;
  // 游戏名
  String get gameName => ((Get.arguments as ShowState).details as GamingDetails).game;
  // 获胜队伍
  String winnerName = "";
  String jsonString = '''
    {
      "teamRecords": [
        {
          "teamId": 1,
          "score": 0,
          "rankScore": 5
        },
         {
            "teamId": 2,
            "score": 0,
            "rankScore": 7
        },
        {
            "teamId": 3,
            "score": 0,
            "rankScore": 10
        },
        {
            "teamId": 4,
            "score": 0,
            "rankScore": 3
        }
      ],
      "playerRecords": [
        {
          "rank": 1,
          "score": 1100,
          "tableId": 7,
          "playerId": 259,
          "position": 1
        },
        {
            "rank": 1,
            "score": 800,
            "tableId": 4,
            "playerId": 260,
            "position": 2
        },
        {
          "rank": 1,
          "score": 900,
          "tableId": 7,
          "playerId": 261,
          "position": 3
        },
        {
            "rank": 1,
            "score": 500,
            "tableId": 4,
            "playerId": 262,
            "position": 4
        },
        {
          "rank": 1,
          "score": 305,
          "tableId": 7,
          "playerId": 263,
          "position": 5
        },
        {
            "rank": 1,
            "score": 250,
            "tableId": 4,
            "playerId": 264,
            "position": 6
        },
        {
          "rank": 1,
          "score": 1000,
          "tableId": 7,
          "playerId": 265,
          "position": 7
        },
        {
            "rank": 1,
            "score": 360,
            "tableId": 4,
            "playerId": 266,
            "position": 8
        }
      ]
    }
  ''';

  @override
  void onInit() async {
    super.onInit();
    // 将JSON字符串解码为Map
    Map<String, dynamic> jsonData = json.decode(jsonString);
    // 创建RecordsData对象
    RecordsData recordsData = RecordsData.fromJson(jsonData);
    print("测试接收的数据：${recordsData}");
    print("测试接收的数据：${recordsData.teamRecords}");
    // 访问团队记录
    List<TeamRecord> teamRecords = recordsData.teamRecords;
    for (var teamRecord in teamRecords) {
      print('Team ID: ${teamRecord.teamId}');
      print('Score: ${teamRecord.score}');
      print('Rank Score: ${teamRecord.rankScore}');
      if(teamRecord.rankScore == 10) {
        winnerName= teamRecord.teamId.toString();
      }
    }

    Future.delayed(3.seconds).then((value) async {
      print("ssss: ${showState}");
      // 跳转到下一个游戏页面
      await Get.offAllNamed(AppRoutes.statisticsPage, arguments: showState);
    });
  }
}
