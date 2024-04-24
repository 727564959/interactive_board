import 'dart:convert';

import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../../../data/model/show_state.dart';
import '../winner/data/game_over_info.dart';
import 'data/player_bar.dart';
import 'data/statistics_api.dart';
import 'data/team_bar.dart';
import 'data/team_info.dart';
import 'data/user_info.dart';

enum PageState { playerStatistics, teamStatistics }

class StatisticsLogic extends GetxController {
  final statisticsApi = StatisticsApi();
  // 用于测试的数据
  // String jsonString = '''
  //   {
  //     "teamRecords": [
  //       {
  //         "teamId": 1,
  //         "score": 0,
  //         "rankScore": 5
  //       },
  //        {
  //           "teamId": 2,
  //           "score": 0,
  //           "rankScore": 7
  //       },
  //       {
  //           "teamId": 3,
  //           "score": 0,
  //           "rankScore": 10
  //       },
  //       {
  //           "teamId": 4,
  //           "score": 0,
  //           "rankScore": 3
  //       }
  //     ],
  //     "playerRecords": [
  //       {
  //         "rank": 1,
  //         "score": 1100,
  //         "tableId": 7,
  //         "playerId": 259,
  //         "position": 1
  //       },
  //       {
  //           "rank": 4,
  //           "score": 800,
  //           "tableId": 4,
  //           "playerId": 260,
  //           "position": 2
  //       },
  //       {
  //         "rank": 3,
  //         "score": 900,
  //         "tableId": 7,
  //         "playerId": 261,
  //         "position": 3
  //       },
  //       {
  //           "rank": 5,
  //           "score": 500,
  //           "tableId": 4,
  //           "playerId": 262,
  //           "position": 4
  //       },
  //       {
  //         "rank": 7,
  //         "score": 305,
  //         "tableId": 7,
  //         "playerId": 263,
  //         "position": 5
  //       },
  //       {
  //           "rank": 8,
  //           "score": 198,
  //           "tableId": 4,
  //           "playerId": 264,
  //           "position": 6
  //       },
  //       {
  //         "rank": 2,
  //         "score": 1000,
  //         "tableId": 7,
  //         "playerId": 265,
  //         "position": 7
  //       },
  //       {
  //           "rank": 6,
  //           "score": 360,
  //           "tableId": 4,
  //           "playerId": 266,
  //           "position": 8
  //       }
  //     ]
  //   }
  // ''';
  // 用户数据
  List<UserInfo> userList = [];
  // 队伍数据
  List<TeamInfo> teamList = [];
  // 传参信息
  ShowState get showState => Get.arguments["showState"];
  // 访问团队记录
  List<TeamRecord> teamRecords = [];
  // 访问玩家记录
  List<PlayerRecord> playerRecords = [];
  // 用户统计图数据
  final resultPlayerRecord = <PlayerBar>[];
  // 队伍统计图数据
  final resultTeamRecord = <TeamBar>[];
  // 游戏名称
  String get gameName => (showState.details as GamingDetails).game;
  // 默认展示页面
  PageState pageState = PageState.playerStatistics;
  int delayedTime = 5;

  void updatePlayerRecord() async {
    // 获取用户信息
    userList = await statisticsApi.fetchUsers(showState.showId ?? 1);
    print("用户数据: $userList");
    // 获取用户信息
    teamList = await statisticsApi.fetchTeamInfo(showState.showId ?? 1);
    print("队伍数据: $teamList");
    // 将JSON字符串解码为Map
    // Map<String, dynamic> jsonData = json.decode(jsonString);
    // 创建RecordsData对象
    RecordsData recordsData = RecordsData.fromJson(Get.arguments["records"]);
    print("测试接收的数据：${recordsData}");
    print("测试接收的数据：${recordsData.teamRecords}");
    // 访问玩家记录
    playerRecords = recordsData.playerRecords;
    for (var playerRecord in playerRecords) {
      print('Rank: ${playerRecord.rank}');
      print('Score: ${playerRecord.score}');
      print('Table ID: ${playerRecord.tableId}');
      print('Player ID: ${playerRecord.playerId}');
      print('Position: ${playerRecord.position}');

      final player = userList.firstWhere((element) => element.id == playerRecord.playerId.toString());
      // final team = teamList.firstWhere((element) => element.teamId == playerRecord.position);
      resultPlayerRecord.add(PlayerBar(
          id: player.id,
          nickname: player.nickname,
          avatarUrl: player.avatarUrl,
          rank: playerRecord.rank,
          score: playerRecord.score,
          tableId: playerRecord.tableId,
          playerId: playerRecord.playerId,
          position: playerRecord.position));
    }
    print('玩家玩家玩家玩家 $resultPlayerRecord');

    update();
  }

