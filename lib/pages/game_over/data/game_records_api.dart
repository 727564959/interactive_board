import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:interactive_board/pages/game_over/data/SettlementInfo.dart';
import 'game_records.dart';
import 'team_score.dart';

class GameRecordsApi {
  static GameRecordsApi? _instance;
  factory GameRecordsApi() => _instance ?? GameRecordsApi._internal();
  final dio = Dio();
  // final baseUrl = "http://10.1.4.13:1337/api/game-show";
  final baseUrl = "http://www.mir2021.xyz:1337/api/game-show";
  GameRecordsApi._internal() {
    _instance = this;
  }

  Future<List<GameRecords>> fetchRecords(int roundId) async {
    final response = await dio.get(
      "$baseUrl/round/records",
      queryParameters: {"roundId": roundId},
    );
    // print("showRepository.roundId ${showRepository.roundId}");
    // print("response $response");

    List playerRecords = response.data['playerRecords'];

    // final result = <SettlementInfo>[];
    // for (final item in response.data['playerRecords']) {
    //   print("item $item");
    //   result.add(SettlementInfo(
    //       username: item['player']['username'],
    //       nickname: item['player']['nickname'],
    //       // tableId: int.parse(item['player']['tableId']),
    //       tableId: item['player']['tableId'],
    //       avatarUrl: item['player']['avatarUrl'],
    //       // team: int.parse(item['player']['team']),
    //       team: item['player']['team'],
    //       // position: int.parse(item['player']['position']),
    //       // rank: int.parse(item['gameRecord']['rank']),
    //       // score: int.parse(item['gameRecord']['score'])));
    //       position: item['player']['position'],
    //       rank: item['gameRecord']['rank'],
    //       score: item['gameRecord']['score']));
    // }
    // print("result $result");
    // result.sort((a, b) => a.tableId - b.tableId);
    // print("result sort $result");
    // List playerRecords = result;
    // playerRecords = playerRecords.sort((a, b) => a.tableId - b.tableId);

    // print("playerRecords $playerRecords");
    return playerRecords.map((item) => GameRecords.fromJson(item)).toList();
  }

  // Future<List<TeamScore>> fetchTeamScore() async {
  Future<String> fetchTeamScore(int roundId) async {
    final response = await dio.get(
      "$baseUrl/round/records",
      queryParameters: {"roundId": roundId},
    );
    // print("response $response");
    // print("teamScore ${response.data['teamScore']}");
    // List teamScore = response.data['teamScore'];
    // Object teamScore = response.data['teamScore'];
    final redScore = response.data['teamScore']['red'];
    final blueScore = response.data['teamScore']['blue'];
    // print("new teamScore $teamScore");
    // print("new teamScore $redScore");
    // print("new teamScore $blueScore");
    String teamScore = redScore > blueScore ? "Team Wolf" : "Team Shark";
    return teamScore;
    // return teamScore;
    // return teamScore.map((item) => TeamScore.fromJson(item)).toList();
  }
}
