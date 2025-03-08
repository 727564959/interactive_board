import 'package:dio/dio.dart';

import '../../../common.dart';
import 'avatar_info.dart';
import 'casual_user.dart';
import 'user_info.dart';
import 'team_info.dart';

class PlayerPageApi {
  static PlayerPageApi? _instance;
  factory PlayerPageApi() => _instance ?? PlayerPageApi._internal();
  final dio = Dio();

  PlayerPageApi._internal() {
    _instance = this;
  }

  Future<List<UserInfo>> fetchUsers(int showId, int tableId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    final response = await dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {"tableId": tableId},
    );
    // List userList = response.data['playerList'];
    print("测试接口 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }

  Future<List<CasualUser>> fetchCasualUser(int showId, int tableId) async {
    print("是否进入了查询临时用户信息方法");
    print("$showId");
    final response = await dio.get(
      "$baseApiUrl/shows/$showId/check-in/players",
      queryParameters: {"tableId": tableId},
    );
    print("临时用户 $response");
    List casualUser = response.data;
    // List casualUser = [
    //   {
    //     "userId": 267,
    //     "nickname": "M_Zq",
    //     "bTemped": false,
    //     "bShowRegisterDialog": false
    //   },
    //   {
    //     "userId": 266,
    //     "nickname": "player8649",
    //     "bTemped": true,
    //     "bShowRegisterDialog": false
    //   },
    //   {
    //     "userId": 260,
    //     "nickname": "player1650",
    //     "bTemped": true,
    //     "bShowRegisterDialog": false
    //   }
    // ];
    return casualUser.map((user) => CasualUser.fromJson(user)).toList();
  }

  Future<List<ResourceInfo>> fetchAvatars() async {
    print("获取头像信息接口");
    final response = await dio.get(
      "$baseApiUrl/game-items",
      queryParameters: {
        "populate[0]": "icon",
      },
    );
    print(response.data);
    final result = <ResourceInfo>[];
    for (final item in response.data["data"]) {
      result.add(ResourceInfo.fromJson(item));
    }
    return result;
  }

  Future<List<GameItemInfo>> fetchUserGameItems(userId) async {
    final response = await dio.get(
      "$baseApiUrl/players/$userId/game-items",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item['gameItem']));
    }
    return result;
  }

  Future<UserInfo> fetchUserResource(userId) async {
    final response = await dio.get(
      "$baseApiUrl/players/$userId/resource",
    );
    return UserInfo.fromJson(response.data);
  }

  // 查询队伍信息
  Future<List<TeamInfo>> fetchTeamInfo(int showId) async {
    print("是否进入了查询队伍信息方法");
    print("$showId");
    final response = await dio.get(
        "$baseApiUrl/shows/$showId/team-info"
    );
    print("所有队伍信息 $response");
    List teamList = response.data;
    return teamList.map((team) => TeamInfo.fromJson(team)).toList();
  }

  // 查询并清理头套
  Future<List<GameItemInfo>> fetchHeadgearInfo(userId) async {
    final response = await dio.get(
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
    final response = await dio.get(
      "$baseApiUrl/headgears/limited",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item['gameItem']));
    }
    return result;
  }

  // 查询万圣节头套
  // Future<List<GameItemInfo>> fetchHallowmas() async {
  //   final response = await dio.get(
  //     "$baseApiUrl/headgears/hallowmas",
  //   );
  //   final result = <GameItemInfo>[];
  //   for (final item in response.data) {
  //     result.add(GameItemInfo.fromJson(item['gameItem']));
  //   }
  //   return result;
  // }
}