  void delayedFun() async {
    Future.delayed(delayedTime.seconds).then((value) async {
      print("delayedTime logic $delayedTime");
      if (pageState == PageState.playerStatistics) {
        print("跳转 $pageState");
        delayedTime = 5;
        pageState = PageState.teamStatistics;
        update(['statisticsPage']);
      } else if (pageState == PageState.teamStatistics) {
        print("团队统计");
        delayedTime = 5;
        // update(['statisticsPage']);
        // print("12345上山打老虎");
        // 跳转到下一个游戏页面
        await Get.offAllNamed(AppRoutes.nextGame, arguments: showState);
      }
    });
  }

  @override
  void onInit() async {
    super.onInit();

    // 获取用户信息
    userList = await statisticsApi.fetchUsers(showState.showId ?? 1);
    print("用户数据: $userList");
    // 获取用户信息
    teamList = await statisticsApi.fetchTeamInfo(showState.showId ?? 1);
    print("队伍数据: $teamList");
    // 将JSON字符串解码为Map
    // Map<String, dynamic> jsonData = json.decode(jsonString);
    // 创建RecordsData对象
    RecordsData recordsData = RecordsData.fromJson(Get.arguments["records"]);
    print("测试接收的数据：${recordsData}");
    print("测试接收的数据：${recordsData.teamRecords}");
    // 访问团队记录
    teamRecords = recordsData.teamRecords;
    for (var teamRecord in teamRecords) {
      print('Team ID: ${teamRecord.teamId}');
      print('Score: ${teamRecord.score}');
      print('Rank Score: ${teamRecord.rankScore}');

      final team = teamList.firstWhere((element) => element.teamId == teamRecord.teamId);
      resultTeamRecord.add(TeamBar(
          teamId: teamRecord.teamId,
          score: teamRecord.score,
          rankScore: teamRecord.rankScore,
          name: team.name,
          iconPath: team.iconPath,
          blackBorderIconPath: team.blackBorderIconPath,
          rank: 0));
      // 按照rankScore字段进行排序
      resultTeamRecord.sort((a, b) => b.rankScore.compareTo(a.rankScore));
      // 设置排序号字段
      for (int i = 0; i < resultTeamRecord.length; i++) {
        resultTeamRecord[i].rank = i + 1;
      }
    }
    print('团队团队团队团队 $resultTeamRecord');
    // 访问玩家记录
    playerRecords = recordsData.playerRecords;
    for (var playerRecord in playerRecords) {
      print('Rank: ${playerRecord.rank}');
      print('Score: ${playerRecord.score}');
      print('Table ID: ${playerRecord.tableId}');
      print('Player ID: ${playerRecord.playerId}');
      print('Position: ${playerRecord.position}');

      final player = userList.firstWhere((element) => element.id == playerRecord.playerId.toString());
      // final team = teamList.firstWhere((element) => element.teamId == playerRecord.position);
      resultPlayerRecord.add(PlayerBar(
          id: player.id,
          nickname: player.nickname,
          avatarUrl: player.avatarUrl,
          rank: playerRecord.rank,
          score: playerRecord.score,
          tableId: playerRecord.tableId,
          playerId: playerRecord.playerId,
          position: playerRecord.position));
    }
    print('玩家玩家玩家玩家 $resultPlayerRecord');
    update(['statisticsPage']);

    this.delayedFun();

    // Future.delayed(delayedTime.seconds).then((value) async {
    //   print("delayedTime logic $delayedTime");
    //   if (pageState == PageState.playerStatistics) {
    //     print("跳转 $pageState");
    //     delayedTime = 5;
    //     pageState = PageState.teamStatistics;
    //     update(['statisticsPage']);
    //   } else if (pageState == PageState.teamStatistics) {
    //     print("团队统计");
    //     delayedTime = 3;
    //     update(['statisticsPage']);
    //     print("12345上山打老虎");
    //     // // 跳转到下一个游戏页面
    //     // await Get.toNamed(AppRoutes.nextGame, arguments: {});
    //   }
    // });
  }
}