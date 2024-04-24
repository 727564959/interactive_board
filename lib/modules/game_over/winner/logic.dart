import 'dart:convert';

import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../../../data/model/show_state.dart';
import 'data/game_over_info.dart';
import 'data/winner_api.dart';

class WinnerLogic extends GetxController {
  final winnerApi = WinnerApi();
  // 传参信息
  ShowState get showState => Get.arguments["showState"];

  // 游戏名
  String get gameName => (showState.details as GamingDetails).game;
  late final RecordsData recordsData;
  // 获胜队伍
  String winnerName = "";

  @override
  void onInit() async {
    super.onInit();
    // 创建RecordsData对象
    recordsData = RecordsData.fromJson(Get.arguments["records"]);
    print("测试接收的数据：${recordsData}");
    print("测试接收的数据：${recordsData.teamRecords}");
    // 访问团队记录
    List<TeamRecord> teamRecords = recordsData.teamRecords;
    for (var teamRecord in teamRecords) {
      print('Team ID: ${teamRecord.teamId}');
      print('Score: ${teamRecord.score}');
      print('Rank Score: ${teamRecord.rankScore}');
      if (teamRecord.rankScore == 10) {
        winnerName = teamRecord.teamId.toString();
      }
    }

    Future.delayed(3.seconds).then((value) async {
      print("ssss: ${showState}");
      // 跳转到下一个游戏页面
      // await Get.offAllNamed(AppRoutes.statisticsPage, arguments: showState);
      await Get.offAllNamed(AppRoutes.statisticsPage, arguments: {"showState": showState, "records": recordsData});
    });
  }
}
