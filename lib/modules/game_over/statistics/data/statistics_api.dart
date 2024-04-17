import 'package:dio/dio.dart';

import '../../../../common.dart';
import './user_info.dart';
import 'team_info.dart';

class StatisticsApi {
  static StatisticsApi? _instance;

  factory StatisticsApi() => _instance ?? StatisticsApi._internal();
  final dio = Dio();

  StatisticsApi._internal() {
    _instance = this;
  }
  // 查询所有玩家
  Future<List<UserInfo>> fetchUsers(int showId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    print("${Global.tableId}");
    final response = await dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {"tableId": Global.tableId},
    );
    // List userList = response.data['playerList'];
    print("所有用户信息 $response");
    // List userList = response.data;
    List userList = [
      {
        "id": 259,
        "nickname": "player5778",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      },{
        "id": 260,
        "nickname": "testUser1",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      },{
        "id": 261,
        "nickname": "testUser2",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      },{
        "id": 262,
        "nickname": "hahhahah",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      },{
        "id": 263,
        "nickname": "1111yyyyyy",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      },{
        "id": 264,
        "nickname": "kkhkhk1",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      },{
        "id": 265,
        "nickname": "teststss",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      },{
        "id": 266,
        "nickname": "mmbmbmmbmb",
        "avatarUrl": "/uploads/TV_00b57f3012.png",
        "gameResource": {
          "headgearId": 2,
          "headgearName": "TV",
          "bodyId": 12,
          "bodyName": "Male_Suit_01"
        },
        "joinedCount": 1
      }
    ];
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }
  // 查询单个玩家
  Future<Map> fetchSingleUsers(String id) async {
    print("是否进入了查询单个玩家方法");
    final response = await dio.get("$baseApiUrl/players/$id/base");
    print("单个用户信息 $response");

    Map<String, dynamic> result = response.data;
    return result;
  }
  // 查询队伍信息
  Future<List<TeamInfo>> fetchTeamInfo(int showId) async {
    print("是否进入了查询队伍信息方法");
    print("$showId");
    final response = await dio.get(
      "$baseApiUrl/shows/$showId/team-info"
    );
    print("所有队伍信息 $response");
    // List teamList = response.data;
    List teamList = [
      {
        "name": "RABBIT",
        "teamId": 4,
        "iconPath": "/uploads/small_4_1_60b4f861f0.png",
        "blackBorderIconPath": "/uploads/small_4_d_98061c3869.png"
      },
      {
        "name": "FOX",
        "teamId": 3,
        "iconPath": "/uploads/small_7_1_a7c103d0e9.png",
        "blackBorderIconPath": "/uploads/small_6_ae8a8ebc93.png"
      },
      {
        "name": "OCTOPUS",
        "teamId": 1,
        "iconPath": "/uploads/small_5_1_e13aa570c9.png",
        "blackBorderIconPath": "/uploads/small_5_c2f92745e6.png"
      },
      {
        "name": "PANTHER",
        "teamId": 2,
        "iconPath": "/uploads/small_2_1_a830d6e873.png",
        "blackBorderIconPath": "/uploads/small_2_d_55cb963c79.png"
      }
    ];
    return teamList.map((team) => TeamInfo.fromJson(team)).toList();
  }
}