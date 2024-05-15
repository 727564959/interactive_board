import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common.dart';
import '../data/team_info.dart';

class CheckFlowLogic extends GetxController {
  final _dio = Dio();

  // 队伍icon合集
  List<TeamInfo> teamInfo = [];
  String teamName = "";
  int? teamInfoIndex;

  // 队伍icon选择，clickTeamName：当前点击icon名称；index：对应的teamInfo数组索引
  void selectTeamIcon(String clickTeamName, int index) {
    // 如果相等就置空，反之直接设置
    if(teamName == clickTeamName) {
      teamName = "";
      teamInfoIndex = null;
    }
    else {
      teamName = clickTeamName;
      teamInfoIndex = index;
    }
    update();
  }

  Future<List<TeamInfo>> fetchSelectableTeamInfo() async {
    final response = await _dio.get(
      "$baseApiUrl/team-icons",
      queryParameters: {"populate": "*", "filters[teamId][\$eq]": Global.tableId},
    );
    final result = <TeamInfo>[];
    for (final item in response.data["data"]) {
      result.add(TeamInfo.fromJson(item));
    }
    return result;
  }

  Future<void> updateTeamInfo(int showId, TeamInfo teamInfo) async {
    await _dio.post(
      "$baseApiUrl/shows/$showId/update-team-info",
      data: {
        "tableId": Global.tableId,
        "teamName": teamInfo.name,
        "teamIcon": teamInfo.icon,
        "noBorderIcon": teamInfo.noBorderIcon,
      },
    );
  }

  @override
  void onInit() async {
    try {
      teamInfo = await fetchSelectableTeamInfo();
      print("当前队伍能选择的队伍icon: ${teamInfo}");
    } catch (e) {
      print("查询队伍icon报错 $e");
    }
    update();
  }
}