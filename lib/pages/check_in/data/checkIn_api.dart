import 'package:dio/dio.dart';
import 'package:interactive_board/pages/check_in/data/avatar_info.dart';
import 'package:interactive_board/pages/check_in/data/team_info.dart';

import '../../../common.dart';
import 'user_info.dart';

class CheckInApi {
  static CheckInApi? _instance;
  factory CheckInApi() => _instance ?? CheckInApi._internal();
  final dio = Dio();
  // final baseUrl = "http://10.1.4.13:1337/api/game-show";
  // final baseUrl = "http://10.1.4.16:1337/api";
  CheckInApi._internal() {
    _instance = this;
  }

  Future<UserInfo> fetchUser(String id) async {
    final response = await dio.get(
      "$baseApiUrl/users/$id",
      queryParameters: {"populate[headgear][populate][0]": "avatar"},
    );
    return UserInfo.fromStrapiJson(response.data);
  }

  Future<List<UserInfo>> fetchUsers(int showId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    final response = await dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {"tableId": Global.tableId},
    );
    // List userList = response.data['playerList'];
    print("测试接口 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }

  Future<Map> fetchSingleUsers(String id) async {
    print("是否进入了查询单个玩家方法");
    final response = await dio.get("$baseApiUrl/players/$id/base");
    print("测试接口 $response");

    Map<String, dynamic> result = response.data;
    return result;
  }

  Future<List<ResourceInfo>> fetchBodies() async {
    final response = await dio.get(
      "$baseApiUrl/bodies",
      queryParameters: {
        "populate[0]": "image",
      },
    );
    print(response.data);
    final result = <ResourceInfo>[];
    for (final item in response.data["data"]) {
      result.add(ResourceInfo.fromJson(item));
    }
    return result;
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

  Future<void> updatePlayerInfo(String userId, String nickname, String headgearId, bool isMale) async {
    print("12345上山打老虎");
    final response = await dio.put(
      "$baseApiUrl/users/$userId",
      data: {
        "nickname": nickname,
        "headgear": headgearId,
        "isMale": isMale,
      },
    );
  }

  Future<void> updatePlayer(int userId, String nickname, int headgearId, int bodyId) async {
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

  // 查重
  Future<Map> checkingPlayer(String email) async {
    print("通过邮箱进行玩家查重");
    print("object $email");
    try {
      final response = await dio.get(
        "$baseApiUrl/players/query-id",
        queryParameters: {"email": email},
      );
      print("object $response");
      Map<String, dynamic> result = response.data;
      return result;
    } on DioException {
      Map<String, dynamic> result = {};
      return result;
    }
  }

  // 正常添加玩家
  Future<void> addPlayerFun(int tableId,
      [String? email, String? phone, String? firstName, String? lastName, String? birthday]) async {
    // print("12345上山打老虎 ${showId }");
    // print("12345上山打老虎 ${email }");
    // print("12345上山打老虎 ${phone }");
    // print("12345上山打老虎 ${firstName }");
    // print("12345上山打老虎 ${lastName}");
    String userName = (firstName != null && lastName != null)
        ? (firstName + " " + lastName)
        : ((firstName != null ? firstName : (lastName != null ? lastName : '')));
    final firstMap = tableId != null ? {"tableId": tableId} : {};
    // final secondMap = firstName != null ? {"username": firstName} : {};
    // final thirdlyMap = lastName != null ? {"nickname": lastName} : {};
    // final secondMap = userName != null ? {"username": userName} : {};
    // final thirdlyMap = firstName != null ? {"nickname": firstName} : {};
    final secondMap = userName != null ? {"name": userName} : {};
    final fourthlyMap = phone != null ? {"phone": phone} : {};
    final fifthMap = email != null ? {"email": email} : {};
    final sixthMap = birthday != null ? {"birthday": birthday} : {};
    final result = {
      ...firstMap,
      ...secondMap,
      // ...thirdlyMap,
      ...fourthlyMap,
      ...fifthMap,
      ...sixthMap,
    };
    print("哈哈哈哈哈 $result");
    // final response = await dio.post("$baseUrl/shows/$showId/player-joined",
    //     data: result);
    final response = await dio.post("$baseApiUrl/players/register", data: result);

    print(response.data);
    return response.data;
  }

  // 添加玩家时，点击了跳过
  Future<void> addSkipPlayer() async {
    final response = await dio.post("$baseApiUrl/players/register-temp", data: {});
    print(response.data);
    return response.data;
  }

  // 玩家加入show
  Future<void> addPlayerToShow(int showId, int tableId, int userId) async {
    final firstMap = tableId != null ? {"tableId": tableId} : {};
    final secondMap = userId != null ? {"userId": userId} : {};
    final result = {
      ...firstMap,
      ...secondMap,
    };
    await dio.post("$baseApiUrl/shows/$showId/player-joined", data: result);
    print("哈哈哈哈哈 $result");
  }
  // 查询当前的游戏show状态
  // Future<ShowState> fetchShowState() async {
  //   final response = await dio.get("http://$baseApiUrl/show/state");
  //   return ShowState.fromJson(response.data);
  // }

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

  Future<List<TeamInfo>> fetchSelectableTeamInfo() async {
    final response = await dio.get(
      "$baseStrapiUrl/team-icons",
      queryParameters: {"populate[0]": "icon", "filters[teamId][\$eq]": Global.tableId},
    );
    final result = <TeamInfo>[];
    for (final item in response.data["data"]) {
      result.add(TeamInfo.fromJson(item));
    }
    return result;
  }

  Future<void> updateTeamInfo(int showId, TeamInfo teamInfo) async {
    await dio.post(
      "$baseStrapiUrl/shows/$showId/update-team-info",
      data: {
        "tableId": Global.tableId,
        "teamName": teamInfo.name,
        "teamIcon": teamInfo.icon,
      },
    );
  }
}
