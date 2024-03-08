import 'package:dio/dio.dart';
import 'package:interactive_board/pages/check_in/data/avatar_info.dart';

import '../../../common.dart';
import 'user_info.dart';

class CheckInApi {
  static CheckInApi? _instance;
  factory CheckInApi() => _instance ?? CheckInApi._internal();
  final dio = Dio();
  // final baseUrl = "http://10.1.4.13:1337/api/game-show";
  final baseUrl = "http://10.1.4.13:1337/api";
  CheckInApi._internal() {
    _instance = this;
  }

  Future<UserInfo> fetchUser(String id) async {
    final response = await dio.get(
      "$baseUrl/users/$id",
      queryParameters: {"populate[headgear][populate][0]": "avatar"},
    );
    return UserInfo.fromStrapiJson(response.data);
  }

  Future<List<UserInfo>> fetchUsers(int showId) async {
    print("是否进入了查询用户信息方法");
    print("$showId");
    final response = await dio.get(
      "$baseUrl/shows/$showId/players",
      queryParameters: {"tableId": Global.tableId},
    );
    // List userList = response.data['playerList'];
    print("测试接口 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }

  Future<Map> fetchSingleUsers(String id) async {
    print("是否进入了查询单个玩家方法");
    final response = await dio.get("$baseUrl/players/$id/base");
    print("测试接口 $response");

    Map<String, dynamic> result = response.data;
    return result;
  }

  Future<List<ResourceInfo>> fetchBodies() async {
    final response = await dio.get(
      "$baseUrl/bodies",
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
    final response = await dio.get(
      "$baseUrl/headgears",
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

  Future<void> updatePlayerInfo(String userId, String nickname, String headgearId, bool isMale) async {
    print("12345上山打老虎");
    final response = await dio.put(
      "$baseUrl/users/$userId",
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
    print("12345上山打老虎 $bodyId");
    final response = await dio.post(
      "$baseUrl/players/$userId/update-user-preference",
      data: {
        "nickname": nickname,
        "headgearId": headgearId,
        "bodyId": bodyId,
      },
    );
  }

  Future<void> addPlayerFun(int showId, int tableId, [String? email, String? phone, String? firstName, String? lastName]) async {
    // print("12345上山打老虎 ${tableId }");
    // print("12345上山打老虎 ${email }");
    // print("12345上山打老虎 ${phone }");
    // print("12345上山打老虎 ${firstName }");
    print("12345上山打老虎 ${lastName}");
    String userName = (firstName != null && lastName != null) ? (firstName + " " + lastName) : (
        (firstName != null ? firstName : (lastName != null ? lastName : ''))
    );
    final firstMap = tableId != null ? {"tableId": tableId} : {};
    // final secondMap = firstName != null ? {"username": firstName} : {};
    // final thirdlyMap = lastName != null ? {"nickname": lastName} : {};
    final secondMap = userName != null ? {"username": userName} : {};
    final thirdlyMap = firstName != null ? {"nickname": firstName} : {};
    final fourthlyMap = phone != null ? {"phone": phone} : {};
    final fifthMap = email != null ? {"email": email} : {};
    final result = {
      ...firstMap,
      ...secondMap,
      ...thirdlyMap,
      ...fourthlyMap,
      ...fifthMap,
    };
    print("哈哈哈哈哈 $result");
    await dio.post("$baseUrl/shows/$showId/player-joined",
        data: result);

    // try {
    //   await dio.post("http://10.1.4.13:1337/api/shows/3/player-joined",
    //       data: result);
    // } catch (e) {
    //   print("asassas $e");
    // }
  }
}
