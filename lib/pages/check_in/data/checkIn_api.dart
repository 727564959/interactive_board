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
      "http://10.1.4.13:1337/api/users/$id",
      queryParameters: {"populate[headgear][populate][0]": "avatar"},
    );
    return UserInfo.fromStrapiJson(response.data);
  }

  Future<List<UserInfo>> fetchUsers() async {
    print("是否进入了查询用户信息方法");

    final response = await dio.get(
      "$baseUrl/shows/3/players",
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
      "http://10.1.4.13:1337/api/bodies",
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
      "http://10.1.4.13:1337/api/headgears",
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

  Future<void> updatePlayerInfo(
      String userId, String nickname, String headgearId, bool isMale) async {
    print("12345上山打老虎");
    final response = await dio.put(
      "http://10.1.4.13:1337/api/users/$userId",
      data: {
        "nickname": nickname,
        "headgear": headgearId,
        "isMale": isMale,
      },
    );
  }

  Future<void> updatePlayer(
      int userId, String nickname, int headgearId, int bodyId) async {
    // print("12345上山打老虎 $userId");
    // print("12345上山打老虎 $nickname");
    // print("12345上山打老虎 $headgearId");
    print("12345上山打老虎 $bodyId");
    final response = await dio.post(
      "http://10.1.4.13:1337/api/players/$userId/update-user-preference",
      data: {
        "nickname": nickname,
        "headgearId": headgearId,
        "bodyId": bodyId,
      },
    );
  }

  Future<void> addPlayerFun(int tableId, [String? email, String? phone,
      String? firstName, String? lastName]) async {
    // print("12345上山打老虎 ${tableId }");
    // print("12345上山打老虎 ${email }");
    // print("12345上山打老虎 ${phone }");
    // print("12345上山打老虎 ${firstName }");
    print("12345上山打老虎 ${lastName }");
    // final result = {
    //   "tableId": tableId,
    //   "username": firstName,
    //   "nickname": lastName,
    //   "phone": phone,
    //   "email": email,
    // };
    final firstMap = tableId != null ? {"tableId": tableId} : {};
    final secondMap  = firstName != null ? {"username": firstName} : {};
    final thirdlyMap = lastName != null ? {"nickname": lastName} : {};
    final fourthlyMap = phone != null ? {"phone": phone} : {};
    final fifthMap = email != null ? {"email": email} : {};
    final result = {
      ...firstMap,
      ...secondMap,
      ...thirdlyMap,
      ...fourthlyMap,
      ...fifthMap,
    };
    print("$result");
    try {
      await dio.post(
        "http://10.1.4.13:1337/api/shows/3/player-joined",
        // data: {
        //   "tableId": tableId,
        //   "username": firstName,
        //   "nickname": lastName,
        //   "phone": phone,
        //   "email": email,
        // },
        data: result
      );
    } catch (e) {
      print("asassas $e");
    }
  }
}
