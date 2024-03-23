import 'package:dio/dio.dart';

import '../../../common.dart';
import '../../../data/model/show_state.dart';
import '../../../pages/check_in/data/avatar_info.dart';
import 'user_info.dart';

class SetAvatarApi {
  static SetAvatarApi? _instance;

  factory SetAvatarApi() => _instance ?? SetAvatarApi._internal();
  final dio = Dio();
  // final baseUrl = "http://10.1.4.16:1337/api";

  SetAvatarApi._internal() {
    _instance = this;
  }
  // 查询单个玩家信息
  Future<Map> fetchSingleUsers(String id) async {
    print("是否进入了查询单个玩家方法");
    final response = await dio.get("$baseApiUrl/players/$id/base");
    print("单个用户信息 $response");
    Map<String, dynamic> result = response.data;
    return result;
  }
  // 查询所有玩家
  Future<List<UserInfo>> fetchUsers(int showId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    final response = await dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {"tableId": Global.tableId},
    );
    // List userList = response.data['playerList'];
    print("用户数据 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }
  // 返回头像信息
  Future<List<ResourceInfo>> fetchAvatars() async {
    print("获取头像信息接口");
    final response = await dio.get(
      "$baseApiUrl/game-items",
      queryParameters: {
        "populate[0]": "icon",
      },
    );
    print("头像数据：${response.data}");
    final result = <ResourceInfo>[];
    for (final item in response.data["data"]) {
      result.add(ResourceInfo.fromJson(item));
    }
    return result;
  }
  // 更新玩家的形象
  Future<void> updatePlayer(int userId, String nickname, int headgearId,
      int bodyId) async {
    // print("12345上山打老虎 $userId");
    // print("12345上山打老虎 $nickname");
    // print("12345上山打老虎 $headgearId");
    // print("12345上山打老虎 $bodyId");
    final response = await dio.post(
      "$baseApiUrl/players/$userId/update-user-preference",
      data: {
        "nickname": nickname,
        "headgearId": headgearId,
        "bodyId": bodyId,
      },
    );
  }
  // 查询当前的游戏show状态
  Future<ShowState> fetchShowState() async {
    final response = await dio.get("$baseApiUrl/show/state");
    return ShowState.fromJson(response.data);
  }

  Future<List<GameItemInfo>> fetchUserGameItems(userId) async {
    final response = await dio.get(
      "$baseApiUrl/players/$userId/game-items",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item));
    }
    return result;
  }
}